resource "proxmox_vm_qemu" "test" {
    name = var.name
    desc = "terrafom VPS"
    vmid = var.vmid
    target_node = "serv-host-001" #Nom de votre node

    agent = 1
    
    clone = var.os_type
    cores = var.proc
    sockets = 1
    memory = var.memoires

    network {
        bridge = var.network
        model = "virtio"
    }

    disk {
        storage = "disque1"
        type = "virtio"
        size = var.disk_size
    }

    os_type = "cloud-init"
    ipconfig0 = var.ip_config
    nameserver = var.nameserver
    ciuser = "admuser"
    sshkeys = var.sshkeys_user

}