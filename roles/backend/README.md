# Backend Role - Ansible Execution Guide

This document provides a detailed guide on how to execute the `backend.yml` playbook in a controlled manner using various Ansible features. This is especially helpful during development or debugging phases when you want to run tasks step-by-step, individually, or resume from a specific task.

---

## 🧪 Option 1: Run Each Task One by One Interactively

Use Ansible's `--step` flag to prompt before executing each task.

```bash
ansible-playbook -i inventory/aws_ec2.yaml playbooks/backend.yml --step
````

### 🔍 What It Does

* Ansible will pause before each task.
* You will be prompted with:

  ```
  Perform task: <TASK_NAME> (Y/n/c):
  ```

  * Press `Y` to run
  * Press `n` to skip
  * Press `c` to cancel

---

## 🏷️ Option 2: Run a Specific Task Using Tags

You can run only selected tasks using Ansible tags. Make sure your tasks are tagged properly in `roles/backend/tasks/main.yml` like this:

```yaml
- name: Install MongoDB
  include_tasks: mongo_install.yml
  tags: mongo

- name: Configure Redis
  include_tasks: redis_install.yml
  tags: redis
```

### ▶️ Run with a Tag

To run just the MongoDB installation task:

```bash
ansible-playbook -i inventory/aws_ec2.yaml playbooks/backend.yml --tags mongo
```

To run multiple tags together:

```bash
ansible-playbook -i inventory/aws_ec2.yaml playbooks/backend.yml --tags "mongo,redis"
```

---

## 🔁 Option 3: Resume From a Specific Task

If your playbook failed or was interrupted, you can resume from a particular task name using:

```bash
ansible-playbook -i inventory/aws_ec2.yaml playbooks/backend.yml --start-at-task="Install MongoDB"
```

This is helpful for long playbooks where you don’t want to rerun everything from the beginning.

---
