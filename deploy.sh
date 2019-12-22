docker build -t yujishen/multi-client:latest -t yujishen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yujishen/multi-server:latest -t yujishen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yujishen/multi-worker:latest -t yujishen/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push yujishen/multi-client:latest
docker push yujishen/multi-server:latest
docker push yujishen/multi-worker:latest
docker push yujishen/multi-client:$SHA
docker push yujishen/multi-server:$SHA
docker push yujishen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=yujishen/multi-server:$SHA
kubectl set image deployments/client-deployments client=yujishen/multi-client:$SHA
kubectl set image deployments/workder-deployments workder=yujishen/multi-workder:$SHA