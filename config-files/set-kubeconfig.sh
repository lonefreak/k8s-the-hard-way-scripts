#!/bin/bash

CLUSTER=kubernetes-the-hard-way
CERTIFICATES_PATH="../ca-tls/certificates"
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
    --region $(gcloud config get-value compute/region) \
    --format 'value(address)')

function generate-kubeconfig() {
    local instance=$1
    local node_name=$2
    kubectl config set-cluster $CLUSTER \
        --certificate-authority=${CERTIFICATES_PATH}/ca.pem \
        --embed-certs=true \
        --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443 \
        --kubeconfig=kubeconfig/${instance}.kubeconfig

    kubectl config set-credentials ${node_name} \
        --client-certificate=${CERTIFICATES_PATH}/${instance}.pem \
        --client-key=${CERTIFICATES_PATH}/${instance}-key.pem \
        --embed-certs=true \
        --kubeconfig=kubeconfig/${instance}.kubeconfig

    kubectl config set-context default \
        --cluster=$CLUSTER \
        --user=system:node:${instance} \
        --kubeconfig=kubeconfig/${instance}.kubeconfig

    kubectl config use-context default --kubeconfig=kubeconfig/${instance}.kubeconfig
}

echo "Generating worker keys..."
for instance in worker-0 worker-1 worker-2 kube-proxy; do
    generate-kubeconfig ${instance} system:node:${instance}
done
echo "Done"

echo "Generating kube-proxy key..."
generate-kubeconfig kube-proxy kube-proxy
echo "Done"

echo "Sending keys to worker instances..."
for instance in worker-0 worker-1 worker-2; do
    gcloud compute scp kubeconfig/${instance}.kubeconfig kubeconfig/kube-proxy.kubeconfig ${instance}:~/
done
echo "Done"
