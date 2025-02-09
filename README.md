# Δημιουργία και Ενορχήστρωση Δύο Containers (Nginx και Redis) με τη Χρήση Docker Compose και Kubernetes

Με αυτό το project, μπορείτε να χρησιμοποιήσετε τα containers εύκολα, είτε μέσω Docker Compose, είτε ανεξάρτητα, είτε μέσω Kubernetes.

---

## 1. Τι Έκανα
Αυτό το project περιλαμβάνει τη δημιουργία δύο containers: ένα για Nginx και ένα για Redis. Ο στόχος είναι να χρησιμοποιηθούν τόσο ανεξάρτητα όσο και μέσω Docker Compose ή Kubernetes για μέγιστη ευελιξία.

### **Nginx**
- Βασίστηκα στο default image `nginx:latest`.
- Δημιούργησα ένα custom Dockerfile για να αντικαταστήσω το default HTML με το δικό μου:
  ```dockerfile
  FROM nginx:latest
  COPY ./index.html /usr/share/nginx/html/index.html
  ```
- Το custom image ανέβηκε στο DockerHub: `ebairachtari/nginx-custom:latest`.

### **Redis**
- Βασίστηκα στο default image `redis:latest`.
- Δημιούργησα ένα custom Dockerfile για να προσθέσω το δικό μου αρχείο δεδομένων:
  ```dockerfile
  FROM redis:latest
  COPY dump.rdb /data/dump.rdb
  ```
- Το custom image ανέβηκε στο DockerHub: `ebairachtari/custom-redis:latest`.

### **Kubernetes**
- Δημιούργησα YAML αρχεία για την εκτέλεση των containers μέσω Kubernetes:
  - `nginx-deployment.yaml`: Deployment για το Nginx.
  - `redis-deployment.yaml`: Deployment για το Redis.
  - `nginx-service.yaml`: Service για το Nginx.
  - `redis-service.yaml`: Service για το Redis.

### **Docker Compose**
- Δημιούργησα το αρχείο `docker-compose.yaml` για να εκτελούνται τα containers με μία μόνο εντολή.

---

## 2. Τι Πρέπει να Κάνει ο Χρήστης

### **Χρήση με Docker Compose**
1. Κατεβάστε το project από το GitHub:
   ```bash
   git clone https://github.com/ebairachtari/eb_dockerProject
   cd eb_dockerProject
   ```

2. Εκτελέστε την εντολή:
   ```bash
   docker-compose up -d
   ```

3. Ελέγξτε αν τα containers τρέχουν:
   ```bash
   docker ps
   ```

4. Πρόσβαση στο **Nginx**:
   - Ανοίξτε τον browser και επισκεφθείτε: [http://localhost:8080](http://localhost:8080).

5. Πρόσβαση στο **Redis**:
   - Εκτελέστε:
     ```bash
     redis-cli -h localhost -p 6379
     ```
   - Δοκιμάστε:
     ```bash
     get hello
     get muchi
     ```

---

### **Χρήση με Ανεξάρτητα Containers**
1. Τραβήξτε τα images από το DockerHub:
   ```bash
   docker pull ebairachtari/nginx-custom:latest
   docker pull ebairachtari/custom-redis:latest
   ```

2. Εκτελέστε τα containers:
   - **Nginx**:
     ```bash
     docker run -d -p 8080:80 ebairachtari/nginx-custom:latest
     ```
   - **Redis**:
     ```bash
     docker run -d --name redis-container -p 6379:6379 -v redis-data:/data ebairachtari/custom-redis:latest
     ```

3. Πρόσβαση στο **Nginx**:
   - Ανοίξτε τον browser και επισκεφθείτε: [http://localhost:8080](http://localhost:8080).

4. Πρόσβαση στο **Redis**:
   - Εκτελέστε:
     ```bash
     redis-cli -h localhost -p 6379
     ```
   - Δοκιμάστε:
     ```bash
     get hello
     get muchi
     ```

---

### **Χρήση με Kubernetes (Minikube)**
1. Ξεκινήστε το Minikube:
   ```bash
   minikube start
   ```

2. Εγκαταστήστε τα αρχεία YAML:
   ```bash
   kubectl apply -f nginx-deployment.yaml
   kubectl apply -f redis-deployment.yaml
   kubectl apply -f nginx-service.yaml
   kubectl apply -f redis-service.yaml
   ```

3. Ελέγξτε τα Pods και τα Services:
   ```bash
   kubectl get pods
   kubectl get services
   ```

4. Πρόσβαση:
   - Ακολουθήστε τις οδηγίες για τις IP και τις θύρες που εμφανίζονται στα Services.
