#!/usr/bin/env bash
set -e

export GOPATH=$(pwd)/_gopath
export PATH=$GOPATH/bin:$PATH
RELEASE=$(git describe --abbrev=4 --dirty --always --tags)

_containers="${GOPATH}/src/github.com/containers"
mkdir -vp ${_containers}
ln -vsf $(pwd) ${_containers}/skopeo

go version
GO111MODULE=off go get -u github.com/cpuguy83/go-md2man golang.org/x/lint/golint

cd ${_containers}/skopeo
make validate-local test-unit-local binary-local BUILD_OS=darwin
# sudo make install
./skopeo -v

mkdir release
cp LICENSE README.md release
mv skopeo release
tar -zcvf skopeo-darwin-${RELEASE}.tar.gz release 
rm -f release/*
mv skopeo-darwin-${RELEASE}.tar.gz release
