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
                    docker.build("${env.DOCKER_IMAGE}")
                }
            }
        }
        
        stage('Run Container') {
            steps {
                script {
                    docker.image("${env.DOCKER_IMAGE}").run('-p 3000:3000 -d')
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
            script {
                docker.safeImageRemove("${env.DOCKER_IMAGE}")
            }
        }
    }
}
