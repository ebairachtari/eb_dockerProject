t# Δημιουργία και Ενορχήστρωση Δύο Containers με τη Χρήση Docker Compose και Kubernetes

## 1. Απαιτήσεις Συστήματος
Για να εκτελέσετε το project, βεβαιωθείτε ότι έχετε εγκαταστήσει:
- Docker Desktop (ή το Docker CLI) και ενεργοποιήστε το WSL 2 αν χρησιμοποιείτε Windows. 
- Git
- (Προαιρετικά) Minikube για Kubernetes.

## 2. Επεξήγηση
### **Nginx**
- Βασίστηκα στο default image `nginx:latest`.
- Δημιούργησα ένα custom Dockerfile για να αντικαταστήσω το default HTML με το δικό μου.
  - Το custom image ανέβηκε στο DockerHub: `ebairachtari/nginx-custom:latest`.

### **Redis**
- Βασίστηκα στο default image `redis:latest`.
- Δημιούργησα ένα custom Dockerfile για να προσθέσω το δικό μου αρχείο δεδομένων:
  - Το custom image ανέβηκε στο DockerHub: `ebairachtari/custom-redis:latest`.

### **Kubernetes**
- Δημιούργησα YAML αρχεία για την εκτέλεση των containers μέσω Kubernetes:
  - `nginx-deployment.yaml`: Deployment για το Nginx.
  - `redis-deployment.yaml`: Deployment για το Redis.
  - `nginx-service.yaml`: Service για το Nginx.
  - `redis-service.yaml`: Service για το Redis.

### **Docker Compose**
- Δημιούργησα το αρχείο `docker-compose.yaml` για να εκτελούνται τα containers με μία μόνο εντολή.

## 3. Τρόποι εκτέλεσης

### **Χρήση με Ανεξάρτητα Containers**
1. Τραβήξτε τα images από το DockerHub:
   ```bash
   docker pull ebairachtari/nginx-custom:latest
   docker pull ebairachtari/custom-redis:latest
   ```

2. Εκτελέστε τα containers:
   - **Nginx**:
     ```bash
     docker run -d --name nginx-container -p 8080:80 ebairachtari/nginx-custom:latest
     ```
   - **Redis**:
     ```bash
     docker run -d --name redis-container -p 6379:6379 -v redis-data:/data ebairachtari/custom-redis:latest
     ```

3. Πρόσβαση στο **Nginx**:
   - Ανοίξτε τον browser και επισκεφθείτε: [http://localhost:8080](http://localhost:8080).

4. Πρόσβαση στο Redis:
   - Εκτελέστε:
     ```bash
     docker exec -it redis-container redis-cli
     ```

   - Δοκιμάστε:
     ```bash
     get hello
     get welcome
     ```

---

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
   - Ανοίξτε τον browser και επισκεφθείτε: [http://localhost:8081](http://localhost:8081).

5. **Πρόσβαση στο Redis**:
   Υπάρχουν δύο επιλογές για πρόσβαση:
   - **Εσωτερικά μέσω του container**:
     ```bash
     docker exec -it compose-redis redis-cli
     ```
   - **Από το εξωτερικό σύστημα (με εγκατεστημένο `redis-cli`)**:
     ```bash
     redis-cli -h 127.0.0.1 -p 6380
     ```
   - Δοκιμάστε:
     ```bash
     get hello
     get welcome
     ```
     
---

### **Χρήση με Kubernetes (Minikube)**
1. Ξεκινήστε το Minikube:
   ```bash
   minikube start
   ```
   ή
   ```bash
   minikube start --addons=default-storageclass --force
   ```   

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

3. Πρόσβαση στο **Nginx**:
   - Εκτελέστε:
     ```bash
     minikube service nginx-service
     minikube ip
     ```

4. **Πρόσβαση στο Redis**:
   Υπάρχουν δύο επιλογές για πρόσβαση:
   - **Εσωτερικά μέσω του Minikube cluster**:
     ```bash
     kubectl exec -it <redis-pod-name> -- redis-cli
     ```
     > Αντικαταστήστε το `<redis-pod-name>` με το όνομα του Pod που πήρτε από την εντολή `kubectl get pods`.

   - **Από το εξωτερικό σύστημα (με εγκατεστημένο `redis-cli`)**:
     ```bash
     minikube ip
     ```
     > Χρησιμοποίηστε την IP και την θύρα (`nodePort`) που εμφανίζεται στο `kubectl get services`: redis-cli -h <Minikube_IP> -p <NodePort>


Αυτό το κείμενο καλύπτει και τα δύο σενάρια (εσωτερικό και εξωτερικό). Θέλεις να το κάνω πιο αναλυτικό ή είσαι εντάξει με αυτό;
