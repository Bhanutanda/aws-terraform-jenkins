pipeline {
    agent any

    environment {
        BUCKET_NAME = "devops-static-site-bhanu"
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/your-username/devops-static-site.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh "terraform apply -auto-approve -var bucket_name=${BUCKET_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo "Deployment completed!"
        }
    }
}