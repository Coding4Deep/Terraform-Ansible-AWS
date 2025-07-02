pipeline{
    agent any

    triggers {
        githubPush() 
    }
    
    stages{
        stage('checkout'){
            steps{
                git branch: 'terraform', url: 'https://github.com/Coding4Deep/Terraform-Ansible-AWS.git'
            }
        }
    }
}