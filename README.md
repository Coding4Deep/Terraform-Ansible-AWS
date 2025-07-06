#  DevOps Infrastructure Project with Terraform, Ansible 

<div align='center'

A comprehensive DevOps project that demonstrates Infrastructure as Code (IaC), Configuration Management, and Application Deployment using modern DevOps tools and practices on AWS.

</div>

---

##  Project Overview

This project showcases a complete end-to-end DevOps pipeline that includes:

- **Infrastructure Provisioning:** Terraform with modular architecture
- **Configuration Management:** Ansible with role-based automation
- **Application Development:** Spring Boot with three-tier architecture
- **Security Management:** HashiCorp Vault integration
- **CI/CD Pipeline:** Jenkins Master-Slave configuration

---

##  Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                   AWS CLOUD INFRASTRUCTURE                              │
│                                                                                         │
│  ┌─────────────────────────────────────────────────────────────────────────────────────┐ │
│  │                                  CUSTOM VPC (10.0.0.0/16)                           │ │
│  │                                                                                     │ │
│  │  ┌─────────────────────────────┐              ┌───────────────────────────────────┐ │ │
│  │  │      PUBLIC SUBNET          │              │          PRIVATE SUBNET             │ │ 
│  │  │     (10.0.1.0/24)           │              │          (10.0.2.0/24)              │ │ 
│  │  │                             │              │                                     │ │ 
│  │  │ ┌─────────────────────────┐ │              │ ┌─────────────────────────────────┐ │ │ 
│  │  │ │   🔧 FRONTEND SERVER    │ │              │ │    🗄️ BACKEND SERVERS          │ │ │ 
│  │  │ │    (Public EC2)         │ │              │ │     (Private EC2)               │ │ │ 
│  │  │ │                         │ │              │ │                                 │ │ │ 
│  │  │ │ • Jenkins Master        │ │              │ │ • MongoDB Database              │ │ │ 
│  │  │ │ • Tomcat Server         │ │              │ │ • RabbitMQ Message Broker       │ │ │ 
│  │  │ │ • Nexus Repository      │ │              │ │ • Memcached Cache               │ │ │ 
│  │  │ │ • SonarQube Scanner     │ │              │ │ • Spring Boot Application       │ │ │ 
│  │  │ └─────────────────────────┘ │              │ └─────────────────────────────────┘ │ │ 
│  │  └─────────────────────────────┘              └─────────────────────────────────────┘ │ 
│  └─────────────────────────────────────────────────────────────────────────────────────┘ │
│                                                                                          │
│   SECURITY INTEGRATION                                                                   │
│  • HashiCorp Vault for secrets management                                                │
│  • AWS credentials stored securely in Vault                                              │
│  • Terraform state stored in S3 with encryption                                          │
└────────────────────────────────────────────────────────────────────────────────────────-─┘
```

---

##  Project Structure

The project is organized across multiple Git branches for better separation of concerns:

```
terraform-ansible-aws/
├── main (branch)                    # Documentation & Vault setup
│   └── vault.md                     # HashiCorp Vault configuration guide
│
├── terraform (branch)               # Infrastructure as Code
│   ├── main.tf                      # Main Terraform configuration
│   ├── variables.tf                 # Input variables
│   ├── outputs.tf                   # Output values
│   ├── Modules/
│   │   ├── VPC/                     # VPC module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   ├── publicSubnet/
│   │   │   └── privateSubnet/
│   │   ├── EC2/                     # EC2 module
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   │   ├── publicEC2/
│   │   │   ├── privateEC2/
│   │   │   └── keypair/
│   │   └── SecurityGroup/           # Security Groups module
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       ├── outputs.tf
│   │       └── locals.tf
│   ├── Master-Slave.md              # Jenkins Master-Slave setup guide
│   └── aws-cred.md                  # AWS credentials configuration
│
├── ansible (branch)                 # Configuration Management
│   ├── ansible.cfg                  # Ansible configuration
│   ├── inventory/
│   │   └── aws_ec2.yaml            # Dynamic AWS inventory
│   ├── playbooks/
│   │   ├── site.yml                # Main playbook
│   │   ├── frontend.yml            # Frontend server setup
│   │   └── backend.yml             # Backend servers setup
│   ├── roles/
│   │   ├── frontend/               # Frontend role
│   │   │   ├── tasks/
│   │   │   │   ├── main.yml
│   │   │   │   ├── tomcat_install.yml
│   │   │   │   ├── tomcat_config.yml
│   │   │   │   ├── nexus_install.yml
│   │   │   │   └── sonar_install.yml
│   │   │   ├── handlers/
│   │   │   ├── defaults/
│   │   │   └── vars/
│   │   └── backend/                # Backend role
│   │       ├── tasks/
│   │       │   ├── main.yml
│   │       │   ├── mongo_install.yml
│   │       │   ├── memcached_install.yml
│   │       │   └── rabbitmq_install.yml
│   │       ├── handlers/
│   │       ├── defaults/
│   │       └── vars/
│   └── vault_test.yml              # Vault integration test
│
└── springboot (branch)             # Application Code
    ├── pom.xml                     # Maven configuration
    ├── src/main/java/com/example/devopsapp/
    │   ├── DevopsAppApplication.java
    │   ├── controller/             # REST Controllers
    │   │   ├── AdminController.java
    │   │   ├── AuthController.java
    │   │   └── TaskController.java
    │   ├── service/                # Business Logic
    │   │   ├── AdminService.java
    │   │   ├── UserService.java
    │   │   ├── TaskService.java
    │   │   ├── CacheService.java
    │   │   ├── ApplicationMonitoringService.java
    │   │   └── SystemMonitoringService.java
    │   ├── model/                  # Data Models
    │   │   ├── Admin.java
    │   │   ├── User.java
    │   │   └── Task.java
    │   ├── repository/             # Data Access Layer
    │   │   ├── AdminRepository.java
    │   │   ├── UserRepository.java
    │   │   └── TaskRepository.java
    │   ├── config/                 # Configuration Classes
    │   │   ├── MemcachedConfig.java
    │   │   └── RabbitMQConfig.java
    │   └── security/               # Security Configuration
    │       └── SecurityConfig.java
    └── src/main/resources/
        ├── application.properties
        ├── application-docker.properties
        └── templates/              # Thymeleaf templates
```

---

##  Technology Stack

### Infrastructure & DevOps Tools
- **Cloud Platform:** AWS (VPC, EC2, S3, IAM)
- **Infrastructure as Code:** Terraform with modular architecture
- **Configuration Management:** Ansible with role-based automation
- **Secrets Management:** HashiCorp Vault
- **CI/CD:** Jenkins (Master-Slave configuration)
- **Artifact Repository:** Nexus Repository Manager
- **Code Quality:** SonarQube
- **Version Control:** Git with multi-branch strategy

### Application Stack
- **Backend Framework:** Spring Boot 3.0.5
- **Java Version:** Java 17
- **Database:** MongoDB (NoSQL)
- **Message Broker:** RabbitMQ
- **Caching:** Memcached
- **Web Server:** Apache Tomcat
- **Template Engine:** Thymeleaf
- **Security:** Spring Security
- **Build Tool:** Maven
- **Monitoring:** Spring Boot Actuator

---

##  Getting Started

### Prerequisites

- AWS Account with appropriate permissions
- Terraform >= 0.12
- Ansible >= 2.9
- HashiCorp Vault
- Git
- Java 17+ (for Spring Boot development)
- Maven 3.6+

### 🔧 Phase 1: Infrastructure Setup with Terraform

1. **Clone the repository and switch to terraform branch:**
   ```bash
   git clone https://github.com/Coding4Deep/Terraform-Ansible-AWS.git
   cd Terraform-Ansible-AWS
   git checkout terraform
   ```

2. **Set up HashiCorp Vault (follow vault.md guide):**
   ```bash
   git checkout main
   # Follow instructions in vault.md
   ```

3. **Configure AWS credentials in Vault:**
   ```bash
   vault kv put aws-creds/myapp access_key="YOUR_ACCESS_KEY" secret_key="YOUR_SECRET_KEY"
   ```

4. **Initialize and apply Terraform:**
   ```bash
   git checkout terraform
   terraform init
   terraform plan
   terraform apply
   ```

### 🎭 Phase 2: Configuration Management with Ansible

1. **Switch to ansible branch:**
   ```bash
   git checkout ansible
   ```

2. **Update inventory with your EC2 instances:**
   ```bash
   # Edit inventory/aws_ec2.yaml with your AWS details
   ```

3. **Run Ansible playbooks:**
   ```bash
   # Setup all servers
   ansible-playbook -i inventory/aws_ec2.yaml playbooks/site.yml
   
   # Or setup individually
   ansible-playbook -i inventory/aws_ec2.yaml playbooks/frontend.yml
   ansible-playbook -i inventory/aws_ec2.yaml playbooks/backend.yml
   ```

###  Phase 3: Application Deployment

1. **Switch to springboot branch:**
   ```bash
   git checkout springboot
   ```

2. **Build the application:**
   ```bash
   mvn clean compile
   mvn package
   ```

3. **Deploy to Tomcat:**
   ```bash
   # Copy the generated WAR file to Tomcat webapps directory
   scp target/springboot.war ubuntu@<frontend-server>:/opt/tomcat/webapps/
   ```

---

##  CI/CD Pipeline Workflow

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                               COMPLETE CI/CD WORKFLOW                                   │
└─────────────────────────────────────────────────────────────────────────────────────────┘

STEP 1: DEVELOPMENT
┌─────────────────────┐
│   DEVELOPER         │
│                     │
│  • Code Changes     │
│  • Unit Tests       │
│  • Git Commit       │
│  • Push to Branch   │
└─────────────────────┘
           │
           ▼
STEP 2: BUILD & QUALITY
┌─────────────────────┐      ┌─────────────────────┐      ┌─────────────────────┐
│   JENKINS MASTER    │      │   SONARQUBE         │      │   NEXUS REPO        │
│                     │      │                     │      │                     │
│  • Checkout Code    │ ───▶│  • Code Analysis    │ ────▶│  • Artifact Storage │
│  • Maven Build      │      │  • Quality Gates    │      │  • Version Control  │
│  • Unit Tests       │      │  • Security Scan    │      │  • Release Mgmt     │
└─────────────────────┘      └─────────────────────┘      └─────────────────────┘
           │                                                        │
           ▼                                                        ▼
STEP 3: DEPLOYMENT                                    STEP 4: INFRASTRUCTURE
┌─────────────────────┐                              ┌─────────────────────┐
│   TOMCAT DEPLOY     │                              │   ANSIBLE CONFIG    │
│                     │                              │                     │
│  • WAR Deployment   │                              │  • Server Setup     │
│  • Health Checks    │                              │  • Service Config   │
│  • Rollback Ready   │                              │  • Monitoring       │
└─────────────────────┘                              └─────────────────────┘
```

---

##  Security Features

### Infrastructure Security
- **VPC Isolation:** Private subnets for backend services
- **Security Groups:** Restrictive firewall rules
- **SSH Key Management:** Secure key-based authentication
- **Secrets Management:** HashiCorp Vault integration
- **State File Security:** Encrypted S3 backend for Terraform state

### Application Security
- **Spring Security:** Authentication and authorization
- **HTTPS Ready:** SSL/TLS configuration support
- **Input Validation:** Secure data handling
- **Session Management:** Secure session configuration
- **Database Security:** MongoDB authentication

### DevOps Security
- **Vault Integration:** Secure credential storage
- **Code Quality:** SonarQube security scanning
- **Access Control:** Role-based Jenkins access
- **Audit Logging:** Comprehensive logging setup

---

## 📊 Monitoring & Observability

### Application Monitoring
- **Spring Boot Actuator:** Health checks and metrics
- **Custom Metrics:** Business logic monitoring
- **System Monitoring:** Resource utilization tracking
- **Database Monitoring:** MongoDB performance metrics

### Infrastructure Monitoring
- **AWS CloudWatch:** EC2 and VPC monitoring
- **Log Aggregation:** Centralized logging setup
- **Alert Configuration:** Proactive issue detection
- **Performance Metrics:** Response time and throughput

---

##  Service Architecture

### Frontend Tier (Public Subnet)
- **Jenkins Master:** CI/CD orchestration
- **Tomcat Server:** Web application hosting
- **Nexus Repository:** Artifact management
- **SonarQube:** Code quality analysis

### Backend Tier (Private Subnet)
- **MongoDB:** Primary database storage
- **RabbitMQ:** Asynchronous message processing
- **Memcached:** High-performance caching
- **Spring Boot App:** Business logic processing

### Data Flow
```
User Request → Load Balancer → Tomcat → Spring Boot API
                                           ↓
                                    Check Memcached Cache
                                           ↓
                                    Query MongoDB Database
                                           ↓
                                    Process RabbitMQ Messages
                                           ↓
                                    Return Response to User
```

---

##  Configuration Details

### Terraform Modules

#### VPC Module
- Creates custom VPC with public and private subnets
- Configures Internet Gateway and NAT Gateway
- Sets up route tables and network ACLs

#### EC2 Module
- Provisions public and private EC2 instances
- Manages SSH key pairs
- Configures instance profiles and IAM roles

#### Security Group Module
- Defines restrictive security group rules
- Separates frontend and backend access
- Implements least privilege principle

### Ansible Roles

#### Frontend Role
- Installs and configures Tomcat
- Sets up Jenkins Master
- Configures Nexus Repository
- Installs SonarQube

#### Backend Role
- Installs MongoDB with authentication
- Configures RabbitMQ cluster
- Sets up Memcached service
- Prepares environment for Spring Boot

---

##  Deployment Strategies

### Blue-Green Deployment
- Zero-downtime deployments
- Instant rollback capability
- Production environment isolation

### Rolling Updates
- Gradual service updates
- Continuous availability
- Automated health checks

### Canary Releases
- Risk mitigation through gradual rollout
- Performance monitoring during deployment
- Automated rollback on issues

---

## 📈 Scaling & Performance

### Horizontal Scaling
- Auto Scaling Groups for EC2 instances
- Load balancer configuration
- Database replica sets

### Vertical Scaling
- Instance type optimization
- Resource monitoring and alerting
- Performance tuning guidelines

### Caching Strategy
- Memcached for application data
- CDN integration for static content
- Database query optimization

---

## 🧪 Testing Strategy

### Unit Testing
- JUnit test cases for business logic
- Mock testing for external dependencies
- Code coverage reporting

### Integration Testing
- API endpoint testing
- Database integration tests
- Message queue testing

### Infrastructure Testing
- Terraform plan validation
- Ansible playbook testing
- Security compliance testing

---

## 📚 Documentation & Guides

### Setup Guides
- [HashiCorp Vault Setup](vault.md)
- [Jenkins Master-Slave Configuration](Master-Slave.md)
- [AWS Credentials Configuration](aws-cred.md)

### Best Practices
- Infrastructure as Code principles
- Security best practices
- CI/CD pipeline optimization
- Monitoring and alerting setup

---

##  Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

##  License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

##  Troubleshooting

### Common Issues

#### Terraform Issues
- **State Lock:** Use `terraform force-unlock` if needed
- **Provider Version:** Ensure compatible AWS provider version
- **Permissions:** Verify AWS IAM permissions

#### Ansible Issues
- **SSH Connectivity:** Check security groups and key pairs
- **Inventory:** Verify dynamic inventory configuration
- **Permissions:** Ensure sudo access on target hosts

#### Application Issues
- **Database Connection:** Verify MongoDB connectivity
- **Memory Issues:** Check JVM heap settings
- **Port Conflicts:** Ensure unique port assignments

### Support
- Create an issue in the GitHub repository
- Check existing documentation and guides
- Review logs for detailed error messages

---

##  Future Enhancements

- **Kubernetes Migration:** Container orchestration
- **Service Mesh:** Istio integration
- **GitOps:** ArgoCD implementation
- **Observability:** Prometheus and Grafana
- **Security:** OWASP ZAP integration
- **Multi-Region:** Cross-region deployment

---

##  Contact

- **GitHub:** [Coding4Deep](https://github.com/Coding4Deep)
- **Project Link:** [Terraform-Ansible-AWS](https://github.com/Coding4Deep/Terraform-Ansible-AWS)

---

*This project demonstrates enterprise-grade DevOps practices and serves as a comprehensive reference for modern infrastructure automation and application deployment.*
