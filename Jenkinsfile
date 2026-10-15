
pipeline {
    agent any

    environment {
        APP_REPO = 'https://github.com/oussamahdidou/inventory-manager-springboot-react.git'
        IMAGE_NAME = 'inventory-backend:ci'
    }

    stages {
        stage('Checkout DevOps Repository') {
            steps {
                checkout scm
            }
        }

        stage('Checkout Application') {
            steps {
                dir('application') {
                    git branch: 'main',
                        url: "${APP_REPO}"
                }
            }
        }

        stage('Build and Test') {
            steps {
                dir('application/api') {
                    sh 'chmod +x gradlew'
                    sh './gradlew --no-daemon build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} application/api'
            }
        }
    }
}
