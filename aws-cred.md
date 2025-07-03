

## Objective:

Use **AWS Access Key ID** and **Secret Access Key** stored as Jenkins credentials in your Jenkins pipeline securely.

---

## Step 1: Add AWS Credentials in Jenkins

1. Go to **Jenkins Dashboard** → **Manage Jenkins** → **Credentials** → **(global)** → **Add Credentials**
2. Select **Kind: Secret text**
3. Add two secrets:

   * **AWS Access Key ID**

     * **Kind**: Secret text
     * **ID**: `aws_access_key_id`
     * **Secret**: Your AWS access key (`AKIA...`)
   * **AWS Secret Access Key**

     * **Kind**: Secret text
     * **ID**: `aws_secret_access_key`
     * **Secret**: Your AWS secret key (`xxxxxxxx...`)

---

## Step 2: Use These Credentials in Jenkinsfile

Here’s how your `Jenkinsfile` should look:

```groovy
pipeline {
  agent any

  environment {
    AWS_REGION = 'us-east-1'
  }

  stages {
    stage('Terraform Init with AWS Credentials') {
      steps {
        withCredentials([
          string(credentialsId: 'aws_access_key_id', variable: 'AWS_ACCESS_KEY_ID'),
          string(credentialsId: 'aws_secret_access_key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
          sh '''
            echo "Access Key: $AWS_ACCESS_KEY_ID"
            echo "Secret Key: $AWS_SECRET_ACCESS_KEY"

          '''
        }
      }
    }
  }
}
```

---

## Step 3: What Happens Here

* Jenkins securely injects your AWS credentials into environment variables
* Terraform and AWS CLI tools use:

  * `AWS_ACCESS_KEY_ID`
  * `AWS_SECRET_ACCESS_KEY`
* These variables are used **only inside the `withCredentials` block**, ensuring security

---
