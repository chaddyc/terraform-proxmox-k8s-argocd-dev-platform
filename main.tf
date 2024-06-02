# K8s platform build
#Tech Stack:
#Container Orchestrator == Kubernetes
#Container Runtime == ContainerD[Docker]
#GitOps Platform == ArgoCD
#LoadBalancer == Metal LB
#Ingress[Reverse Proxy] == Nginx Ingress Controller
#Monitoring == Prometheus + Grafana

resource "proxmox_vm_qemu" "k8s-master" {
    name = "k8s-master"
    desc = "Kubernetes Master Node"
    count = 1

    # Virtual host node name
    target_node = "vh1"

    # The destination resource pool for the new VM - if using resource pools
    # pool = "pool0"

    # The template name to clone this vm from
    clone = "ubuntu-2404-template"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 8192
    scsihw = "lsi"

    # Setup the disk
    disks {
        virtio {
            virtio0 {
                disk {
                    size            = 200
                    cache           = "writeback"
                    storage         = "local-lvm"
                }
            }
        }
    }

    # Setup the network interface
    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    cloudinit_cdrom_storage = "local-lvm"
    boot = "order=virtio0"
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=${var.vm_k8s_master_node}/24,gw=${var.vm_default_gateway}"
    nameserver = var.vm_dns_server

    #Kubernetes installation scripts
    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_pass
      host = var.vm_k8s_master_node
    }

    provisioner "file" {
        source = "k8s/k8s-install.sh"
        destination = "/tmp/k8s-install.sh" 
    }


    provisioner "remote-exec" {
        inline = [ 
            "sleep 120s",
            "chmod +x /tmp/k8s-install.sh",
            "sh /tmp/k8s-install.sh ${var.k8s_version}",
         ]
      
    }

    provisioner "file" {
        source = "k8s/k8s-master.sh"
        destination = "/tmp/k8s-master.sh" 
    }


    provisioner "remote-exec" {
        inline = [ 
            "chmod +x /tmp/k8s-master.sh",
            "sh /tmp/k8s-master.sh ${var.k8s_pod_network} ${var.k8s_cni_version}",
         ]
      
    }   

    provisioner "local-exec" {
        command = "sshpass -p ${var.vm_pass} scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${var.vm_user}@${var.vm_k8s_master_node}:/tmp/kube_join.txt ./"
    }


}

resource "proxmox_vm_qemu" "node-1" {
    name = "node-1"
    desc = "Kubernetes worker node 1"
    count = 1

    target_node = "vh1"
    clone = "ubuntu-2404-template"

    agent = 1

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 8192
    scsihw = "lsi"

    disks {
        virtio {
            virtio0 {
                disk {
                    size            = 200
                    cache           = "none"
                    storage         = "local-lvm"
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    cloudinit_cdrom_storage = "local-lvm"
    boot = "order=virtio0"
    ipconfig0 = "ip=${var.vm_k8s_worker_node_1}/24,gw=${var.vm_default_gateway}"
    nameserver = var.vm_dns_server

    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_pass
      host = var.vm_k8s_worker_node_1
    }

    provisioner "file" {
        source = "k8s/k8s-install.sh"
        destination = "/tmp/k8s-install.sh" 
    }


    provisioner "remote-exec" {
        inline = [ 
            "sleep 120s",
            "chmod +x /tmp/k8s-install.sh",
            "sh /tmp/k8s-install.sh ${var.k8s_version}",
         ]
      
    }

}

resource "proxmox_vm_qemu" "node-2" {
    name = "node-2"
    desc = "Kubernetes worker node 2"
    count = 1

    target_node = "vh1"

    clone = "ubuntu-2404-template"

    agent = 1

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 8192
    scsihw = "lsi"

    disks {
        virtio {
            virtio0 {
                disk {
                    size            = 200
                    cache           = "none"
                    storage         = "local-lvm"
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    cloudinit_cdrom_storage = "local-lvm"
    boot = "order=virtio0"
    ipconfig0 = "ip=${var.vm_k8s_worker_node_2}/24,gw=${var.vm_default_gateway}"
    nameserver = var.vm_dns_server

    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_pass
      host = var.vm_k8s_worker_node_2
    }

    provisioner "file" {
        source = "k8s/k8s-install.sh"
        destination = "/tmp/k8s-install.sh" 
    }


    provisioner "remote-exec" {
        inline = [ 
            "sleep 120s",
            "chmod +x /tmp/k8s-install.sh",
            "sh /tmp/k8s-install.sh ${var.k8s_version}",
         ]
      
    }

}

resource "proxmox_vm_qemu" "node-3" {
    name = "node-3"
    desc = "Kubernetes worker node 3"
    count = 1

    target_node = "vh1"

    clone = "ubuntu-2404-template"

    agent = 1

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 8192
    scsihw = "lsi"

    disks {
        virtio {
            virtio0 {
                disk {
                    size            = 200
                    cache           = "none"
                    storage         = "local-lvm"
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    cloudinit_cdrom_storage = "local-lvm"
    boot = "order=virtio0"
    ipconfig0 = "ip=${var.vm_k8s_worker_node_3}/24,gw=${var.vm_default_gateway}"
    nameserver = var.vm_dns_server

    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_pass
      host = var.vm_k8s_worker_node_3
    }

    provisioner "file" {
        source = "k8s/k8s-install.sh"
        destination = "/tmp/k8s-install.sh" 
    }


    provisioner "remote-exec" {
        inline = [ 
            "sleep 120s",
            "chmod +x /tmp/k8s-install.sh",
            "sh /tmp/k8s-install.sh ${var.k8s_version}",
         ]
      
    }

}

resource "null_resource" "node_1_kube_join" {
    depends_on = [ proxmox_vm_qemu.k8s-master ]

    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_pass
      host = var.vm_k8s_worker_node_1
    }

    provisioner "file" {
        source = "kube_join.txt"
        destination = "/tmp/kube_join.txt" 
    }


    provisioner "remote-exec" {
        inline = [ 
            "$(cat /tmp/kube_join.txt)",
            "rm /tmp/kube_join.txt"
         ]
      
    }

    provisioner "remote-exec" {
        inline = [ 
            # "sudo ufw allow 10251/tcp",
            # "sudo ufw allow 10255/tcp",
            # "sudo ufw allow 80/tcp", 
            # "sudo ufw allow 22/tcp",
            # "yes | sudo ufw enable",
            # "sudo ufw reload",
            "sudo systemctl stop ufw",
            "sudo systemctl disable ufw",
         ]
      
    }

    provisioner "local-exec" {
        command = "rm kube_join.txt"
    }

}

resource "null_resource" "node_2_kube_join" {
    depends_on = [ proxmox_vm_qemu.k8s-master ]

    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_pass
      host = var.vm_k8s_worker_node_2
    }

    provisioner "file" {
        source = "kube_join.txt"
        destination = "/tmp/kube_join.txt" 
    }


    provisioner "remote-exec" {
        inline = [ 
            "$(cat /tmp/kube_join.txt)",
            "rm /tmp/kube_join.txt"
         ]
      
    }

    provisioner "remote-exec" {
        inline = [ 
            # "sudo ufw allow 10251/tcp",
            # "sudo ufw allow 10255/tcp",
            # "sudo ufw allow 80/tcp",
            # "sudo ufw allow 22/tcp",
            # "yes | sudo ufw enable",
            # "sudo ufw reload",
            "sudo systemctl stop ufw",
            "sudo systemctl disable ufw",
         ]
      
    }
  
}

resource "null_resource" "node_3_kube_join" {
    depends_on = [ proxmox_vm_qemu.k8s-master ]

    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_pass
      host = var.vm_k8s_worker_node_3
    }

    provisioner "file" {
        source = "kube_join.txt"
        destination = "/tmp/kube_join.txt" 
    }


    provisioner "remote-exec" {
        inline = [ 
            "$(cat /tmp/kube_join.txt)",
            "rm /tmp/kube_join.txt"
         ]
      
    }

    provisioner "remote-exec" {
        inline = [ 
            # "sudo ufw allow 10251/tcp",
            # "sudo ufw allow 10255/tcp",
            # "sudo ufw allow 80/tcp",
            # "sudo ufw allow 22/tcp",
            # "yes | sudo ufw enable",
            # "sudo ufw reload",
            "sudo systemctl stop ufw",
            "sudo systemctl disable ufw",
         ]
      
    }      
  
}

resource "null_resource" "master_apps_bootstrap" {
    depends_on = [ proxmox_vm_qemu.k8s-master, null_resource.node_1_kube_join, null_resource.node_2_kube_join, null_resource.node_3_kube_join ]

    connection {
      type = "ssh"
      user = var.vm_user
      password = var.vm_pass
      host = var.vm_k8s_master_node
    }

    provisioner "remote-exec" {
        inline = [ 
            "echo 'Checking in on master node'",
         ]
      
    } 

    provisioner "remote-exec" {
        inline = [ 
            "kubectl create ns prod",
            "kubectl create ns dev",
         ]
      
    }

    #load balancer - config and setup - metallb
    provisioner "remote-exec" {
        inline = [ 
            "kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e 's/strictARP: false/strictARP: true/' | kubectl apply -f - -n kube-system",
            "kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v${var.metallb_version}/config/manifests/metallb-native.yaml"
         ]
      
    }

    provisioner "file" {
        source = "metal-lb/lb-pool-1.yml"
        destination = "/tmp/lb-pool-1.yml" 
    }

    provisioner "file" {
        source = "metal-lb/lb-l2-advertisement.yml"
        destination = "/tmp/lb-l2-advertisement.yml"      
    }

    provisioner "file" {
        source = "apps/web-app-example.yml"
        destination = "/tmp/web-app-example.yml"      
    }

    provisioner "file" {
        source = "apps/web-app-2.yml"
        destination = "/tmp/web-app-2.yml"      
    }

    #install helm on master node
    provisioner "remote-exec" {
        inline = [ 
            "curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3",
            "chmod +x get_helm.sh",
            "./get_helm.sh",
         ]
      
    }

    #ingress controller - config and setup - nginx ingress controller
    provisioner "remote-exec" {
        inline = [ 
            "sleep 120",
            "kubectl -n metallb-system apply -f /tmp/lb-pool-1.yml",
            "kubectl apply -f /tmp/lb-l2-advertisement.yml",    
            "kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/v${var.nginx_ingress_version}/deploy/crds.yaml",
            "helm upgrade --install nginx-ingress oci://ghcr.io/nginxinc/charts/nginx-ingress --version ${var.helm_chart_nginx_ingress_version} --namespace nginx-ingress --create-namespace",
            "kubectl -n dev apply -f /tmp/web-app-example.yml",
            "kubectl -n dev apply -f /tmp/web-app-2.yml",
         ]
      
    }

    #gitops platform ArgoCD - config and setup
    provisioner "file" {
        source = "argocd/argocd-ingress.yml"
        destination = "/tmp/argocd-ingress.yml"      
    }

    provisioner "remote-exec" {
        inline = [ 
            "kubectl create namespace argocd",
            "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml",
            "kubectl -n argocd apply -f /tmp/argocd-ingress.yml",
            "kubectl -n argocd patch deployment argocd-server --type=json -p='[{'op': 'add', 'path': '/spec/template/spec/containers/0/args/-', 'value': '--insecure'}]'",
            "kubectl -n nginx-ingress patch deployment nginx-ingress-controller --type=json -p='[{'op': 'add', 'path': '/spec/template/spec/containers/0/args/-', 'value': '-enable-ssl-passthrough=true'}]'",
            
         ]
      
    }

    #monitoring and logging stack - config and setup - grafana, prometheus, loki
    provisioner "file" {
        source = "monitoring/grafana-stack-values.yml"
        destination = "/tmp/grafana-stack-values.yml"      
    }

    provisioner "file" {
        source = "monitoring/grafana-ingress.yml"
        destination = "/tmp/grafana-ingress.yml"      
    }

    provisioner "remote-exec" {
        inline = [ 
            "helm repo add prometheus-community https://prometheus-community.github.io/helm-charts",
            "helm repo update",
            "kubectl create namespace monitoring",
            "echo -n ${var.grafana_user} > ./admin-user",
            "echo -n ${var.grafana_pass} > ./admin-password",
            "kubectl create secret generic grafana-admin-credentials --from-file=./admin-user --from-file=admin-password -n monitoring",
            # "kubectl get secret -n monitoring grafana-admin-credentials -o jsonpath='{.data.admin-user}' | base64 --decode",
            # "kubectl get secret -n monitoring grafana-admin-credentials -o jsonpath='{.data.admin-password}' | base64 --decode",
            "rm admin-user && rm admin-password",
            "helm install -n monitoring prometheus prometheus-community/kube-prometheus-stack -f /tmp/grafana-stack-values.yml",
            "kubectl -n monitoring apply -f /tmp/grafana-ingress.yml",
         ]
      
    }

    # provisioner "file" {
    #     source = "monitoring/loki-stack-values.yml"
    #     destination = "/tmp/loki-stack-values.yml"      
    # }

    # provisioner "remote-exec" {
    #     inline = [ 
    #         "helm repo add grafana https://grafana.github.io/helm-charts",
    #         "helm repo update",
    #         "helm upgrade --install loki --namespace=monitoring --values /tmp/loki-stack-values.yml grafana/loki-stack"
    #      ]
      
    # }    
    
}