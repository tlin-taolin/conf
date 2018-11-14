# -*- coding: utf-8 -*-
import os
import socket

import numpy as np
from telegraf.client import TelegrafClient


def get_telegraf(job):
    telegraf = TelegrafClient(
        host=os.getenv('JOBMONITOR_TELEGRAF_HOST'),
        port=int(os.getenv('JOBMONITOR_TELEGRAF_PORT')),
        tags={
            'host': socket.gethostname(),
            'user': job['user'],
            'project': job['project'],
            'experiment': job['experiment'],
            'job_id': str(job['id']),
            'job_details': job['job_details']
        }
    )
    return telegraf.metric


log_metric = get_telegraf(
    job={
        'user': 'tlin',
        'project': 'localsgd',
        'experiment': 'online-aggregation',
        'id': '666',
        'job_details': 'accepted'
    }
)

config = dict(
    n_layers=4,
    batchnorm=False,
    dataset='Cifar10',
    architecture='ResNet18',
    n_epochs=20,
)


def main():
    cross_entropy = 1.0
    for i in range(config['n_epochs']):
        cross_entropy *= (0.7 + 0.3 * np.random.rand())
        log_metric(
            'cross_entropy',
            {'value': cross_entropy, 'step': i},
            {'split': 'train'}
        )
    print('Done!')


if __name__ == '__main__':
    main()
