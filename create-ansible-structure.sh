#!/bin/bash

# Root files
touch ansible.cfg
touch aws_instances.yaml

# Playbooks folder and files
mkdir -p playbooks
touch playbooks/jenkins.yml
touch playbooks/nexus.yml
touch playbooks/sonarqube.yml
touch playbooks/site.yml
touch playbooks/tomcat.yml
touch playbooks/backend.yml

# Roles directories
mkdir -p roles
echo "✅ Ansible directory structure created successfully."
