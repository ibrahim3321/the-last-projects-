from flask import Flask, request, jsonify
import os, json, logging
import requests
from urllib.parse import urlencode

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)

PHONE  = os.getenv("CALLMEBOT_PHONE", "")
APIKEY = os.getenv("CALLMEBOT_APIKEY", "")
LANG   = os.getenv("CALLMEBOT_LANG", "en-US")

CALL_URL = "https://api.callmebot.com/call.php"

def parse_payload(req):
    """Return a list of alert dicts, regardless of Alertmanager v2 shape or array shape."""
    data = request.get_json(silent=True)
    if data is None:
        # Fallback parse if content-type not set correctly
        try:
            data = json.loads(request.data.decode("utf-8"))
        except Exception:
            app.logger.error("Unable to parse JSON body")
            return []

    # Alertmanager receiver shape: {"alerts":[...]}
    if isinstance(data, dict) and "alerts" in data and isinstance(data["alerts"], list):
        return data["alerts"]

    # Already a list of alerts
    if isinstance(data, list):
        return data

    # One alert object
    if isinstance(data, dict):
        return [data]

    return []

def build_text(alert):
    labels = alert.get("labels", {}) if isinstance(alert.get("labels", {}), dict) else {}
    ann    = alert.get("annotations", {}) if isinstance(alert.get("annotations", {}), dict) else {}

    name = labels.get("alertname") or "Alert"
    sev  = labels.get("severity", "info")
    team = labels.get("team", "")
    summary = ann.get("summary") or ann.get("description") or name

    text = f"[{sev.upper()}] {name}: {summary}"
    if team:
        text = f"(team:{team}) {text}"
    # CallMeBot can handle reasonably long strings, but keep it sane
    return text[:300]

def call_phone(text):
    params = {
        "phone": PHONE,
        "apikey": APIKEY,
        "lang": LANG,
        "text": text
    }
    url = f"{CALL_URL}?{urlencode(params)}"
    resp = requests.get(url, timeout=20)
    return resp.status_code, resp.text

@app.route("/healthz")
def health():
    return jsonify({"status": "ok"}), 200

@app.route("/webhook", methods=["POST"])
def webhook():
    if not PHONE or not APIKEY:
        app.logger.error("Missing CALLMEBOT_PHONE or CALLMEBOT_APIKEY env vars")
        return jsonify({"status": "error", "error": "adapter not configured"}), 500

    alerts = parse_payload(request)
    if not alerts:
        return jsonify({"status": "error", "error": "no alerts parsed"}), 400

    results = []
    for alert in alerts:
        if not isinstance(alert, dict):
            app.logger.warning("Skipping non-dict alert: %r", alert)
            continue
        text = build_text(alert)
        code, body = call_phone(text)
        ok = (200 <= code < 300) and ("OK" in body or "ok" in body.lower() or "success" in body.lower())
        app.logger.info("CallMeBot resp code=%s body=%s", code, body.strip()[:200])
        results.append({"text": text, "status_code": code, "body": body, "ok": ok})

    overall_ok = any(r["ok"] for r in results)
    return (jsonify({"status": "ok", "results": results}), 200) if overall_ok \
           else (jsonify({"status": "error", "results": results}), 502)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
