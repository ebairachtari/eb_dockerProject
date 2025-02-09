# Docker Containers and Orchestration for Nginx and Redis

## 1. Τι Έκανα
Αυτό το project περιλαμβάνει τη δημιουργία δύο containers: ένα για Nginx και ένα για Redis. Ο στόχος είναι να χρησιμοποιηθούν τόσο ανεξάρτητα όσο και μέσω Docker Compose ή Kubernetes για μέγιστη ευελιξία.

### **Nginx**
- Βασίστηκα στο default image `nginx:latest`.
- Δημιούργησα ένα custom Dockerfile για να αντικαταστήσω το default HTML με το δικό μου.
- Το custom image ανέβηκε στο DockerHub: `ebairachtari/nginx-custom:latest`.

### **Redis**
- Βασίστηκα στο default image `redis:latest`.
- Δημιούργησα ένα custom Dockerfile για να προσθέσω το δικό μου αρχείο δεδομένων.
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
   git clone https://github.com/ebairachtari/eb_dockerProject
   cd eb_dockerProject

2. Εκτελέστε την εντολή:
   docker-compose up -d

3. Ελέγξτε αν τα containers τρέχουν:
   docker ps

4. Πρόσβαση στο **Nginx**:
   - Ανοίξτε τον browser και επισκεφθείτε: [http://localhost:8080](http://localhost:8080).

5. Πρόσβαση στο **Redis**:
   - Εκτελέστε:

     redis-cli -h localhost -p 6379

   - Δοκιμάστε:

     get hello
     get welcome



### **Χρήση με Ανεξάρτητα Containers**
1. Τραβήξτε τα images από το DockerHub:

   docker pull ebairachtari/nginx-custom:latest
   docker pull ebairachtari/custom-redis:latest


2. Εκτελέστε τα containers:
   - **Nginx**:
     docker run -d -p 8080:80 ebairachtari/nginx-custom:latest

   - **Redis**:
     docker run -d --name redis-container -p 6379:6379 -v redis-data:/data ebairachtari/custom-redis:latest


3. Πρόσβαση στο **Nginx**:
   - Ανοίξτε τον browser και επισκεφθείτε: [http://localhost:8080](http://localhost:8080).

4. Πρόσβαση στο **Redis**:
   - Εκτελέστε:

     redis-cli -h localhost -p 6379

   - Δοκιμάστε:

     get hello
     get welcome

**Χρήση με Kubernetes (Minikube)**
1. Ξεκινήστε το Minikube:

   minikube start


3. Εγκαταστήστε τα αρχεία YAML:
   ```bash
   kubectl apply -f nginx-deployment.yaml
   kubectl apply -f redis-deployment.yaml
   kubectl apply -f nginx-service.yaml
   kubectl apply -f redis-service.yaml
   ```

4. Ελέγξτε τα Pods και τα Services:
   ```bash
   kubectl get pods
   kubectl get services
   ```

5. Πρόσβαση:
   - Ακολουθήστε τις οδηγίες για τις IP και τις θύρες που εμφανίζονται στα Services.

---

Με αυτό το project, μπορείτε να χρησιμοποιήσετε τα containers εύκολα, είτε μέσω Docker Compose, είτε ανεξάρτητα, είτε μέσω Kubernetes. Αν έχετε οποιαδήποτε απορία, μη διστάσετε να επικοινωνήσετε! 😊

---

Αντιγράφοντας αυτό στο `README.md`, θα έχεις ένα όμορφα μορφοποιημένο αρχείο!
