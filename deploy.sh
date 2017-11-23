#!/bin/bash
set -eu

# docker build & push
docker build . -t 139690869284.dkr.ecr.ap-northeast-1.amazonaws.com/nomp
docker push 139690869284.dkr.ecr.ap-northeast-1.amazonaws.com/nomp:latest

# deploy
ecs-cli compose --file docker-compose-nomp.yaml --project-name nomp create
TASK_DEFINITION_ARNS=`aws ecs --region ap-northeast-1 list-task-definitions --sort DESC --family-prefix "nomp" | jq ".[][0]" | sed 's/"//g'`
export CLUSTER_NAME=nomp
aws ecs --region ap-northeast-1 update-service --cluster ${CLUSTER_NAME} --service nomp --task-definition ${TASK_DEFINITION_ARNS} --deployment-configuration maximumPercent=200,minimumHealthyPercent=50
