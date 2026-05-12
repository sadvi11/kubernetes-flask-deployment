# Kubernetes Flask Deployment

> Flask REST API containerised with Docker, pushed to AWS ECR, and deployed on Kubernetes with high availability.

[![Python](https://img.shields.io/badge/Python-3.11-3776AB?logo=python)](https://python.org)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Minikube-326CE5?logo=kubernetes)](https://kubernetes.io)
[![Docker](https://img.shields.io/badge/Docker-Containerised-2496ED?logo=docker)](https://docker.com)
[![AWS ECR](https://img.shields.io/badge/AWS-ECR-FF9900?logo=amazonaws)](https://aws.amazon.com/ecr)
[![Status](https://img.shields.io/badge/Status-Deployed%20%26%20Verified-2ea44f)]()

---

## What This Project Does

Demonstrates a complete container-to-production workflow — Flask application containerised
with Docker, image pushed to AWS Elastic Container Registry (ECR), and deployed on Kubernetes
with 2 replicas for high availability. Exposes the service via NodePort. Covers the full
DevOps container lifecycle from local development to cloud registry to orchestrated deployment.

---

## Architecture

```
  LOCAL DEVELOPMENT          AWS CLOUD              KUBERNETES CLUSTER
  ─────────────────         ───────────            ──────────────────────
  Flask App                                         ┌──────────────────┐
      │                                             │   Deployment     │
  Dockerfile          →   AWS ECR Registry   →      │  ┌────────────┐  │
      │                   (container store)         │  │  Pod 1     │  │
  docker build                                      │  │  Flask App │  │
      │                                             │  └────────────┘  │
  ecr_push.sh                                       │  ┌────────────┐  │
  (tag + push)                                      │  │  Pod 2     │  │
                                                    │  │  Flask App │  │
                                                    │  └────────────┘  │
                                                    └────────┬─────────┘
                                                             │
                                                    ┌────────▼─────────┐
                                                    │  NodePort        │
                                                    │  Service         │
                                                    │  (external access)│
                                                    └──────────────────┘
```

---

## Components

| Resource | Details | Purpose |
|---|---|---|
| Flask App | Python 3.11 REST API | Application serving JSON responses |
| Dockerfile | Multi-stage build | Containerises the Flask application |
| AWS ECR | Container registry | Stores and versions Docker images |
| Kubernetes Deployment | 2 replicas | Runs application pods with HA |
| Kubernetes Service | NodePort | Exposes deployment to external traffic |
| ecr_push.sh | Shell script | Automates ECR login, tag, and push |

---

## Deployment Proof

```
flask-deployment-5895b79cb5-27jng   1/1   Running
flask-deployment-5895b79cb5-7thmv   1/1   Running
```

Both pods running simultaneously — high availability confirmed.

**Sample API response:**
```json
{
  "author": "Sadhvi - Cloud Engineer",
  "deployed_by": "Docker + Kubernetes",
  "message": "Hello from Docker Container!",
  "status": "running"
}
```

---

## Key Design Decisions

**Why 2 replicas?**
Single replica means a pod restart takes the service down. Two replicas ensure one pod
continues serving traffic while the other restarts — the same redundancy principle Nokia
uses for network function failover in 5G deployments.

**Why AWS ECR instead of Docker Hub?**
ECR integrates natively with AWS IAM — images can be pulled by EKS clusters using
instance roles without storing registry credentials. This is production best practice.

**Why NodePort for the service?**
NodePort exposes the service at a static port on each node — appropriate for local
Kubernetes (minikube) development. In production, this would be replaced with an
AWS Load Balancer Ingress.

**Why Kubernetes over Docker Compose?**
Docker Compose runs a single instance with no self-healing. Kubernetes automatically
restarts failed pods, manages replicas, and enables rolling deployments — essential
for production workloads.

---

## How to Run

```bash
# Start minikube
minikube start

# Build Docker image
docker build -t flask-docker-app:latest .

# Push to AWS ECR
chmod +x ecr_push.sh
./ecr_push.sh

# Deploy to Kubernetes
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Verify pods are running
kubectl get pods
kubectl get services

# Access the app
minikube service flask-service --url
```

---

## Useful Kubernetes Commands

```bash
kubectl get pods                    # list all pods
kubectl get services                # list all services
kubectl get deployments             # list deployments
kubectl describe pod <pod-name>     # detailed pod info
kubectl logs <pod-name>             # view pod logs
kubectl rollout restart deployment  # rolling restart
kubectl scale deployment flask-deployment --replicas=3  # scale up
```

---

## Repository Structure

```
kubernetes-flask-deployment/
├── app.py              # Flask REST API application
├── Dockerfile          # Container build instructions
├── deployment.yaml     # Kubernetes Deployment — 2 replicas
├── service.yaml        # Kubernetes NodePort Service
├── ecr_push.sh         # AWS ECR push automation script
└── README.md
```

---

## Interview Talking Points

- **Docker containerisation** — what a Dockerfile does, multi-stage builds
- **AWS ECR** — why a private registry, how IAM controls image access
- **Kubernetes deployments vs pods** — why you define a Deployment not just a Pod
- **Replica sets** — how Kubernetes maintains desired pod count
- **NodePort vs LoadBalancer vs ClusterIP** — when to use each service type
- **Rolling deployments** — how Kubernetes updates pods with zero downtime
- **kubectl commands** — get, describe, logs, scale, rollout

---

## Author

**Sadhvi Sharma** — Cloud & AI Engineer
Nokia India (5G Packet Core) → Cloud & AI Engineering
Calgary, AB, Canada | Permanent Resident | Open to Relocation

[LinkedIn](https://linkedin.com/in/sadhvi-sharma-5789a6249) | [GitHub](https://github.com/sadvi11)
