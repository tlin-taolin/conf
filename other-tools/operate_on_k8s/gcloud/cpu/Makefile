# for kubernetes cluster of Gcloud.
SCALE=$(sc)

cluster_name=data
machine_zone=europe-west1-b
machine_type=n1-standard-8
num_nodes=1
disk_name=gce-nfs-ssd-disk
disk_size=32
p_disk_size=1024


list_k8s_content:
	kubectl config get-contexts


# setup k8s on iccluster.
backto_ic_k8s:
	kubectl config use-context lin-mlo-context


build_all:
	$(MAKE) build_gcloud_cluster
	$(MAKE) init_nfs_server
	$(MAKE) init_nfs_volume


build_gcloud_cluster:
	gcloud container clusters create ${cluster_name} \
		--zone ${machine_zone} --machine-type ${machine_type} \
		--disk-size=${disk_size} --scopes=storage-full \
		--num-nodes ${num_nodes} --enable-autoscaling --min-nodes=1 --max-nodes=${num_nodes}

	gcloud config set container/cluster ${cluster_name}
	gcloud container clusters get-credentials ${cluster_name}


init_nfs_server:
	# create a GCE persistent disk
	-gcloud compute disks create \
		--type pd-standard --size=${p_disk_size} --zone=${machine_zone} ${disk_name}
	# Create an NFS server with its PersistentVolumeClaim (PVC)
	kubectl create -f ../fs/init-01-dep-nfs.yml
	# Create a service for the NFS server to expose it
	kubectl create -f ../fs/init-02-srv-nfs.yml


init_nfs_volume:
	kubectl create -f ../fs/init-03-pv-and-pvc-nfs.yml


delete_all:
	$(MAKE) delete_nfs_volume
	$(MAKE) delete_nfs_server
	$(MAKE) delete_gcloud_cluster


delete_nfs_volume:
	kubectl delete pvc nfs
	kubectl delete pv nfs


delete_nfs_server:
	kubectl delete service nfs-server
	kubectl delete deployment nfs-server


delete_gcloud_cluster:
	$(MAKE) cleanup
	gcloud container clusters delete ${cluster_name}


# setup my application on k8s
setup:
	# create cluster.
	kubectl create -f data.yaml


scale:
	kubectl scale rc dmlb-worker --replicas=${SCALE}


send:
	kubectl cp ../../../pytorch-mini-batch-sgd data:/mlodata1/



cleanup:
	-kubectl delete -f data.yaml


configure:
	# configre cluster.
	python init_kube_mpi.py
	kubectl cp hostfile dmlb-master:/home/lin/


login:
	kubectl exec -it data -- bash


get_pods:
	kubectl get pods
