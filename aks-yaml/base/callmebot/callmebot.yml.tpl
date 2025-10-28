apiVersion: apps/v1
kind: Deployment
metadata:
  name: callmebot-adapter
  namespace: ${NAMESPACE_MON}
  labels: { app: callmebot-adapter }
spec:
  replicas: 1
  selector: { matchLabels: { app: callmebot-adapter } }
  template:
    metadata:
      labels: { app: callmebot-adapter }
    spec:
      containers:
        - name: adapter
          image: ${ACR_LOGIN_SERVER}/callmebot-adapter:${CALLMEBOT_TAG}
          ports: [{ containerPort: 8080 }]
          env:
            - name: CALLMEBOT_BASE_URL
              valueFrom: { secretKeyRef: { name: callmebot-config, key: base_url } }
            - name: CALLMEBOT_PHONE
              valueFrom: { secretKeyRef: { name: callmebot-config, key: phone } }
            - name: CALLMEBOT_APIKEY
              valueFrom: { secretKeyRef: { name: callmebot-config, key: apikey } }
          readinessProbe:
            httpGet: { path: /healthz, port: 8080 }
            initialDelaySeconds: 3
          livenessProbe:
            httpGet: { path: /healthz, port: 8080 }
            initialDelaySeconds: 10
---
apiVersion: v1
kind: Service
metadata:
  name: callmebot-adapter
  namespace: ${NAMESPACE_MON}
spec:
  selector: { app: callmebot-adapter }
  ports:
    - name: http
      port: 8080
      targetPort: 8080
