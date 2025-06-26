pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')        // Reference Jenkins credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        AWS_DEFAULT_REGION    = "us-east-2"
    }

    stages {
        stage('Check Terraform') {
            steps {
                bat 'terraform -v'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    bat 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    bat 'terraform apply -auto-approve -var "bucket_name=devops-static-site-bhanu-20250620"'
                }
            }
        }
    }
}
