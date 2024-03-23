# Cue Demo

## Description

This demo borrows some from this repo: <https://github.com/fluxcd/cues>

## Dependencies

- CUE == 0.8.0
- go == 1.21.0

## Prepp

Pull and run a docker registry

```shell
docker run -d -p 5000:5000 --restart always --name registry registry:2
```

Destroy registry

```shell
docker rm -f registry
```

Upload supporting modules to the OCI registry. These modules are utilized by apps, bundles, flavors and cluster configurations.
They are mostly schemas and therefor are very generalized.

```shell
export CUE_EXPERIMENT=modules
export CUE_REGISTRY=localhost:5000/cue-demo/modules

export WDIR=$(pwd)

cd $WDIR/cue-modules/common
cue mod tidy
cue mod publish v0.0.1

cd $WDIR/cue-modules/app
cue mod tidy
cue mod publish v0.0.1

cd $WDIR/cue-modules/bundle
cue mod tidy
cue mod publish v0.0.1

cd $WDIR/cue-modules/flavor
cue mod tidy
cue mod publish v0.0.1

cd $WDIR/cue-modules/fluxcd
cue mod tidy
cue mod publish v0.0.1
```

## Developing own app

### Prepp

Download go modules.
(These modules can later be used to generate CUE schemas)

```shell
export GO111MODULE=off
go get -d k8s.io/api/core/v1
go get -d k8s.io/api/apps/v1
go get -d k8s.io/apimachinery
go get -d k8s.io/api/networking/v1
```

Optional: Generate cue schema from go modules

```shell
cue get go k8s.io/api/core/v1
cue get go k8s.io/api/apps/v1
cue get go k8s.io/apimachinery/pkg/apis/meta/v1
cue get go k8s.io/api/networking/v1
```
