HOST=lin@iccluster
SERVER=$(s)
SCALE=$(sc)
NAMESPACE=.iccluster.epfl.ch
IP=${HOST}${SERVER}${NAMESPACE}
DISK=/mlodata1/tlin
LOCALPORT=${lp}
REMORTPORT=${rp}


# ssh to server.
ssh_server:
	ssh ${IP}


ssh_tensorboard:
	ssh -L ${lp}:127.0.0.1:${rp} ${IP}


ssh_notebook:
	ssh -L localhost:${lp}:localhost:${rp} ${IP}


# sync between server.
cp_all_gpu:
	rsync -av -e ssh --exclude 'data' ../../code/* ${IP}:${DISK}/localsgd-united


mount_mlodata1:
	sudo sshfs -o allow_other,transform_symlinks lin@iccluster098.iccluster.epfl.ch:/mlodata1/tlin /home/lin/mount_from_mlodata1

docker_run:
	docker run -it --rm --mount type=bind,source="/home/lin/mount_from_mlodata1/localsgd-united",target="/app" mlbench/mlbench_worker bash
