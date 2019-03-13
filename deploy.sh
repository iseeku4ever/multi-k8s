docker build -t iseeku4ever/multi-client:latest -t iseeku4ever/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t iseeku4ever/multi-server:latest -t iseeku4ever/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t iseeku4ever/multi-worker:latest -t iseeku4ever/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push iseeku4ever/multi-client:latest
docker push iseeku4ever/multi-server:latest
docker push iseeku4ever/multi-worker:latest

docker push iseeku4ever/multi-client:$SHA
docker push iseeku4ever/multi-server:$SHA
docker push iseeku4ever/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=iseeku4ever/multi-server:$SHA
kubectl set image deployments/client-deployment client=iseeku4ever/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=iseeku4ever/multi-worker:$SHA