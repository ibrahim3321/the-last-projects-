apiVersion: v1
kind: Secret
metadata:
  name: slack-webhook-url
  namespace: ${NAMESPACE}
type: Opaque
stringData:
  url: "${SLACK_WEBHOOK_URL}"
