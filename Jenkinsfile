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
        stage('Compile'){
            steps{
               sh 'mvn -DskipTests=true clean compile'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') { 
                    sh 'mvn clean verify sonar:sonar'
                }
            }
        }      
        stage('Build'){
            steps{
               sh 'mvn -DskipTests=true clean package'
            }
        }        
        stage('Deploy to Nexus') {
            steps {
                sh 'mvn deploy'
            }    
        }
    }
}
