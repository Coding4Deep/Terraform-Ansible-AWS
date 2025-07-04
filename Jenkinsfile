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
                sh 'mvn  clean deploy'
            }    
        }
        stage('Deploy to frontend-ec2') {
            steps {
                sshagent(['tomcat_ec2_ssh_key']) {   
                    sh '''     
                        scp -o StrictHostKeyChecking=no target/springboot.war ubuntu@54.152.12.195:/home/ubuntu/          
                        ssh ubuntu@54.152.12.195 "sudo systemctl stop tomcat"
                        ssh ubuntu@54.152.12.195 "sudo ls -l /opt/tomcat/webapps/"
                        ssh ubuntu@54.152.12.195 "sudo rm -rf /opt/tomcat/webapps/ROOT /opt/tomcat/webapps/ROOT.war"
                        ssh ubuntu@54.152.12.195 "sudo ls -l /opt/tomcat/webapps/"
                        ssh ubuntu@54.152.12.195 "sudo mv /home/ubuntu/springboot.war /opt/tomcat/webapps/ROOT.war"
                        ssh ubuntu@54.152.12.195 "sudo ls -l /opt/tomcat/webapps/"
                        ssh ubuntu@54.152.12.195 "sudo systemctl start tomcat"
                       
                    '''
                }
            }
        }
    }
}
