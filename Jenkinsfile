pipeline {
    agent any

    tools {
        maven 'Maven 3'
        jdk 'JDK 17'
    }

    environment {
        IMAGE_NAME = 'nithiyananthammanikandan/emr-api'
        VERSION = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Nithiyanantham-Manikandan/emr-api.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean verify'  // Now includes unit testing
            }
        }

        stage('Test Report') {
  steps {
    script {
      def hasReports = fileExists('target/surefire-reports')
      if (hasReports) {
        junit 'target/surefire-reports/*.xml'
      } else {
        echo '⚠️ No test reports found. Skipping JUnit report publishing.'
      }
    }
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
