#!/bin/bash

# ECR Push Script
# Author: Sadhvi - Cloud Engineer

ACCOUNT_ID="413238766748"
REGION="ca-central-1"
REPO_NAME="flask-docker-app"

echo "Logging into ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

echo "Building Docker image..."
docker build -t $REPO_NAME .

echo "Tagging image..."
docker tag $REPO_NAME:latest $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:latest

echo "Pushing to ECR..."
docker push $ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:latest

echo "Done! Image pushed to ECR successfully!"