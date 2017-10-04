#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
    gcloud compute scp scripts/control-plane.sh ${instance}:~/
    gcloud compute ssh ${instance} -- ./control-plane.sh
    gcloud compute ssh ${instance} -- rm ~/control-plane.sh
done
