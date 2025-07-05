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
        stage('Deploying war file to tomcat using ansible fully automated'){
            steps{
                 withCredentials([
                   string(credentialsId: 'vault_token', variable: 'VAULT_TOKEN'),
                   string(credentialsId: 'vault_addr', variable: 'VAULT_ADDR')
                ]) {
                    sh '''                            
                        export AWS_ACCESS_KEY_ID=$(vault kv get -field=access_key aws-creds/myapp)
                        export AWS_SECRET_ACCESS_KEY=$(vault kv get -field=secret_key aws-creds/myapp)
                        export VAULT_ADDR=$VAULT_ADDR
                        export VAULT_TOKEN=$VAULT_TOKEN    
                        cd ansible/
                        ansible-inventory  --graph                                           
                        ansible-playbook  war_deploy.yml 
                    '''
                }      
            }
        }
    }
}
