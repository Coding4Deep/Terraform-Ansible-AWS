pipeline {
    agent { label 'terraform' }

    triggers {
       githubPush()
    }

    stages{
        stage('checkout git'){
            steps{
                git branch: 'ansible' , url: 'https://github.com/Coding4Deep/Terraform-Ansible-AWS.git'
            }
        }
          
        stage('ansible test'){
            steps{  
                withCredentials([
                   string(credentialsId: 'vault_token', variable: 'VAULT_TOKEN'),
                   string(credentialsId: 'vault_addr', variable: 'VAULT_ADDR')
                ]) {
                    sh '''       
                      export AWS_ACCESS_KEY_ID=$(vault kv get -field=access_key aws-creds/myapp)
                      export AWS_SECRET_ACCESS_KEY=$(vault kv get -field=secret_key aws-creds/myapp)
                  
                      ansible-inventory  --graph
                      ansible all -m ping 
                    '''
                }              
            }
        }

        stage('installing tomcat'){
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

                        
                        ansible-playbook playbooks/frontend.yml
                    '''
                }      
            }
        }
    }
}