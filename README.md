


# polar-deployment




## Chapter - 5
---------------

docker run -d \
--name polar-postgres \
-e POSTGRES_USER=user \
-e POSTGRES_PASSWORD=password \
-e POSTGRES_DB=polardb_catalog \
-p 5432:5432 \
postgres:14.4











----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

minikube start --cpus 2 --memory 4g --driver docker --profile polar

minikube stop --profile polar


kubectl create secret docker-registry ghcr-login-secret --docker-server=https://ghcr.io --docker-username=codingkiddo --docker-password=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 --docker-email=codingkiddo@gmail.com

minikube addons enable ingress --profile polar

kubectl get all -n ingress-nginx

kubectl config get-contexts

minikube image load edge-service --profile polar
minikube image load ghcr.io/codingkiddo/edge-service --profile polar
minikube image load order-service --profile polar
minikube image load ghcr.io/codingkiddo/order-service --profile polar
minikube image load config-service --profile polar
minikube image load ghcr.io/codingkiddo/config-service --profile polar
minikube image load catalog-service --profile polar
minikube image load ghcr.io/codingkiddo/catalog-service --profile polar



kubectl describe pod config-service-597f568647-5b7bt


kubectl logs deployment/polar-postgres

kubectl port-forward service/catalog-service 9002:80

minikube stop --profile polar


kubectl logs deployment/config-service
kubectl logs deployment/edge-service
kubectl logs deployment/order-service
kubectl logs deployment/catalog-service

kubectl apply -f k8s/deployment.yml
kubectl delete -f k8s/deployment.yml





kubectl get pods

kubectl port-forward service/polar-postgres 5432:5432




$ minikube stop --profile polar
$ minikube delete --profile polar




docker ps -aqf "name=polar-postgres"
https://stackoverflow.com/questions/37694987/connecting-to-postgresql-in-a-docker-container-from-outside



kubectl exec -it polar-postgres-6f8c74665c-8js2d -- psql -U compose-postgres polardb_catalog
psql (14.4 (Debian 14.4-1.pgdg110+1))
Type "help" for help.

polardb_catalog=# \dt
                     List of relations
 Schema |         Name          | Type  |      Owner       
--------+-----------------------+-------+------------------
 public | abcd                  | table | compose-postgres
 public | flyway_schema_history | table | compose-postgres
(2 rows)


http POST :9002/books author="Jon Snow" title="All I don't know about the Arctic" isbn="1234567897" price=9.90 publisher="Polarsophia"
http POST :9003/orders isbn=1234567897 quantity=3
http :9003/orders


https://stackoverflow.com/questions/53663954/trouble-connecting-to-postgres-from-outside-kubernetes-cluster
https://dev.to/asizikov/using-github-container-registry-with-kubernetes-38fb




docker ps

CONTAINER ID   IMAGE                              COMMAND                  CREATED          STATUS          PORTS                              NAMES
0e380ab9ea49   quay.io/keycloak/keycloak:23.0.5   "/opt/keycloak/bin/k…"   33 seconds ago   Up 32 seconds   0.0.0.0:8080->8080/tcp, 8443/tcp   polar-keycloak


docker exec -it polar-keycloak bash


cd /opt/keycloak/bin


./kcadm.sh config credentials \
--server http://localhost:8080 \
--realm master \
--user user \
--password password


./kcadm.sh create realms -s realm=PolarBookshop -s enabled=true
./kcadm.sh create roles -r PolarBookshop -s name=employee
./kcadm.sh create roles -r PolarBookshop -s name=customer


./kcadm.sh create users -r PolarBookshop \
-s username=isabelle \
-s firstName=Isabelle \
-s lastName=Dahl \
-s enabled=true

./kcadm.sh add-roles -r PolarBookshop \
--uusername isabelle \
--rolename employee \
--rolename customer


./kcadm.sh create users -r PolarBookshop \
-s username=bjorn \
-s firstName=Bjorn \
-s lastName=Vinterberg \
-s enabled=true

./kcadm.sh add-roles -r PolarBookshop \
--uusername bjorn \
--rolename customer


./kcadm.sh set-password -r PolarBookshop \
--username isabelle --new-password password

./kcadm.sh set-password -r PolarBookshop \
--username bjorn --new-password password


./kcadm.sh config credentials --server http://localhost:8080 --realm master --user user --password password

./kcadm.sh create clients -r PolarBookshop \
-s clientId=edge-service \
-s enabled=true \
-s publicClient=false \
-s secret=polar-keycloak-secret \
-s 'redirectUris=["http://localhost:9000", "http://localhost:9000/login/oauth2/code/*"]'




docker-compose up polar-redis polar-keycloak

docker-compose up polar-ui polar-keycloak polar-redis polar-postgres

pack build polar-ui \
  --buildpack gcr.io/paketo-buildpacks/nginx \
  --builder 




curl -b --user bjorn:password http://localhost:8080/realms/PolarBookshop/login-actions/authenticate?session_code=TYf8STPllWDkDSP8XXlIPHV_OMPnsZDG6cDXWSai040&amp;execution=3b67d4a7-719c-4b3c-8868-d442f5f895ce&amp;client_id=edge-service&amp;tab_id=VKg7pXFYoB4