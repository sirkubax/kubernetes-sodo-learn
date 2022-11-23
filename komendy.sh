#testowane na Ubuntu 20.04

git clone https://github.com/so-do/kubernetes.git
cd kubernetes/pierwsze-kroki/day1

#install docker
#https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update
sudo apt-get install     ca-certificates     curl     gnupg     lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  _release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
docker ps

#install kubectl
#https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
ls
chmod +x kubectl
mv kubectl /usr/sbin/

install kind
#https://kind.sigs.k8s.io/docs/user/quick-start/
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

#create cluster
kind create cluster --config cluster.yaml


kubectl get nodes
kubectl get pods -A

#day2
cd ../day2

kubectl apply -f 01-ingress.yaml 
sleep 40
kubectl get ingress -A
kubectl get pods -A
#kubectl describe pod ingress-nginx-controller-6bccc5966-kmmm8   --namespace ingress-nginx
kubectl get pods -A
kubectl apply -f 02-app.yaml 

#day3
cd ../day3
snap install helm --classic
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install my-release bitnami/wordpress -f values.yaml 
helm ls 
kubectl get pods -A

