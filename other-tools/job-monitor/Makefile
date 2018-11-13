build_on_k8s:
	-kubectl create -f pod-svc-timeseries.yaml
	-kubectl create -f pod-worker.yaml


clean_on_k8s:
	-kubectl delete -f pod-svc-timeseries.yaml
	-kubectl delete -f pod-worker.yaml


build_on_docker:
	docker-compose up -d


clean_on_docker:
	docker-compose down
