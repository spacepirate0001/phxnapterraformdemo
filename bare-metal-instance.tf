# The phoenixNAP provider is used to interact with the resources supported by PNAP. 
# The provider needs to be configured with the proper credentials before it can be used
# https://registry.terraform.io/providers/phoenixnap/pnap/latest/docs

provider "pnap" {
  client_id = var.client_id
  client_secret = var.client_secret
}

# Create a SSH key
resource "pnap_ssh_key" "ssh-key-1" {
    name = "sshkey-1"
    default = false
    key = var.ssh_key
}

# Create a server
resource "pnap_server" "Test-Server-1" {
    hostname = "Test-Server-1"
    os = "ubuntu/bionic"
    type = "s1.c1.medium"
    location = "PHX"
    install_default_ssh_keys = true
    ssh_key_ids = [pnap_ssh_key.ssh-key-1.id]
    action = "powered-on"
    cloud_init {
        user_data = filebase64("~/phxnapterraformdemo/create-http-server.txt")
    }
}
