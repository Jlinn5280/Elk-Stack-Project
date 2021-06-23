## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![](https://github.com/Jlinn5280/Elk-Stack-Project/blob/main/Diagrams/vNet.PNG)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YAML files may be used to install only certain pieces of it, such as Filebeat.

  - [Elk Playbook](https://github.com/Jlinn5280/Elk-Stack-Project/blob/main/Ansible/elk-playbook.yml)
  - [Metricbeat Playbook](https://github.com/Jlinn5280/Elk-Stack-Project/blob/main/Ansible/metricbeat-playbook.yml)
  - [Filebeat Playbook](https://github.com/Jlinn5280/Elk-Stack-Project/blob/main/Ansible/filebeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- Load balancers help with protecting the availability aspect of the CIA triad by distributing incoming traffic and data to the webservers in the environment. 
- Jump boxes create a secure admin workstation, giving admins an origination point to launch administrative tasks.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the event logs and system metrics.
- Filebeat monitors specified log files or directories, collects log events, then forwards them to Elasticsearch or Logstash for indexing. 
- Metricbeat collects metrics from the operating system and services running on the server then forwards them to either Elasticsearch or Logstash for indexing.

The configuration details of each machine may be found below.

| Name       | Function   | IP Address | Operating system |
|------------|------------|------------|------------------|
| Jump Box   | Gateway    | 10.0.0.5   | Linux (Ubuntu)   |
| Web 1      | Server     | 10.0.0.6   | Linux (Ubuntu)   |
| Web 2      | Server     | 10.0.0.7   | Linux (Ubuntu)   |
| Web 3      | Server     | 10.0.0.8   | Linux (Ubuntu)   |
| Web 4      | Server     | 10.1.0.5   | Linux (Ubuntu)   |
| ELK Server | Log Server | 10.1.0.4   | Linux (Ubuntu)   |


### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

- Personal IP Address

Machines within the network can only be accessed by SSH.
- The Jump Box Provisioner (10.0.0.5) is the only machine able to connect to the ELK-Server (10.1.0.4) via SSH.

A summary of the access policies in place can be found in the table below.

| Name       | Publicly Accessible | Allowed IP Addresses     |
|------------|---------------------|--------------------------|
| Jump Box   | No                  | Personal IP Only         |
| Web 1      | No                  | 10.0.0.5                 |
| Web 2      | No                  | 10.0.0.5                 |
| Web 3      | No                  | 10.0.0.5                 |
| Web 4      | No                  | 10.0.0.5                 |
| ELK Server | No                  | 10.0.0.5 and Personal IP |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- The main advantage of automating configuration with Ansible is that by creating a playbook you can easily add and duplicate the new VM to run exactly like the previous installations. Services can be limited or customized, installation and updating can be streamlined, and processes can be replicated.

The playbook implements the following tasks:
- Installs docker.io
- Installs python3
- Increases virtual memory
- Downloads and Launches Docker ELK container
- Enables Docker and Filebeat services on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![](https://github.com/Jlinn5280/Elk-Stack-Project/blob/main/Images/ELK%20Container.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web 1 (10.0.0.6)
- Web 2 (10.0.0.7)
- Web 3 (10.0.0.8)
- Web 4 (10.1.0.5)

We have installed the following Beats on these machines:
- FileBeat
- MetricBeat

These Beats allow us to collect the following information from each machine:
- FileBeat is a lightweight shipper that monitors log files or directories, collects log events, then forwards them to a specified output.
- Metricbeat is a lightweight shipper that collects metrics from the operating system and services running on the server then forwards them to specified output for indexing.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml file to /etc/ansible/files/
- Update the configuration file to include the IP address of the ELK Server
- Run the playbook, and navigate to filebeat installation page on the ELK server GUI to check that the installation worked as expected.



- The playbook file is filebeat-playbook.yml and is copied to /etc/ansible/roles/
- The host file needs to be updated to make Ansible run the playbook on a specific machine. This can be done by adding the ip addresses of the machines in the appropriate sections of the Ansible hosts file then specified at the beginning command of the playbook.
- Navigate to  http://[your.ELK-VM.External.IP]:5601/app/kibana in order to check that the ELK server is running.

The commands needed:

- ssh azureuser@(Jump Public IP)
- sudo docker ps -a
- sudo docker start (Container Name)
- sudo docker attach (Container Name)
- nano hosts
- cd /etc/ansible/files
- ansible-playbook elk-playbook.yml
- cd /etc/ansible/roles
- ansible-playbook filebeat-playbook.yml
- ansible-playbook metricbeat-playbook.yml
- Open a new browser window and navigate to http://[your.ELK-VM.External.IP]:5601/app/kibana to ensure the files are being recieved
