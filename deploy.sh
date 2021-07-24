# build all the images
docker build -t pedrocortez/multi-client:latest -t pedrocortez/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pedrocortez/multi-server:latest -t pedrocortez/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pedrocortez/multi-worker:latest -t pedrocortez/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push the images to DockerHub
docker push pedrocortez/multi-client:latest
docker push pedrocortez/multi-server:latest
docker push pedrocortez/multi-worker:latest

docker push pedrocortez/multi-client:$SHA
docker push pedrocortez/multi-server:$SHA
docker push pedrocortez/multi-worker:$SHA

# Apply k8s config files

kubectl apply -f k8s   
kubectl set image deployments/client-deployment client=pedrocortez/multi-client:$SHA
kubectl set image deployments/server-deployment server=pedrocortez/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pedrocortez/multi-worker:$SHA