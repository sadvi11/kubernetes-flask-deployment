# Kubernetes Flask Deployment

Flask app containerised with Docker, pushed to AWS ECR, and deployed on Kubernetes with 2 replicas.

## Tech Stack
- Python 3.11
- Flask
- Docker
- AWS ECR
- Kubernetes (minikube)
- kubectl

## Architecture
Flask App → Docker Image → AWS ECR → Kubernetes Deployment → 2 Pods Running

## What It Does
- Flask REST API containerised with Docker
- Image pushed to AWS ECR
- Deployed on Kubernetes with 2 replicas
- Service exposed via NodePort
- High availability with multiple replicas

## How to Run

1. Start minikube:
minikube start

2. Load image:
minikube image load flask-docker-app:latest

3. Deploy:
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

4. Access app:
minikube service flask-service --url

## Kubernetes Commands
kubectl get pods
kubectl get services
kubectl get deployments
kubectl describe pod pod-name
kubectl logs pod-name

## Sample Output
{"author": "Sadhvi - Cloud Engineer", "deployed_by": "Docker + Kubernetes", "message": "Hello from Docker Container!", "status": "running"}

## Pods Running
flask-deployment-5895b79cb5-27jng   1/1   Running
flask-deployment-5895b79cb5-7thmv   1/1   Running

## Author
Sadhvi - Cloud Engineer | AWS Cloud Practitioner | AWS SAA-C03 In Progress