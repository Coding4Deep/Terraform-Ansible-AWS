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
        stage('Deploy to frontend-ec2') {
            steps {
                sshagent(['tomcat_ec2_ssh_key']) {   
                    sh '''               
                        scp -o StrictHostKeyChecking=no target/*.war ubuntu@54.152.12.195:/opt/tomcat/webapps/
                        ssh -o StrictHostKeyChecking=no ubuntu@54.152.12.195 'sudo systemctl restart tomcat'
                    '''
                }
            }
        }
    }
}
