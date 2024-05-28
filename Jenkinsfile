pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'bolbi85/hello-world-dogukan'
        DOCKER_CREDENTIALS_ID = 'docker-registry'
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'  // Change if using a different registry
        BUILD_NAME = "${env.BUILD_NUMBER}"
        KUBE_NAMESPACE = 'default'
        GIT_REPO_URL = 'https://github.com/Bolbi85/docker-kubernetes.git'  // Vervang door je eigen GitHub repo URL
        GIT_BRANCH = 'main'  // De branch die je wilt gebruiken
    }

    stages {
        stage('Checkout') {
                steps {
                    // Haal de code en Dockerfile op uit de GitHub-repository
                    git branch: "${GIT_BRANCH}", url: "${GIT_REPO_URL}"
                }
            }

        stage('Build') {
            steps {
                script {
                    // Build the Docker image with a tag using the build number
                    docker.build("${DOCKER_IMAGE}:${BUILD_NAME}", '-f Dockerfile .')
                }
            }
        }

        stage('Login to Docker Registry') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        // Login to Docker registry
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD ${DOCKER_REGISTRY}'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to the repository
                    docker.image("${DOCKER_IMAGE}:${BUILD_NAME}").push('latest')
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl --namespace=${KUBE_NAMESPACE} apply -f deployment.yaml'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
