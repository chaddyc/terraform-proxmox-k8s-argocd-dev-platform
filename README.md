<h1 align="center">😎 Kubernetes Dev Platform With Terraform</h1>
<div align="center">

<i>A Terraform template to set up a Complete Kubernetes Dev environment with base Monitoring and ArgoCD for GitOps and CICD</i>
</br>
</br>
Don't forget to give a ![Stars](https://img.shields.io/badge/Star-FFD700?style=flat-square&logo=ApacheSpark&logoColor=black) if you found this helpful

<a href="https://github.com/chaddyc/terraform-proxmox-k8s-argocd-dev-platform/stargazers"><img src="https://img.shields.io/github/stars/chaddyc/terraform-proxmox-k8s-argocd-dev-platform" alt="Stars Badge"/></a>
<a href="https://github.com/chaddyc/terraform-proxmox-k8s-argocd-dev-platform/network/members"><img src="https://img.shields.io/github/forks/chaddyc/terraform-proxmox-k8s-argocd-dev-platform" alt="Forks Badge"/></a>
<a href="https://github.com/chaddyc/terraform-proxmox-k8s-argocd-dev-platform/pulls"><img src="https://img.shields.io/github/issues-pr/chaddyc/terraform-proxmox-k8s-argocd-dev-platform" alt="Pull Requests Badge"/></a>
<a href="https://github.com/chaddyc/terraform-proxmox-k8s-argocd-dev-platform/issues"><img src="https://img.shields.io/github/issues/chaddyc/terraform-proxmox-k8s-argocd-dev-platform" alt="Issues Badge"/></a>
<a href="https://github.com/chaddyc/terraform-proxmox-k8s-argocd-dev-platform/graphs/contributors"><img alt="GitHub contributors" src="https://img.shields.io/github/contributors/chaddyc/terraform-proxmox-k8s-argocd-dev-platform?color=2b9348"></a>
![maintenance-status](https://img.shields.io/badge/maintenance-actively--developed-brightgreen.svg)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
<a href="https://github.com/chaddyc/terraform-proxmox-k8s-argocd-dev-platform/blob/master/LICENSE"><img src="https://img.shields.io/github/license/chaddyc/terraform-proxmox-k8s-argocd-dev-platform" alt="License Badge"/></a>

</div>

## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Setup And Usage](#setup-and-usage)
* [Contact](#contact)


## General Information
This project is a template to build and deploy a complete `Kubernetes Dev Environment on Proxmox VE` using Terraform. It autonomously sets up base `Monitoring` with `Grafana and Prometheus` as well as a GitOps CICD platform `ArgoCD`. Along with those configurations `Metal LB` is set up as a load balancer along with `Nginx Ingress Controller` as an Ingress controller.


## Technologies Used
- Language - Terraform + Bash
- Container Orchestrator - Kubernetes
- Container Runtime - ContainerD
- CICD + GitOps Platform - ArgoCD
- LoadBalancer - Metal LB
- Ingress - Nginx Ingress controller
- Monitoring - Prometheus + Grafana

## Setup And Usage

- Clone or fork this repo
- Add your values to the `values.tfvars` file
- Update the configs and values for your environment in the `yaml` files specifically `monitoring, metal-lb, apps and argocd`

Once you updated all your configuration files for your environment run the following commands to build and deploy this container dev environment:

Terraform Plan & Terraform Apply - See Planned output of resources to deploy and apply to deploy the planned resources
```
terraform plan -var-file="values.tfvars" 
```
```
terraform apply -var-file="values.tfvars" 
```

Terraform Destroy - Destroy resources
```
terraform destroy -var-file="values.tfvars" 
```

Once complete ensure that you add the DNS entries of the domain names you selected to your local DNS server so you can reach your applications via url in your web browser. Once your deployment completes succesful you can open the webui for `Grafana` depending on what domain you specified and use the `username and password` that you set in the `values.tfvars` file. For `ArgoCD` you can run the command below on your `masternode or control plane` to get your `default password` and use it along with `admin` to login to `ArgoCD`.

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Contact
Created by [@chaddyc](https://github.com/chaddyc) - feel free to contact me!


