pipeline {
    agent {
        docker {
            image 'node:14-alpine'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        DOCKER_IMAGE = 'jyutiampo/node-webapp'
        DOCKER_CREDS = credentials('docker-hub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${BUILD_ID}")
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', env.DOCKER_CREDS) {
                        docker.image("${DOCKER_IMAGE}:${BUILD_ID}").push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    try {
                        sh 'docker stop node-webapp || true'
                        sh 'docker rm node-webapp || true'
                        docker.image("${DOCKER_IMAGE}:${BUILD_ID}").run(
                            '--name node-webapp -d -p 3000:3000'
                        )
                    } catch (err) {
                        echo "Deployment failed: ${err}"
                        currentBuild.result = 'FAILURE'
                        error('Deployment failed')
                    }
                }
            }
        }
    }
}
