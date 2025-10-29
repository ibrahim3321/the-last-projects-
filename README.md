🚀 DevOps End-to-End Pipeline on Azure

⦁	This project showcases a complete DevOps lifecycle — from building the infrastructure to automating deployment and monitoring.
⦁	It reflects my hands-on experience in creating a fully automated, cloud-native environment using Azure services and modern DevOps tools.




🏗️ Architecture Overview

⦁	The system was designed with a modular structure that combines infrastructure, automation, CI/CD, and monitoring layers — all working together to ensure scalability, security, and reliability.





🔹 Infrastructure

⦁	The foundation was built using Terraform, where I provisioned all resources on Azure:
⦁	A Resource Group to organize everything.
⦁	A Managed Disk for persistent storage.
⦁	An AKS Cluster to host both the frontend and backend containers.




🐳 Container Registry
⦁	All Docker images for the applications were built and pushed to Azure Container Registry (ACR), which serves as the central image store before deployment to AKS.



⚙️ Automation & CI/CD

1.	To automate the entire workflow, I used a combination of:
2.	GitHub Actions for continuous integration and deployment.
3.	SonarQube to maintain code quality.
4.	Ansible for configuration management and automating post-deployment tasks.






☸️ Kubernetes Cluster (AKS)

⦁	Inside the AKS cluster, I deployed:
⦁	Frontend Application
⦁	Backend Application
⦁	MSSQL Database
⦁	Each service was containerized and connected securely within the cluster.





📊 Monitoring & Alerting

1.	Observability was a major focus in this project. I integrated:
2.	Prometheus for metrics collection.
3.	Grafana for dashboard visualization.
4.	Alertmanager for notifications.
5.	Slack & Call Me Bot to receive real-time alerts whenever issues occurred.





🔁 Continuous Delivery (GitOps)

⦁	To ensure the deployed state always matches the Git configuration, I used Argo CD.
⦁	This GitOps approach made deployments traceable, consistent, and easy to roll back when needed.




🧰 Tools & Technologies

Categor                                  Tools
_______________________________________________________________________
Infrastructure             	Terraform
_______________________________________________________________________
Containers	                Azure Container Registry (ACR), AKS
_______________________________________________________________________
CI/CD	                      GitHub Actions, SonarQube, Argo CD
_______________________________________________________________________
Automation	                Ansible
_______________________________________________________________________
Monitoring	                Prometheus, Grafana, Alert Manager
_______________________________________________________________________
Communication	                Slack, Call Me Bot



🚀 Project Workflow

⦁	Provision infrastructure using Terraform.
⦁	Build and push Docker images to ACR.
⦁	Deploy applications on AKS with Ansible.
⦁	Automate pipelines using GitHub Actions.
⦁	Set up monitoring with Prometheus and Grafana.
⦁	Enable alerting via Alert Manager and Slack notifications.




🧠 Key Learnings

1.	Working on this project taught me how to bring all DevOps tools together to form a complete automated ecosystem.
I learned how to:

2.	Manage infrastructure as code with Terraform.

3.	Automate build and deploy pipelines using GitHub Actions.

4.	Apply GitOps principles with Argo CD.

5.	Monitor clusters using Prometheus & Grafana.

6.	Use Ansible for automated configurations.

7.	Integrate real-time alerts into Slack for proactive response.
