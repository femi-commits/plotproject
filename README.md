# plotproject

---

# Flask App Deployment with Kubernetes

This repository contains a Flask application with which users can be created, read, updated, and deleted in a MySQL database. The goal is to demonstrate how to deploy this Flask application using Kubernetes (Minikube).

## Prerequisites

Before deploying the Flask app with Kubernetes, have the following prerequisites installed:

1. Docker: [Installation Guide](https://docs.docker.com/get-docker/)
2. Kubernetes: [Minikube Installation](https://minikube.sigs.k8s.io/docs/start/)
3. `kubectl`: [Kubectl Installation](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
4. Helm: [Helm Installation](https://helm.sh/docs/intro/install/)
5. Terraform: [Terraform Installation](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Application Structure

The Flask application is structured as follows:

- `userapi.py`: Main Flask application file containing the API endpoints.
- `requirements.txt`: File containing the Python dependencies required by the Flask app.
- `Dockerfile`: File for building the Docker image of the Flask app.
- `kubectl`: Kubernetes manifest files for deploying the Flask app.
- `ingress.yaml`: Kubernetes Ingress resource for exposing the Flask app externally.

## Deployment Steps

1. Clone the repository to your local machine:

```bash
git clone https://github.com/femi-commits/plotproject.git
cd app
```

2. Build the Docker image of the Flask app:

```bash
docker build -t plotly_image .
```

3. Run the Docker container locally to ensure the app is working correctly:

```bash
docker run -d -p 5000:5000 flask-app:latest
```

4. Access the Flask app in your browser or using a tool like `curl`:

```bash
curl http://localhost:5000/
```

5. Stop and remove the local Docker container:

```bash
docker stop <container_id>
docker rm <container_id>
```

6. Initialize Minikube and ensure it's running:

```bash
minikube start --driver=docker
```

7. You can also make your life easier so that you can make kubectl commands instead of having to type minikube kubectl:

```bash
alias kubectl="minikube kubectl --"
```

8. Install jenkins:
   https://www.jenkins.io/doc/book/installing/linux/
   7a. Add Jenkins User to docker group  
       sudo usermod -aG docker jenkins  
   7b. Restart Jenkins
        sudo systemctl restart jenkins
   7c. Configure Jenkins to make kubectl commands by ensuring that the kubectl configuration file (usually located at ~/.kube/config) is present on the Jenkins server and contains the        necessary credentials and cluster information to access your Minikube cluster.

9.  Create a CICD pipeline using the Jenkinsfile in the repo

10.  Configure a webhook from github so that each commit triggers a build on the Jenkins server

11. Get the Ingress external IP address:

```bash
kubectl get ingress
```

12. Access the Flask app using the external IP address/path and also externail IP address:nodePort to show that the app is accessible from the internet:

```bash
curl http://<external_ip_address>
curl http://<external_ip_address>:nodePort
```
       



## Continuous Delivery Plan

To implement continuous delivery for the Flask app, a CI/CD pipeline using Jenkins was setup to automate the building and deployment process. Here is a general outline of the CI/CD plan:

1. Set up a version control system (e.g., Git) to store the Flask app code.
2. Configure a CI/CD tool to monitor the version control system for changes and trigger builds on every commit to the main branch.
3. The CI/CD pipeline includes steps for building the Docker image and pushing the image to a container registry (e.g., Docker Hub, Google Container Registry).
4. Once the image is pushed to the container registry, the pipeline triggers a Kubernetes deployment to update the running application with the latest version.
5. For rolling updates, the pipeline can use Helm to manage the deployment and ensure zero-downtime updates.
6. Scalability: Plan for horizontal scalability of the application by utilizing Kubernetes features like Horizontal Pod Autoscaler (HPA) and Kubernetes cluster auto-scaling.





---


This `Readme.md` file provides an overview of the project, instructions for deploying the Flask app with Kubernetes, and a brief outline of the continuous delivery plan. 
