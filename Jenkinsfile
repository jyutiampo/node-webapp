pipeline {
    agent {
        label 'linux-node'
    }
    environment {
        DOCKER_IMAGE = 'node-webapp'
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}")
                }
            }
        }
        stage('Run Container') {
            steps {
                script {
                    sh 'docker stop node-webapp-container || true'
                    sh 'docker rm node-webapp-container || true'
                    docker.image("${DOCKER_IMAGE}").run('-p 3000:3000 --name node-webapp-container -d')
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed!'
        }
    }
}
