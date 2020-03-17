# fahclient-container
Dockerfile for containerized FAHClient rootless and K8S ready to help [Folding@Home project](https://foldingathome.org/) research against [COVID-19](https://en.wikipedia.org/wiki/Coronavirus_disease_2019)

https://foldingathome.org/2020/03/15/coronavirus-what-were-doing-and-how-you-can-help-in-simple-terms/


## Build with Docker

```
$ docker build .
```

## Build with Buildah

```
$ buildah bud -t fahclient-centos8 .
```

## Run with Docker

```
$ docker pull quay.io/bluesman/fahclient-centos8:latest
$ docker run -e TEAM=<YOUR_TEAM_ID> -e GPU=<false|true> -ti quay.io/bluesman/fahclient-centos8:latest
```

## Run with Podman

```
$ podman pull quay.io/bluesman/fahclient-centos8:latest
$ podman run -e TEAM=<YOUR_TEAM_ID> -e GPU=<false|true> -ti quay.io/bluesman/fahclient-centos8:latest
```

# Run with Kubernetes

If you run it on Kubernetes you have to take in consideration Anti-Affinity policy of Pod replicas scheduling, in this computation model it is more effective the vertical scaling rather than horizontal one.

## Run with OpenShift and OKD

```
$ oc new-app https://github.com/blues-man/fahclient-container.git --name fahclient-centos8 --env  TEAM=<YOUR_TEAM_ID> --env GPU=<false|true>
```
Access the WebUI via OpenShift Route:

```
$ oc expose svc/fahclient-centos8
```

Browse to: http://fahclient-centos8-<PROJECT_NAME>.apps.<CLUSTER_DOMAIN>


## Run on K8S

Build the Container Image and push it to your registry, then deploy it:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: fahclient-centos8-deployment
  labels:
    app: fahclient-centos8
spec:
  replicas: 1
  selector:
    matchLabels:
      app: fahclient-centos8
  template:
    metadata:
      labels:
        app: fahclient-centos8
    spec:
      containers:
      - name: fahclient-centos8
        image: quay.io/bluesman/fahclient-centos8:latest
        ports:
        - containerPort: 7396
```
```
$ kubectl create -f fahclient-centos8.yaml
```

# Join Tigers!

If you want to join our [Redhat-EMEA-SSA team](https://stats.foldingathome.org/team/241379) you can just our team id **241379** in your container environment, or just in your config.xml if you don't use it as container.


