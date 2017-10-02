#! /bin/bash
# Created by Fabricio Leotti on 20170918
# Depends on https://pkg.cfssl.org/
# How to install
# https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md

# Generate CA Authority
cfssl gencert -initca files/ca-csr.json | cfssljson -bare ca
if [ $? -eq 0 ]; then
    mv ca-key.pem ca.csr ca.pem certificates/
fi

# Generate Admin CLient Certificate
cfssl gencert \
    -ca=certificates/ca.pem \
    -ca-key=certificates/ca-key.pem \
    -config=files/ca-config.json \
    -profile=kubernetes \
    files/admin-csr.json | cfssljson -bare admin
if [ $? -eq 0 ]; then
    mv admin-key.pem admin.csr admin.pem certificates/
fi

# Generate kubelet client cert for each worker
for instance in worker-0 worker-1 worker-2; do
    WORKER_INSTANCE=${instance}
    envsubst < templates/worker-csr.json.tpl > files/${instance}-csr.json
    EXTERNAL_IP=$(gcloud compute instances describe ${instance} \
          --format 'value(networkInterfaces[0].accessConfigs[0].natIP)')
    INTERNAL_IP=$(gcloud compute instances describe ${instance} \
          --format 'value(networkInterfaces[0].networkIP)')
    cfssl gencert \
        -ca=certificates/ca.pem \
        -ca-key=certificates/ca-key.pem \
        -config=files/ca-config.json \
        -hostname=${instance},${EXTERNAL_IP},${INTERNAL_IP} \
        -profile=kubernetes \
        files/${instance}-csr.json | cfssljson -bare ${instance}
    if [ $? -eq 0 ]; then
        mv ${instance}-key.pem ${instance}.csr ${instance}.pem certificates/
    fi
    rm files/${instance}-csr.json
done

# Generate kube-proxy client cert
cfssl gencert \
    -ca=certificates/ca.pem \
    -ca-key=certificates/ca-key.pem \
    -config=files/ca-config.json \
    -profile=kubernetes \
    files/kube-proxy-csr.json | cfssljson -bare kube-proxy
if [ $? -eq 0 ]; then
    mv kube-proxy-key.pem kube-proxy.csr kube-proxy.pem certificates/
fi

# Generate the kubernetes-api server cert
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

SANS="10.32.0.1,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,kubernetes.default"
for instance in controller-0 controller-1 controller-2; do
    NETWORK_IP=$(gcloud compute instances describe ${instance} \
        --format 'value(networkInterfaces[0].networkIP)')
    SANS="${SANS},${NETWORK_IP}"
done

cfssl gencert \
  -ca=certificates/ca.pem \
  -ca-key=certificates/ca-key.pem \
  -config=files/ca-config.json \
  -hostname=${SANS} \
  -profile=kubernetes \
  files/kubernetes-csr.json | cfssljson -bare kubernetes
if [ $? -eq 0 ]; then
    mv kubernetes-key.pem kubernetes.csr kubernetes.pem certificates/
fi

# Distribute certificates
for instance in worker-0 worker-1 worker-2; do
  pushd certificates/
  gcloud compute scp ca.pem ${instance}-key.pem ${instance}.pem ${instance}:~/
  popd
done

for instance in controller-0 controller-1 controller-2; do
  pushd certificates/
  gcloud compute scp ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem ${instance}:~/
  popd
done

