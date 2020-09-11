# for kubernetes cluster of Gcloud.
SCALE=$(sc)

cluster_name=mlo
cluster_version=1.9
machine_zone=us-central1-f
machine_type=n1-standard-32
num_nodes=15

gpu_type=nvidia-tesla-p100
num_gpus_per_node=2
m_disk_size=50
e_disk_name=gce-nfs-ssd-disk
e_disk_size=500
e_disk_type=pd-ssd


list_k8s_content:
	kubectl config get-contexts


backto_g_k8s:
	kubectl config use-context gke_localsgd-198510_us-central1-f_mlo


backto_ic_k8s:
	kubectl config use-context lin-mlo-context


# setup k8s on GCE.
build_all:
	# build k8s cluster on GCE
	$(MAKE) build_gcloud_cluster
	# configure GPUs on k8s.
	$(MAKE) configure_gpu
	# init nfs server and nfs volume.
	$(MAKE) init_nfs_server
	$(MAKE) init_nfs_volume


build_gcloud_cluster:
	gcloud beta container clusters create ${cluster_name} --preemptible --cluster-version ${cluster_version} \
		--zone ${machine_zone} --machine-type ${machine_type} --min-cpu-platform "Intel Haswell" \
		--disk-size=${m_disk_size} --enable-network-policy \
		--num-nodes ${num_nodes} --enable-autoscaling --min-nodes=0 --max-nodes=${num_nodes} \
		--accelerator type=${gpu_type},count=${num_gpus_per_node} \
		--scopes=storage-full

	gcloud config set container/cluster ${cluster_name}
	gcloud container clusters get-credentials ${cluster_name}


configure_gpu:
	kubectl create -f https://raw.githubusercontent.com/GoogleCloudPlatform/container-engine-accelerators/k8s-1.9/nvidia-driver-installer/cos/daemonset-preloaded.yaml


init_nfs_server:
	# create a GCE persistent disk
	-gcloud compute disks create \
		--type ${e_disk_type} --size=${e_disk_size} --zone=${machine_zone} ${e_disk_name}
	# Create an NFS server with its PersistentVolumeClaim (PVC)
	kubectl create -f fs/init-01-dep-nfs.yml
	# Create a service for the NFS server to expose it
	kubectl create -f fs/init-02-srv-nfs.yml


init_nfs_volume:
	kubectl create -f fs/init-03-pv-and-pvc-nfs.yml


# delete k8s on GCE.
delete_all:
	$(MAKE) cleanup
	$(MAKE) delete_nfs_volume
	$(MAKE) delete_nfs_server
	$(MAKE) delete_gcloud_cluster


delete_nfs_volume:
	-kubectl delete pvc nfs
	-kubectl delete pv nfs


delete_nfs_server:
	-kubectl delete service nfs-server
	-kubectl delete deployment nfs-server


delete_gcloud_cluster:
	gcloud container clusters delete ${cluster_name}


setup:
	# create cluster.
	kubectl create -f dmlb-master.yaml
	kubectl create -f dmlb-controller.yaml


cleanup:
	-kubectl delete -f dmlb-master.yaml
	-kubectl delete -f dmlb-controller.yaml


configure:
	# configre cluster.
	python init_kube_mpi.py
	$(MAKE) send
	kubectl cp hostfile dmlb-master:/mlodata1/pytorch/gcloud


scale:
	kubectl scale rc dmlb-worker --replicas=${SCALE}


send:
	kubectl cp ../../pytorch dmlb-master:/mlodata1/


login:
	kubectl exec -it dmlb-master -- bash


get_pods:
	kubectl get pods | grep dmlb
