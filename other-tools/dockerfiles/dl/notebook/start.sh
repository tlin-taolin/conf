#!/usr/bin/env bash

# jupyter tensorboard enable --user
jupyter notebook --NotebookApp.token='' --no-browser --ip=0.0.0.0 --port=8888 
