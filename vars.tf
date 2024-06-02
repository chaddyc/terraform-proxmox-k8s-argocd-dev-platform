# ---------------------------------------------------------------------------------------------------------------------
# Proxmox
# ---------------------------------------------------------------------------------------------------------------------

variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}



# ---------------------------------------------------------------------------------------------------------------------
# Virtual Machines
# ---------------------------------------------------------------------------------------------------------------------

variable "vm_user" {
    type = string  
}

variable "vm_pass" {
    type = string
    sensitive = true  
}

variable "vm_default_gateway" {
    type = string  
}

variable "vm_dns_server" {
    type = string  
}

variable "vm_k8s_master_node" {
    type = string  
}

variable "vm_k8s_worker_node_1" {
    type = string  
}

variable "vm_k8s_worker_node_2" {
    type = string  
}

variable "vm_k8s_worker_node_3" {
    type = string  
}


# ---------------------------------------------------------------------------------------------------------------------
# Kubernetes
# ---------------------------------------------------------------------------------------------------------------------

variable "k8s_version" {
    type = string  
}

variable "k8s_pod_network" {
    type = string  
}

variable "k8s_cni_version" {
    type = string  
}

variable "metallb_version" {
    type = string  
}

variable "nginx_ingress_version" {
    type = string  
}

variable "helm_chart_nginx_ingress_version" {
    type = string  
}

variable "grafana_user" {
    type = string
}

variable "grafana_pass" {
    type = string
    sensitive = true  
}

