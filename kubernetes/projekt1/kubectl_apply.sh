kubectl apply -f secret.yaml
kubectl describe secret mysql-secret-password
kubectl apply -f mysql.yaml
kubectl get deployments -o wide
kubectl get pods -o wide
kubectl get services -o wide
kubectl apply -f wordpress.yaml
