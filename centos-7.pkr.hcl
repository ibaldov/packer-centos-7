source "virtualbox-iso" "basic-example" {
      guest_os_type = "RedHat_64"
      # iso_url = "file:///C:/Users/username/CentOS-7-x86_64-DVD-2009.iso"
      iso_url = "CentOS-7-x86_64-DVD-2009.iso"
      iso_checksum = "md5:5a3b0b3f4a6654ee195ec6edb6d938a4"
      boot_command = [
         "<up><wait><tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
      ]
      disk_size = 10240
      headless = false
      ssh_username = "packer"
      ssh_password = "packer"
      ssh_port = 22
      ssh_wait_timeout = "30m"
      shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
      vboxmanage = [
        ["modifyvm", "{{.Name}}", "--memory", "1024"],
        ["modifyvm", "{{.Name}}", "--cpus", "4"],
      ]
      http_directory = "http"
}


build {
  sources = ["sources.virtualbox-iso.basic-example"]
}