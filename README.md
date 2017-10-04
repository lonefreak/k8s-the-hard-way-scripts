# Scripts for "Kubernetes the hard way" tutorial

## Objective

I have created this repo ony because I want to have a quick way to create new clusters after I have learned how to do it command by command. By no means you should use this repo if you have not tried yourself the [amazing tutorial](https://github.com/kelseyhightower/kubernetes-the-hard-way) Kelsey Hightower created.

As of now this repo is compatible only with tag `1.7.4` of the tutorial

## Before you run the scripts

Make sure you have subnet, firewall rules and compute instances set as described [here](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/03-compute-resources.md).

## Setting up your cluster

### Provisioning Compute Resources

_IMPORTANT_ be aware that creating the infrastructure on GCP will cost money

```
$ cd 01-spin-up/
$ ./start-cluster-up.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/1.7.4/docs/03-compute-resources.md)

### Provisioning a CA and Generating TLS Certificates

```
$ cd 02-ca-tls/
$ ./ca-tls-setup.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md)

### Generating Kubernetes Configuration Files for Authentication

```
$ cd 03-config-files/
$ ./set-kubeconfig.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-configuration-files.md)

### Generating the Data Encryption Config and Key

```
$ cd 04-data-encryption/
$ ./data-encryption.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/06-data-encryption-keys.md)

### Bootstrapping the etcd Cluster

```
$ cd 05-etcd/
$ ./install-etcd.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/07-bootstrapping-etcd.md)

### Bootstrapping the Kubernetes Control Plane

```
$ cd 06-control-plane/
$ ./bootstrap-control-plane.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/08-bootstrapping-kubernetes-controllers.md)

### Bootstrapping the Kubernetes Worker Nodes

```
$ cd 07-workers/
$ ./bootstrap-workers.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/1.7.4/docs/09-bootstrapping-kubernetes-workers.md)

### Configuring kubectl for Remote Access

```
$ cd 08-remote-access/
$ ./set-remote-access.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/1.7.4/docs/10-configuring-kubectl.md)

### Provisioning Pod Network Routes

```
$ cd 09-networking/
$ ./pod-network-routes.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/1.7.4/docs/11-pod-network-routes.md)

### Deploying the DNS Cluster Add-on

```
$ cd 10-dns-addon/
$ ./dns-addon.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/1.7.4/docs/12-dns-addon.md)

### Smoke Test

No scripts on this part. Go to the tutorial amd play around with your new cluster. :)

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/1.7.4/docs/13-smoke-test.md)

### Cleaning Up

```
$ cd 12-tear-down/
$ ./tear-cluster-down.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/1.7.4/docs/14-cleanup.md)
