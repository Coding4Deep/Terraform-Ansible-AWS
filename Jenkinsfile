pipeline {
  agent { label 'terraform' }

  triggers {
    githubPush()
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'terraform', url: 'https://github.com/Coding4Deep/Terraform-Ansible-AWS.git'
      }
    }

    stage('Terraform Init with Vault AWS creds') {
      steps {
        withCredentials([
          string(credentialsId: 'vault_token', variable: 'VAULT_TOKEN'),
          string(credentialsId: 'vault_addr', variable: 'VAULT_ADDR')
        ]) {
          sh '''
            export VAULT_ADDR=$VAULT_ADDR
            export VAULT_TOKEN=$VAULT_TOKEN
            export AWS_ACCESS_KEY_ID=$(vault kv get -field=access_key aws-creds/myapp)
            export AWS_SECRET_ACCESS_KEY=$(vault kv get -field=secret_key aws-creds/myapp)

            terraform init

            terraform plan \
              -var="vault_token=$VAULT_TOKEN" \
              -var="vault_addr=$VAULT_ADDR"

            terraform destroy --auto-approve \
                -var="vault_token=$VAULT_TOKEN" \
                -var="vault_addr=$VAULT_ADDR"
          '''
        }
      }
    }
  }

  post {
    success {
      echo 'Build successful. Triggering downstream job...'
      sh 'sleep 60'
      build job: 'ansible'
    }
  }
}
