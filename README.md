# Creating and Orchestrating Two Containers Using Docker Compose and Kubernetes

## 1. System Requirements

To run this project, ensure you have the following installed:

- Docker Desktop (or Docker CLI). If you're using Windows, enable WSL 2.
- Git
- Minikube for Kubernetes

---

## 2. Explanation

### Nginx

- Based on the default `nginx:latest` image.  
- A custom Dockerfile was created to replace the default HTML with custom content.  
  - The custom image was pushed to DockerHub: `ebairachtari/nginx-custom:latest`.

### Redis

- Based on the default `redis:latest` image.  
- A custom Dockerfile was created to include a custom data file.  
  - The custom image was pushed to DockerHub: `ebairachtari/custom-redis:latest`.

### Kubernetes

- YAML files were created to deploy the containers via Kubernetes:
  - `nginx-deployment.yaml`: Deployment for Nginx
  - `redis-deployment.yaml`: Deployment for Redis
  - `nginx-service.yaml`: Service for Nginx
  - `redis-service.yaml`: Service for Redis

### Docker Compose

- A `docker-compose.yaml` file was created to launch both containers with a single command.

---

## 3. Execution Methods

### A. Using Standalone Containers

1. Pull the images from DockerHub:
   ```bash
   docker pull ebairachtari/nginx-custom:latest
   docker pull ebairachtari/custom-redis:latest
   ```

2. Run the containers:
   ```bash
   docker run -d --name nginx-container -p 8080:80 ebairachtari/nginx-custom:latest
   docker run -d --name redis-container -p 6379:6379 -v redis-data:/data ebairachtari/custom-redis:latest
   ```

3. Access Nginx:  
   Open your browser and visit [http://localhost:8080](http://localhost:8080)

4. Access Redis:
   ```bash
   docker exec -it redis-container redis-cli
   get hello
   ```

---

### B. Using Docker Compose

1. Clone the project from GitHub:
   ```bash
   git clone https://github.com/ebairachtari/eb_dockerProject
   cd eb_dockerProject
   ```

2. Run:
   ```bash
   docker-compose up -d
   ```

3. Verify containers are running:
   ```bash
   docker ps
   ```

4. Access Nginx:  
   Visit [http://localhost:8081](http://localhost:8081)

5. Access Redis:
   ```bash
   docker exec -it compose-redis redis-cli
   get welcome
   ```

---

### C. Using Kubernetes (Minikube)

1. Start Minikube:
   ```bash
   minikube start
   ```

2. Apply the YAML files:
   ```bash
   kubectl apply -f nginx-deployment.yaml
   kubectl apply -f redis-deployment.yaml
   kubectl apply -f nginx-service.yaml
   kubectl apply -f redis-service.yaml
   ```

3. Check pods and services:
   ```bash
   kubectl get pods
   kubectl get services
   ```

4. Access Nginx:
   ```bash
   minikube service nginx-service
   ```

5. Access Redis:
   ```bash
   kubectl exec -it <redis-pod-name> -- redis-cli
   set test "only for test"
   get test
   ```
   > Replace `<redis-pod-name>` with the actual Pod name from `kubectl get pods`

---

> **Note:** This project was developed solely for educational purposes.
