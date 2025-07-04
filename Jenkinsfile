pipeline {
    agent { label 'terraform' }

    tools {
        maven "MAVEN3"
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'springboot' , url: 'https://github.com/Coding4Deep/Terraform-Ansible-AWS.git'
            }
        }
        stage('Build'){
            steps{
               sh 'mvn -DskipTests=true clean package'
            }
        }
        stage('Build and Deploy to Nexus') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'nexus-credentials', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
                    sh '''
                        mvn clean deploy \
                            -Dnexus.username=$NEXUS_USER \
                            -Dnexus.password=$NEXUS_PASS 
                            DaltDeploymentRepository=nexus::default::http://54.152.12.195:8081/repository/terraform_snapshot/
                    '''
                }
            }    
        }
    }
}
