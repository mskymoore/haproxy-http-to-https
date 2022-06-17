# Haproxy http to https redirect container
### [github repository](https://github.com/mskymoore/haproxy-http-to-https)

- Listens on port 80
- Redirects traffic to same url or address, but on port 443

## docker compose example
```yaml
---
version: "3"
services:
    haproxy:
        container_name: haproxy-redirect
        image: skymoore/haproxy-http-to-https:latest
        ports:
        - "80:80"

    another-service:
        container_name: another-service
        image: service/another-service:latest
        ports:
        - "443:443"
```

## kubernetes example
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: deployment-name
  namespace: my-namespace
spec:
  replicas: 2
  selector:
    matchLabels:
      app: "myapp"
  template:
    metadata:
      namespace: my-namespace
      labels:
        app: myapp
    spec:
      containers:
        - name: another-service
          image: service/another-service:latest
          imagePullPolicy: Always
            - name: pod-app-port
              containerPort: 8000
              protocol: TCP        
        - name: haproxy-redirect
          image: skymoore/haproxy-http-to-https:latest
          imagePullPolicy: Always
          ports:
            - name: http-to-https
              containerPort: 80
              protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: another-service-lb
  namespace: my-namespace
spec:
  type: LoadBalancer
  selector:
    app: myapp
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: http-to-https
    - name: https
      protocol: TCP
      port: 443
      targetPort: pod-app-port           
    
```