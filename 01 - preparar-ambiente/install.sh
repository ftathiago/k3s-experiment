ansible-playbook 01-update-server.yaml -i ./inventory/01-inventory.yaml
ansible-playbook 00-rebootAll.yaml -i ./inventory/01-inventory.yaml 
ansible-playbook 02-install-controller.yaml -i ./inventory/01-inventory.yaml
ansible-playbook 03-install-agent.yaml -i ./inventory/01-inventory.yaml

# Copy kubeconfig pra máquina local
echo 
echo "Preparando ambiente para uso do Lens"
scp ftathiago@192.168.1.145:~/.kube/config ~/.kube/config
# "3de8d193-4c17-4751-b35b-94bb465fbd98" é o nome do arquivo que contem o kubeconfig do cluster no lens
cp ~/.kube/config /mnt/c/Users/ftath/AppData/Roaming/OpenLens/kubeconfigs/3de8d193-4c17-4751-b35b-94bb465fbd98 

# ## Install ingress
echo
echo "Instalando o Ingress"
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

echo
echo "Reiniciando o cluster"
ansible-playbook 00-rebootAll.yaml -i ./inventory/01-inventory.yaml

# Teste Ingress
echo
echo "Teste Ingress"
kubectl create deployment demo --image=httpd --port=80
kubectl expose deployment demo
kubectl create ingress demo-localhost --class=nginx \
  --rule="demo.localdev.me/*=demo:80"

curl demo.localdev.me