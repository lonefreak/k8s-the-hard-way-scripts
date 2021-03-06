#!/bin/bash

export ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

envsubst < templates/encryption-config.yaml.tpl > encryption-config/encryption-config.yaml

for instance in controller-0 controller-1 controller-2; do
    gcloud compute scp encryption-config/encryption-config.yaml ${instance}:~/
done
