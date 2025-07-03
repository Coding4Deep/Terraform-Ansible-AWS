

#  Jenkins Master-Slave (Agent) Configuration

---

##  Step 1: Generate SSH Key on Jenkins Master

On your Jenkins **master server**, generate an SSH key pair:

```bash
ssh-keygen -t rsa -b 4096
````

This creates:

* `~/.ssh/id_rsa` → **Private key**
* `~/.ssh/id_rsa.pub` → **Public key**

---

##  Step 2: Copy Public Key to Jenkins Agent (Slave)

On the **master server**, run:

```bash
cat ~/.ssh/id_rsa.pub
```

On the **agent server**:

1. Ensure the file exists:

   ```bash
   vi /home/ubuntu/.ssh/authorized_keys
   ```

2. Paste the public key content into the file (id_rsa.pub)

3. Set the correct permissions:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

---

##  Step 3: Test SSH Connection

From the **Jenkins master**, test connectivity:

```bash
ssh ubuntu@<agent_ip>
```

 You should connect **without password prompt**.

---

##  Step 4: Add SSH Key to Jenkins

1. Navigate to:
   **Jenkins → Manage Jenkins → Credentials → Global → Add Credentials**

2. Fill the form as:

| Field       | Value                             |
| ----------- | --------------------------------- |
| Kind        | SSH Username with private key     |
| Username    | `ubuntu` *(or your agent user)*   |
| Private Key | Paste contents of `~/.ssh/id_rsa` |
| ID          | `ssh-agent-key`                   |
| Description | SSH Key for Jenkins Agent         |

---

##  Step 5: Add the Agent Node in Jenkins

1. Go to:
   **Jenkins → Manage Jenkins → Manage Nodes → New Node**

2. Name: `agent-1`

3. Choose: **Permanent Agent**

### Configure the Node:

| Field                 | Value                            |
| --------------------- | -------------------------------- |
| Remote root directory | `/home/ubuntu/jenkins-workspace` |
| Labels                | `linux`, `build-agent` (custom)  |
| Launch method         | Launch agent via SSH             |
| Host                  | `<agent_ip>`                     |
| Credentials           | Select `ssh-agent-key`           |
| Host Key Verification |  Use **Non-verifying Strategy** |

Click **Save and Launch**.

Jenkins will now SSH into the agent, copy `agent.jar`, and connect.

---

##  Step 6: Validate Connection

You should see:

```
Agent successfully connected and online
```

---

##  Bonus: Assign Builds to Agent Node

Use node **labels** to direct your jobs to this agent.

###  Declarative Pipeline Example:

```groovy
pipeline {
    agent { label 'build-agent' }

    stages {
        stage('Build') {
            steps {
                echo 'Running on build-agent node!'
                sh 'hostname'
            }
        }
    }
}
```




