# polar-deployment


minikube start --cpus 2 --memory 4g --driver docker --profile polar

minikube start --cpus 2 --memory 4g --driver docker --profile polar
minikube addons enable ingress --profile polar
kubectl get all -n ingress-nginx

minikube image load catalog-service --profile polar

kubectl config get-contexts


kubectl logs deployment/polar-postgres

kubectl port-forward service/catalog-service 9002:80

minikube stop --profile polar


kubectl logs deployment/config-service
kubectl logs deployment/catalog-service

kubectl apply -f k8s/deployment.yml
kubectl delete -f k8s/deployment.yml





kubectl get pods

kubectl port-forward service/polar-postgres 5432:5432
