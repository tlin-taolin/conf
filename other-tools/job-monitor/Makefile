build:
	-kubectl create -f pod-svc-timeseries.yaml
	-kubectl create -f pod-worker.yaml

clean:
	-kubectl delete -f pod-svc-timeseries.yaml
	-kubectl delete -f pod-worker.yaml
