#!/usr/bin/env bash
set -x

export GOPATH=$(pwd)/_gopath
export PATH=$GOPATH/bin:$PATH
RELEASE=$(git describe --abbrev=4 --dirty --always --tags)

_containers="${GOPATH}/src/github.com/containers"
mkdir -vp ${_containers}
# ln -vsf $(pwd) ${_containers}/skopeo

go version
GO111MODULE=off go get -u github.com/cpuguy83/go-md2man golang.org/x/lint/golint

cd ${_containers}/skopeo
make validate-local test-unit-local binary-local-static BUILD_OS=windows
./skopeo.exe -v

mkdir release
cp LICENSE README.md release
mv skopeo.exe release
zip -r skopeo-windows-${RELEASE}.zip release 
rm -f release/*
mv skopeo-windows-${RELEASE}.zip release 