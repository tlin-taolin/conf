#!/bin/bash

install_path=/mlodata1/courdier/.openmpi

while getopts ":p:" opt; do
  case $opt in
    p)
      install_path=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

mkdir -p $install_path
echo Install path: $install_path

mpirun --version &> /dev/null
if [ $? == 0 ]; then
    mpi_path="$(dirname $(which mpirun))"
    echo "MPI is installed in $mpi_path"

    read -p "Continue ? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo Aborting
        exit 0
    fi
fi


wget https://www.open-mpi.org/software/ompi/v3.0/downloads/openmpi-3.0.0.tar.gz
gunzip -c openmpi-3.0.0.tar.gz | tar xf -

cd openmpi-3.0.0
./configure --prefix=$install_path --with-cuda
make all install

export PATH="$PATH:$install_path/bin"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$install_path/lib"

echo "Export path and lib path in .zshrc if needed :"
echo export PATH="\$PATH:${install_path}/bin/"
echo export LD_LIBRARY_PATH="\$LD_LIBRARY_PATH:${install_path}/lib/"

cd ..
mpirun --version &> /dev/null
if [ $? == 0 ]; then
   echo openMPI installed in $install_path
   rm -r openmpi-3.0.0.tar.gz openmpi-3.0.0
fi
