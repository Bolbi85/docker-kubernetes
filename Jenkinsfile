pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'bolbi85/hello-world-dogukan:latest'
	DOCKER_CREDENTIALS_ID = 'docker-registry'
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'  // Change if using a different registry
        BUILD_NAME = "${env.BUILD_NUMBER}"
        KUBE_NAMESPACE = 'default'
    }
	
    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image with a tag using the build number
                    docker.build(env.DOCKER_IMAGE, '-f /home/student/jenkins-deploy/Dockerfile .')
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
                    sh "docker push ${DOCKER_IMAGE}:${BUILD_NAME}"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl --namespace=${KUBE_NAMESPACE} apply -f deployment.yaml'
            }
        }
    }
}
