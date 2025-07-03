pipeline{
    agent { label 'terraform' }

    triggers {
        githubPush() 
    }

//     environment {
//         VAULT_ADDR = credentials('vault_addr')  
//         VAULT_TOKEN = credentials('vault_token')   
//    }
    
    stages{
        stage('checkout'){
            steps{
                git branch: 'terraform', url: 'https://github.com/Coding4Deep/Terraform-Ansible-AWS.git'
            }
        }
        stage('Terraform Plan with Vault') {
            steps {
              withCredentials([
                string(credentialsId: 'vault_token', variable: 'VAULT_TOKEN'),
                string(credentialsId: 'vault_addr', variable: 'VAULT_ADDR')
              ]) {
                sh '''
                  terraform init
                  
                  terraform plan \
                    -var="vault_token=$VAULT_TOKEN" \
                    -var="vault_addr=$VAULT_ADDR"

                  terraform apply --auto-approve 
                    -var="vault_token=$VAULT_TOKEN" \
                    -var="vault_addr=$VAULT_ADDR"
                '''
                }
            }
        }
    }
}