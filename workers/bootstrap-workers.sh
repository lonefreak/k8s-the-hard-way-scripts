#!/bin/bash

for instance in worker-0 worker-1 worker-2; do
    gcloud compute scp scripts/worker.sh ${instance}:~/
    gcloud compute ssh ${instance} -- ./worker.sh
    gcloud compute ssh ${instance} -- rm ~/worker.sh
    gcloud compute ssh controller-0 -- kubectl get nodes
done
