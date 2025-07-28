pipeline {
    agent any

    tools {
        maven 'Maven 3'   // Make sure this matches the name in Jenkins tool config
        jdk 'JDK 17'
    }

    environment {
        IMAGE_NAME = 'nithiyanantham/emr-api'
        VERSION = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Nithiyanantham-Manikandan/emr-api.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$VERSION .'
            }
        }

        stage('Docker Login & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $IMAGE_NAME:$VERSION
                    '''
                }
            }
        }
    }

    post {
        always {
            echo '🎯 Jenkins Pipeline finished.'
        }
    }
}


