# prometheus-infra-automation

This project provides infrastructure automation for setting up a Prometheus server with an EC2 instance as an app that opens port 9100 for metrics that can be connected to the Prometheus server. The automation is achieved using Terraform and Ansible.

## Table of Contents

* Getting Started
* Prerequisites
* Installing
* Running the Automation
* Built With
* Authors
* License

## Getting Started

These instructions will help you get the Prometheus infrastructure automation up and running on your local machine for development and testing purposes.

## Prerequisites

To use this infrastructure automation, you must have the following software installed on your machine:

* Terraform
* Ansible

## Installing
1. Clone this repository to your local machine.
2. Install the required software.
3. Configure your AWS credentials.

## Running the Automation 

### Configuration

To customize the deployment for your environment, you'll need to make some changes to the Terraform and Ansible code. In particular:

* In the `app-server/terraform/main.tf` file, you'll need to update the region and ami variables to match your preferred region and Amazon Machine Image `AMI`.
* In the `prometheus-server/terraform/main.tf` file, you'll need to update the region and ami variables to match your preferred region and Amazon Machine Image `AMI`.
* In the `pometheus-server/ansible/roles/alertmanager/alertmanager.yml` file, update the email address for alert notifications.
* In the `prometheus-server/ansible/roles/config-prometheus/prometheus.yml` file, update the target app-server by adding the public DNS of the app-server instance.
* In both the `app-server/ansible/inventory.txt` and `prometheus/ansible/inventory.txt` you need to add the Public Ip of each server to the inventory file.

### Usage 

1. Clone the repository

2. To create the app-server, follow these steps:

Navigate to the app-server/terraform directory.

```bash
terraform init 
terraform validate 
terraform apply 
```

3. Once the EC2 instance is created, you can configure it using Ansible also add your pem file so you can be able to connect to ec2 instance:

```bash
ansible-playbook -i inventory node-exporter.yml --private-key=[key-pair].pem
```

4. Modify the prometheus.yml file to include the public DNS of the app-server as a target.

5. To create the prometheus-server, follow these steps:

Navigate to the prometheus-server/terraform directory.

```bash
terraform init 
terraform validate 
terraform apply 
```

6. Once the EC2 instance is created, you can configure it using Ansible also add your pem file so you can be able to connect to ec2 instance:

```bash
ansible-playbook -i inventory prometheus.yml --private-key=[key-pair].pem
```

7. Once the app-server is configured, the metrics can be accessed on port `9100`. The `prometheus-server` can be accessed at `http://<prometheus-server-ip>:9090/`.

## Built With

* `Terraform` - Infrastructure as Code tool
* `Ansible` - Automation tool

## Authors

Abderrahim Elmansouri

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
