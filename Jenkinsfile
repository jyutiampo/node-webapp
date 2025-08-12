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
                    // Explicitly copy files to ensure they're in the build context
                    sh 'ls -la'  // Debug: Verify files exist
                    docker.build("${env.DOCKER_IMAGE}", "--file Dockerfile .")
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
                // Simplified cleanup (avoid sandbox issues)
                sh 'docker rm -f ${env.DOCKER_IMAGE} || true'
                sh 'docker rmi ${env.DOCKER_IMAGE} || true'
            }
        }
    }
}
