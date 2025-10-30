# 🚀 End-to-End DevOps Pipeline Project on Azure

This project demonstrates a complete **DevOps lifecycle** — from infrastructure provisioning to deployment, monitoring, and automation — implemented entirely on **Microsoft Azure** using modern DevOps tools and practices.

---

## Overview

The project represents a **three-tier cloud-native application** deployed on **Azure Kubernetes Service (AKS)**.  
It integrates **Terraform**, **GitHub Actions**, **Ansible**, **SonarQube**, **ArgoCD**, **Prometheus**, and **Grafana** to deliver a fully automated and observable DevOps environment.

<img width="1261" height="709" alt="image" src="https://github.com/user-attachments/assets/b0799a0c-23f1-4153-ab7b-269825927419" />
<img width="1261" height="709" alt="image" src="https://github.com/user-attachments/assets/d09132d1-4122-4762-bb7f-5a6b5fd673d3" />
<img width="1261" height="709" alt="image" src="https://github.com/user-attachments/assets/1393dec9-33f4-4381-a94e-86c5e3d83df0" />
<img width="1261" height="709" alt="image" src="https://github.com/user-attachments/assets/a3b6ba2b-52ec-4d29-91fd-a7fbc4e0734f" />
<img width="1261" height="709" alt="image" src="https://github.com/user-attachments/assets/5e4c59f7-ae27-473a-b292-7d3ac5d34b7f" />


---

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Folder Structure](#folder-structure)
- [Setup & Installation](#setup--installation)
- [Configuration](#configuration)
- [Development Workflow](#development-workflow)
- [Infrastructure Provisioning](#infrastructure-provisioning)
- [CI/CD Pipeline](#cicd-pipeline)
- [Kubernetes Deployment](#kubernetes-deployment)
- [Monitoring & Observability](#monitoring--observability)
- [Security](#security)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## ✨ Features

- Fully automated **Infrastructure as Code (IaC)** with Terraform.  
- Continuous Integration & Deployment via **GitHub Actions**.  
- **Containerized** frontend and backend using Docker.  
- Scalable deployment through **AKS** with YAML manifests.  
- **Code quality checks** integrated using SonarQube.  
- **Centralized monitoring** via Prometheus and Grafana dashboards.  
- **Automated alerts** sent to Slack and CallMeBot.  
- **Declarative GitOps workflow** powered by ArgoCD.

---

## 🧩 Architecture

The architecture follows a layered design to ensure modularity, scalability, and maintainability.

- **Infrastructure Layer:** Provisioned using **Terraform** (Resource Groups, AKS, ACR, Network, Storage, Key Vault).  
- **Application Layer:** Includes **Frontend (React + Vite)** and **Backend (Node.js + Express)** containers stored in **Azure Container Registry (ACR)**.  
- **Orchestration Layer:** Managed through **Azure Kubernetes Service (AKS)** with Ingress routing, services, and deployments.  
- **CI/CD Layer:** Automated build, test, and deploy pipelines using **GitHub Actions**.  
- **Monitoring Layer:** Implemented using **Prometheus**, **Grafana**, and **Alertmanager** for observability.  
- **Automation & Notification:** Managed by **Ansible** playbooks and **Slack/CallMeBot** integrations for instant alerts.

---

## 🧰 Technology Stack

| Category | Tools |
|-----------|-------|
| Cloud Provider | Microsoft Azure |
| Infrastructure as Code | Terraform |
| Containerization | Docker |
| Orchestration | Azure Kubernetes Service (AKS) |
| Registry | Azure Container Registry (ACR) |
| CI/CD | GitHub Actions |
| Configuration Management | Ansible |
| Code Quality | SonarQube |
| Monitoring | Prometheus & Grafana |
| GitOps | ArgoCD |
| Notifications | Slack & CallMeBot |

---

## 🗂️ Folder Structure

```bash
the-last-projects/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── providers.tf
│   └── modules/
│
├── aks-yaml/
│   ├── api-ingress.yml
│   ├── backend-config.yml
│   ├── backend-deployment.yml
│   ├── backend-svc.yml
│   ├── frontend-config.yml
│   ├── frontend-deployment.yml
│   ├── frontend-svc.yml
│   ├── mssql-deployment.yml
│   ├── mssql-svc.yml
│   └── web-ingress.yml
│
├── ansible-monitoring-aks/
│   ├── argocd-apps.yaml
│   ├── deploy-argocd.yml
│   ├── deploy-monitoring.yml
│   ├── values-grafana.yaml
│   └── values-prometheus.yaml
│
├── backend/
│   ├── Dockerfile
│   ├── pom.xml
│   ├── src/
│   └── TESTING.md
│
├── frontend/
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── index.html
│   ├── src/
│   └── public/
│
├── callmebot/
│   └── alert-notification-script.py
│
├── .gitignore
└── README.md
```


---
# ⚙️ Setup & Installation

This section explains the installation process and prerequisites needed to run the project successfully.

---

## 🧩 Prerequisites
- Docker & Docker Compose  
- Terraform v1.5+  
- Azure CLI  
- kubectl  
- GitHub repository secrets configured  

---

# ⚙️ Configuration

Configuration files and environment variables used to manage and deploy the application.

- Environment variables managed in `.env` file for local setup.  
- Kubernetes secrets for database and API keys.  
- Terraform variables for resource naming, location, and environment.  

---

# 🧪 Development Workflow

The complete developer workflow from code push to monitoring:

1. Developer pushes code → GitHub Actions triggers pipeline.  
2. SonarQube scans for code quality and vulnerabilities.  
3. Docker builds container images and pushes them to ACR.  
4. Terraform ensures infrastructure consistency.  
5. ArgoCD pulls manifests from repo and deploys to AKS.  
6. Prometheus and Grafana track metrics post-deployment.  

---

# ☁️ Infrastructure Provisioning

This section covers the infrastructure setup using **Terraform**.

Terraform modules define and manage the following resources:

- Resource groups  
- AKS cluster  
- ACR registry  
- Managed disks  
- Storage and monitoring  

Each module can be reused and customized for different environments.  

---

# 🔁 CI/CD Pipeline

The **GitHub Actions** workflow automates every part of the deployment lifecycle:

### Automated Tasks
- Infrastructure provisioning with Terraform  
- Container build/push to ACR  
- AKS deployment using YAML files  
- Post-deployment automation with Ansible  
- ArgoCD sync for GitOps-based continuous deployment  

### Secrets Used
- `AZURE_CREDENTIALS`  
- `OPENAI_API_KEY`  
- `FLASK_SECRET_KEY`  
- `POSTGRES_PASSWORD`  
- `GRAFANA_ADMIN_PASSWORD`  

---

# ☸️ Kubernetes Deployment

Kubernetes manifests manage all deployed components within the **AKS cluster**.

- Separate deployments for frontend, backend, and database.  
- Ingress controllers route traffic to corresponding services.  
- HPA (Horizontal Pod Autoscaler) ensures load-based scaling.  
- Persistent volumes maintain database state.  

---

# 📊 Monitoring & Observability

Monitoring ensures visibility into the health and performance of the system.

- **Prometheus** gathers real-time metrics.  
- **Grafana** visualizes dashboards and analytics.  
- **Alertmanager** routes alerts to Slack and CallMeBot.  
- **Ansible** automates monitoring setup and updates.  

---

# 🔒 Security

Security measures implemented across infrastructure and applications.

- Sensitive data stored in **Kubernetes Secrets** and **Azure Key Vault**.  
- HTTPS enforced via **Application Gateway**.  
- Role-Based Access Control (RBAC) for AKS and ACR integration.  

---

# 🧭 Usage

Instructions for accessing and monitoring the application after deployment.

- Access frontend via the public Ingress URL.  
- Log in to the system and interact with the backend API.  
- Monitor system performance and logs via Grafana dashboards.  

---

# 🧩 Troubleshooting

Common issues and how to resolve them:

- **App not starting:** Check `.env` variables and DB connection.  
- **Terraform errors:** Validate provider credentials.  
- **Kubernetes issues:** Inspect pod logs using `kubectl logs`.  
- **CI/CD failures:** Review GitHub Actions workflow logs.  

---

# 🤝 Contributing

Guidelines for contributing to the project.

1. Fork the repository.  
2. Create a feature branch.  
3. Commit your changes with clear messages.  
4. Submit a pull request with detailed description.  

---

# 📜 License

This project is licensed under the **MIT License**.

---

# 🏁 Conclusion

This project demonstrates a complete **DevOps pipeline** from infrastructure provisioning to deployment and monitoring on **Azure**.  
By integrating tools such as Terraform, AKS, GitHub Actions, and Prometheus, it achieves a modern, automated, and reliable DevOps ecosystem.





## 🔗 Related Projects

- [Second Project – DevOps Advisor](https://github.com/anas-443005129/master_projectg6.git)
- [Third Project – 3-tir app with full DevOps tools ](https://github.com/ibrahim3321/the3rd-fromthelast-project.git)


---
