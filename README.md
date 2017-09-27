# Scripts for "Kubernetes the hard way" tutorial

## Objective

I have created this repo ony because I want to have a quick way to create new clusters after I have learned how to do it command by command. By no means you should use this repo if you have not tried yourself the [amazing tutorial](https://github.com/kelseyhightower/kubernetes-the-hard-way) Kelsey Hightower created.

## Before you run the scripts

Make sure you have subnet, firewall rules and compute instances set as described [here](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/03-compute-resources.md).

## Setting up your cluster

### Provisioning a CA and Generating TLS Certificates

```
$ cd ca-tls/
$ ./ca-tls-setup.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/04-certificate-authority.md)

### Generating Kubernetes Configuration Files for Authentication

```
$ cd config-files/
$ ./set-kubeconfig.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/05-kubernetes-configuration-files.md)

### Generating the Data Encryption Config and Key

```
$ cd data-encryption/
$ ./data-encryption.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/06-data-encryption-keys.md)

### Bootstrapping the etcd Cluster

```
$ cd etcd/
$ ./install-etcd.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/07-bootstrapping-etcd.md)

### Bootstrapping the Kubernetes Control Plane

```
$ cd control-plane/
$ ./bootstrap-control-plane.sh
```

[Reference](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/08-bootstrapping-kubernetes-controllers.md)
