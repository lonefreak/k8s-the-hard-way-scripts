#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
    gcloud compute scp scripts/etcd.sh ${instance}:~/
    gcloud compute ssh ${instance} -- ./etcd.sh
done
