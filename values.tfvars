proxmox_api_token_id        = ""  #Proxmox API Token ID
proxmox_api_token_secret    = "" #Proxmox API Token Secret
proxmox_api_url             = ""  #Your Proxmox API IP Address

vm_user = "" #Default VM User Name
vm_pass = "" #Default VM User Password

vm_default_gateway = "192.168.0.1" #Default Gateway IP Address
vm_dns_server = "192.168.0.1" #DNS Server IP Address

vm_k8s_master_node = "192.168.0.30" #Kubernetes Master Node IP
vm_k8s_worker_node_1 = "192.168.0.31"  #Kubernetes Worker Node 1 IP
vm_k8s_worker_node_2 = "192.168.0.32"  #Kubernetes Worker Node 2 IP
vm_k8s_worker_node_3 = "192.168.0.33"  #Kubernetes Worker Node 3 IP

k8s_version = "1.30" #Kubernetes version
k8s_cni_version = "3.28.0" #Calico plugin version
k8s_pod_network = "10.244.0.0/16" #Kubernetes pod network IP range
nginx_ingress_version = "3.5.1" #Nginx ingress controller version crds
helm_chart_nginx_ingress_version = "1.2.1" #Nginx ingress controller helm chart version
metallb_version = "0.14.5" #Load Balancer - metal lb version

grafana_user = "admin" #Set grafana username
grafana_pass = ""  #Set grafana password
