docker build -t poyori007/multi-client:latest -t poyori007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t poyori007/multi-server:latest -t poyori007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t poyori007/multi-worker:latest -t poyori007/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push poyori007/multi-client:latest
docker push poyori007/multi-server:latest
docker push poyori007/multi-worker:latest

docker push poyori007/multi-client:$SHA
docker push poyori007/multi-server:$SHA
docker push poyori007/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=poyori007/multi-server:$SHA
kubectl set image deployments/client-deployment client=poyori007/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=poyori007/multi-worker:$SHA