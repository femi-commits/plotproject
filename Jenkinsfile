pipeline {
    agent any

    environment {
        DOCKER_REPO = "olufemib"
        DOCKER_IMAGE = "plotly_image"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Assuming your Dockerfile is in the root of the repository
                    docker.build("${DOCKER_REPO}/${DOCKER_IMAGE}")
                }
            }
        }

        stage('Docker Login and Push') {
            steps {
                script {
                    sh "docker login -u <your_dockerhub_username> -p <your_dockerhub_password>"
                    docker.withRegistry("${DOCKER_REPO}", "<dockerhub_credentials_id>") {
                        sh "docker push ${DOCKER_REPO}/${DOCKER_IMAGE}"
                    }
                }
            }
        }


        stage('Deploy to Kubernetes') {
            steps {
                sh "kubectl apply -f deploy_svc_ingress.yaml"
            }
        }

        stage('Get Ingress External IP') {
            steps {
                sh "kubectl --kubeconfig=${KUBE_CONFIG} get ingress"
            }
        }

        stage('Access Flask App') {
            steps {
                // Replace <external_ip_address> with the actual external IP from the output
                sh "curl http://<external_ip_address>"
            }
        }
    }
}
