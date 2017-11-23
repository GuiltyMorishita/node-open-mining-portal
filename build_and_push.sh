#!/bin/bash
set -eu

docker build . -t 139690869284.dkr.ecr.ap-northeast-1.amazonaws.com/nomp
docker push 139690869284.dkr.ecr.ap-northeast-1.amazonaws.com/nomp:latest
