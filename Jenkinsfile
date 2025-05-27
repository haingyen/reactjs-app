pipeline {
    agent {
        label "manager-node"
    }
    environment {
        DOCKER_HUB_USER = "haingyen"
        DOCKER_REPO = "reactjs-app"
        DOCKER_TAG = "0.1"
        DOCKER_IMAGE = "${DOCKER_HUB_USER}/${DOCKER_REPO}:${DOCKER_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/haingyen/reactjs-app.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-token', variable: 'DOCKER_HUB_TOKEN')]) {
                    sh """
                        # Đăng nhập Docker Hub bằng token
                        echo \$DOCKER_HUB_TOKEN | docker login -u ${DOCKER_HUB_USER} --password-stdin
                    """
                }
            }
        }

         stage('Push Docker Image to Dockerhub') {
            steps {
                sh "docker push ${DOCKER_IMAGE}"
            }
        }

        stage('Deploy Stack') {
            steps {
                    sh "docker stack deploy -c docker-compose.yml app"
            }
         }
    }
}