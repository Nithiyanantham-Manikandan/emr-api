pipeline {
    agent any

    tools {
        maven 'Maven 3'       // Update to match your Jenkins Maven name
        jdk 'JDK 17'          // Update to match your Jenkins JDK name
    }

    environment {
        IMAGE_NAME = 'emr-api'
        IMAGE_TAG  = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '✅ Checking out source code from GitHub...'
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                echo '⚙️ Building the project using Maven...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}..."
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Run Docker Container') {
            steps {
                echo '🚀 Running Docker container on port 9090...'
                sh 'docker rm -f emr-api-container || true'
                sh 'docker run -d --name emr-api-container -p 9090:9090 emr-api:latest'
            }
        }
    }

    post {
        always {
            echo '🎯 Jenkins Pipeline finished.'
        }
    }
}

