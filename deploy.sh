docker build -t manikkhosla/multi-client:latest -t manikkhosla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t manikkhosla/multi-server:latest -t manikkhosla/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t manikkhosla/multi-worker:latest -t manikkhosla/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push manikkhosla/multi-client:latest 
docker push manikkhosla/multi-client:$SHA 
docker push manikkhosla/multi-server:latest 
docker push manikkhosla/multi-server:$SHA  
docker push manikkhosla/multi-worker:latest
docker push manikkhosla/multi-worker:$SHA 

kubectl apply -f K8S

kubectl set image deployment/server-deployment server=manikkhosla/multi-server:$SHA 
kubectl set image deployment/client-deployment client=manikkhosla/multi-client:$SHA 
kubectl set image deployment/worker-deployment worker=manikkhosla/multi-worker:$SHA 