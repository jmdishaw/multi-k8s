docker build -t jmdishaw/multi-client:latest -t jmdishaw/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jmdishaw/multi-server:latest -t jmdishaw/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jmdishaw/multi-worker:latest -t jmdishaw/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jmdishaw/multi-client:latest
docker push jmdishaw/multi-client:$SHA
docker push jmdishaw/multi-server:latest
docker push jmdishaw/multi-server:$SHA
docker push jmdishaw/multi-worker:latest
docker push jmdishaw/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jmdishaw/multi-server:$SHA
kubectl set image deployments/client-deployment client=jmdishaw/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jmdishaw/multi-worker:$SHA