pipeline {
    agent { label 'terraform' }
    
    stages{
        stage('checkout'){
            git branch: ansible , url: 'https://github.com/Coding4Deep/Terraform-Ansible-AWS.git'
        }
          
        stage('ansible test'){
            sh '''
               ansible-inventory --graph
            '''
        }
    }
}