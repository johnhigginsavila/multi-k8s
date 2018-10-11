docker build -t johnhigginsavila/multi-client:latest -t johnhigginsavila/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t johnhigginsavila/multi-server:latest -t johnhigginsavila/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johnhigginsavila/multi-worker:latest -t johnhigginsavila/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push johnhigginsavila/multi-client:latest
docker push johnhigginsavila/multi-server:latest
docker push johnhigginsavila/multi-worker:latest
docker push johnhigginsavila/multi-client:$SHA
docker push johnhigginsavila/multi-server:$SHA
docker push johnhigginsavila/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=johnhigginsavila/multi-server:$SHA
kubectl set image deployments/client-deployment client=johnhigginsavila/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=johnhigginsavila/multi-worker:$SHA
