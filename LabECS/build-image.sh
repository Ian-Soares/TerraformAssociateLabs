#!/bin/bash

printf "What is the repository URL tag?: "
read aws_ecr_repository_tag

printf "Which folder of your machine is the Dockerfile?: "
read build_folder

printf "Account ID: "
read account

printf "Region: "
read region

echo "Building the image"
docker build -t $aws_ecr_repository_tag $build_folder

echo "Logging in ECR"
aws ecr get-login-password \
    --region ${region} | docker login \
    --username AWS \
    --password-stdin ${account}.dkr.ecr.${region}.amazonaws.com

echo "Pushing image"
docker push $aws_ecr_repository_tag