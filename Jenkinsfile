pipeline {
    agent {
        label 'linux-node'
    }
    
    environment {
        DOCKER_IMAGE = 'node-webapp'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'ls -la'
                    docker.build("${env.DOCKER_IMAGE}")
                }
            }
        }
        
        stage('Run Container') {
            steps {
                script {
                    sh 'docker stop node-webapp-container || true'
                    sh 'docker rm node-webapp-container || true'
                    docker.image("${env.DOCKER_IMAGE}").run('-p 3000:3000 -d --name node-webapp-container')
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
            script {
                sh "docker rm -f node-webapp-container || true"
                sh "docker rmi ${env.DOCKER_IMAGE} || true"
            }
        }
    }
}
