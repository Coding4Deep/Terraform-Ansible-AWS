pipeline {
    agent { label 'terraform' }

    tools {
        maven "MAVEN3"
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
    }
}
