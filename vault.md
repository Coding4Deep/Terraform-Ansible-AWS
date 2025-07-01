
# 🛡️ Complete HashiCorp Vault Guide

This is a full walkthrough for installing, configuring, and using HashiCorp Vault on Ubuntu Linux — ideal for DevOps, SRE, and cloud security workflows.

---

## 📦 1. What is Vault?

**HashiCorp Vault** is a tool for:

- 🔐 Securely storing and accessing secrets (passwords, tokens, keys)
- 🔁 Managing dynamic secrets (e.g., AWS keys that expire)
- 🔒 Encryption as a Service
- 🧾 Secret versioning
- 👤 Access control via ACL policies

---

## 🖥️ 2. Installing Vault (Linux/Ubuntu)

### ✅ A. Install via APT (Official Method)

```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install -y vault
````

### ✅ B. Verify Installation

```bash
vault version
```

---

## ⚙️ 3. Vault Modes

| Mode        | Use Case                              | Start Command                                      |
| ----------- | ------------------------------------- | -------------------------------------------------- |
| Dev mode    | Testing only (in-memory, auto-unseal) | `vault server -dev`                                |
| Server mode | Persistent secure server              | `vault server -config=config.hcl` or via `systemd` |

---

## 🗃️ 4. Configure Vault Server

### 📄 Minimal Config File: `/etc/vault.d/vault.hcl`

```hcl
ui = true

storage "file" {
  path = "/opt/vault/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1  # ONLY for development
}

api_addr = "http://127.0.0.1:8200"
```

### 📦 Enable & Start Vault

```bash
sudo systemctl enable vault
sudo systemctl start vault
```

---

### 🔧 Set the VAULT\_ADDR Environment Variable

```bash
export VAULT_ADDR='http://127.0.0.1:8200'
```

Then run:

```bash
vault status
```

You should now see a valid response like:

```
Key             Value
---             -----
Seal Type       ...
Initialized     false
Sealed          true
...
```

### 🧠 Make `VAULT_ADDR` Persistent

```bash
echo "export VAULT_ADDR='http://127.0.0.1:8200'" >> ~/.bashrc
source ~/.bashrc
```

---

## 🧪 5. Initialize and Unseal Vault

### 🔐 Initialize Vault

```bash
vault operator init
```

This generates:

* 🔑 5 unseal keys
* 🧾 1 initial root token

➡️ **Save these securely!**

---

### 🔓 Unseal Vault (use 3 of 5 unseal keys)

```bash
vault operator unseal
```

Repeat 3 times with different keys.

---

### 🔑 Login with Root Token

```bash
vault login
```

Paste the token generated during `init`.

---

## 🔐 6. Enable KV Secrets Engine (Version 2)

```bash
vault secrets enable -path=secret kv-v2
```

---

## 📝 7. Working with Secrets

### ➕ Write a Secret

```bash
vault kv put secret/myapp username=admin password=pass123
```

### 📥 Read a Secret

```bash
vault kv get secret/myapp
```

### ✏️ Update a Secret

```bash
vault kv put secret/myapp username=admin password=NewPass
```

### ❌ Delete a Secret (Soft Delete)

```bash
vault kv delete secret/myapp
```

### 💣 Permanently Destroy Specific Version

```bash
vault kv destroy -versions=1 secret/myapp
```

---

## 🧪 10. Test Your Setup

```bash
vault status
vault kv list secret/
vault kv get secret/myapp
```

---

## 🔗 12. Useful Vault Commands

| Command                 | Purpose                      |
| ----------------------- | ---------------------------- |
| `vault status`          | Check seal status            |
| `vault kv put / get`    | Write/read versioned secrets |
| `vault kv list secret/` | List keys                    |
| `vault secrets list`    | See enabled engines          |
| `vault operator init`   | Initialize Vault server      |
| `vault operator unseal` | Unseal Vault with key shares |
| `vault login`           | Authenticate with token      |
| `vault secrets enable`  | Enable a secret engine       |
| `vault kv destroy`      | Permanently delete versions  |

---

## ✅ You're Ready!

This guide sets you up with a fully functional Vault instance for development or further customization.

Let me know if you want:

* TLS configuration for production
* Vault Helm chart (for Kubernetes)
* Dynamic secrets with AWS, MySQL, etc.
* Integration with Terraform, Jenkins, Spring Boot, or Python

---
