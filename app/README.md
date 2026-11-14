# Node.js Service Deployment Automation

## Overview

This project demonstrates a complete Node.js service deployment pipeline using Terraform, Ansible, AWS EC2, and GitHub Actions.

The application exposes a `/` endpoint that returns `Hello, world!`.

## Roadmap.sh Project

https://roadmap.sh/projects/nodejs-service-deployment

## Technologies Used

- AWS EC2
- Terraform
- Ansible
- Node.js
- npm
- NGINX
- systemd
- Git
- GitHub
- GitHub Actions
- SSH

## Architecture

Developer → GitHub → GitHub Actions → Ansible → SSH → AWS EC2 → NGINX → Node.js

## Project Structure

```text
nodejs-automation/
├── terraform/
├── ansible/
│   ├── inventory.ini
│   ├── ansible.cfg
│   ├── node_service.yml
│   └── roles/
│       ├── base/
│       ├── ssh/
│       ├── nodejs/
│       ├── nginx/
│       └── app/
├── app/
│   ├── package.json
│   └── server.js
├── .github/
│   └── workflows/
│       └── deploy.yml
├── .gitignore
└── README.md
```

## Infrastructure Provisioning

Terraform provisions an AWS EC2 instance.

```bash
cd terraform
terraform init
terraform validate
terraform plan
terraform apply
```

## Server Configuration

Ansible installs and configures the server.

```bash
cd ansible
ansible webservers -m ping
ansible-playbook node_service.yml
```

## Manual Application Deployment

```bash
ansible-playbook node_service.yml --tags app
```

## Application Verification

```bash
curl http://EC2_PUBLIC_IP
```

Expected response:

```text
Hello, world!
```

## Automated Deployment

GitHub Actions deploys the application whenever code is pushed to the main branch.

Required GitHub repository secrets:

- `EC2_HOST`
- `EC2_SSH_PRIVATE_KEY`

The workflow checks out the repository, installs Ansible, configures SSH, and runs the Ansible application deployment role.

## Service Management

Check application status:

```bash
sudo systemctl status nodejs-app
```

View application logs:

```bash
sudo journalctl -u nodejs-app -f
```

Check NGINX:

```bash
sudo systemctl status nginx
```

## GitHub Repository Setup

```bash
git init
git branch -M main
git add .
git commit -m "Initial commit - Node.js deployment automation"
git remote add origin https://github.com/YOUR_USERNAME/nodejs-automation.git
git push -u origin main
```

For subsequent changes:

```bash
git add .
git commit -m "Update Node.js application"
git push origin main
```

## Learning Outcomes

- Infrastructure as Code
- Configuration Management
- Ansible roles and tags
- Node.js deployment
- NGINX reverse proxy
- systemd services
- SSH authentication
- GitHub Actions
- CI/CD automation
- GitHub Secrets management

## Author

DevOps Learning Project


