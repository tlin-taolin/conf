HOST=lin@iccluster
SERVER=$(s)
SCALE=$(sc)
NAMESPACE=.iccluster.epfl.ch
IP=${HOST}${SERVER}${NAMESPACE}
DISK=/mlodata1/tlin
FOLDER=pytorch-ps
LOCALPORT=${lp}
REMORTPORT=${rp}
USE_CUDA=${cuda}


# k8s.
backto_ic_k8s:
	kubectl config use-context lin-mlo-context

setup:
	# delete existing worker.
	$(MAKE) delete_cluster
	# create cluster.
	kubectl create -f pod-master.yaml
	kubectl create -f pod-controller.yaml
	kubectl create -f pod-svc-timeseries.yaml

scale:
	kubectl scale rc lin-worker --replicas=${SCALE}

configure:
	# configre cluster.
	cd iccluster && python init_kube_mpi.py --use_cuda ${USE_CUDA} && cd ../
	$(MAKE) send
	kubectl cp iccluster/hostfile lin-master:/mlodata1/tlin/${FOLDER}/iccluster/

send:
	rsync -av -e ssh --exclude 'data' ../${FOLDER}/* ${IP}:/mlo-container-scratch/tlin/${FOLDER}

login:
	kubectl exec -it lin-master -- bash

delete_cluster:
	-kubectl delete -f pod-master.yaml
	-kubectl delete -f pod-controller.yaml
	-kubectl delete -f pod-svc-timeseries.yaml

get_pods:
	kubectl get pods -l user=lin
