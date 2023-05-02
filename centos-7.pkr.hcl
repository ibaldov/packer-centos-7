source "virtualbox-iso" "basic-example" {
      guest_os_type = "RedHat_64"
      # iso_url = "file:///C:/Users/username/CentOS-7-x86_64-DVD-2009.iso"
      iso_url = "isos/CentOS-7-x86_64-Minimal-2207-02.iso"
      iso_checksum = "md5:3e39d08511a014c16730650051a0dcca"
      boot_command = [
         "<up><wait><tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
      ]
      disk_size = 10240
      headless = true
      ssh_username = "packer"
      ssh_password = "packer"
      ssh_port = 22
      ssh_wait_timeout = "30m"
      shutdown_command = "echo 'packer'|sudo -S /sbin/halt -h -p"
      vboxmanage = [
        ["modifyvm", "{{.Name}}", "--memory", "1024"],
        ["modifyvm", "{{.Name}}", "--cpus", "4"],
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"], # https://github.com/hashicorp/packer/issues/12118
      ]
      http_directory = "http"
      output_directory  = "builds/${source.name}"
      format = "ova"
}


build {
  sources = ["sources.virtualbox-iso.basic-example"]
}