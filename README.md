# DNA-M automatic installation
## Prerequisites
libvirt package  
arp-scan package
## How to run automatic DNA-M installation on remote VM
In project root directory run:
```shell
./dnam_automatic_install.sh <some-vm-name>
``` 
This command will:  
- Create a new libvirt domain (=vm) on tnm-vm7 with CentOS 7. No java and such pre-installed.  
- Get the domain ip address using virtual mac address and arp-scan  
- Run ansible-playbook that configures hostname of vm and installs:     
  - Java 8 SDK
  - MariaDB
  - DNA-M
  - Erlang
  - RabbitMQ  
  
After installation the webstart page should be reachable on  
http://assigned-ip-address:9000    
  
To delete the vm, in project root directory run:
```shell
./scripts/delete_domain.sh <your-vm-name>
```
## How to run automatic DNA-M installation on local host
At the moment this is implemented with Vagrant. There are still some issues here that needs to be
solved. The installation works but the webstart page is not reachable from outside the vm.

