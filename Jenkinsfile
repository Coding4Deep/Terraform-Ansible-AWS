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
                sh '''
                   ansible-inventory --graph
                '''
            }
        }
    }
}