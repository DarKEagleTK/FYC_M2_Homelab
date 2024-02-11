variable "admuser" {
    default = "terraform"
}

variable "pm_uri_url" {
    default = "https://ip:8006/api2/json" 
}

variable "pm_user" {
    default = "terraform@pam!terraform"
}

variable "pm_password" {
    default = ""
}

variable "os_type" {
  default = "template-serv-debian" # Nom de votre template
}

variable "ip_config" {
  default = "ip=172.16.0.10/16,qw=172.16.0.254"
}

variable "nameserver" {
  default = "172.16.0.254"
}

variable "sshkeys_user" {
  default = ""
}

variable "memoires" {
  default = "2048"
}

variable "proc" {
  default = "2"
}

variable "name" {
  default = "VM-Terraform"
}

variable "vmid" {
  default = "401"
}

variable "disk_size" {
  default = "20G"
}

variable "network" {
  default = "vmbr1"
}