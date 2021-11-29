# final_project

### Install 
```bash
sudo su

## Helm install
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
## Jenkins helm chart install ##
kubectl create namespace jenkins

kubectl get namespaces

helm repo add jenkinsci https://charts.jenkins.io

helm repo update

helm search repo jenkinsci

#1
kubectl apply -f jenkins-volume.yaml
#2
kubectl apply -f jenkins-sa.yaml

#helm uninstall jenkins -n jenkins

helm install jenkins -n jenkins -f jenkins-values.yaml jenkinsci/jenkins
#start work ingress nginx jenkins:80
kubectl apply -f jenkins-ingress.yaml

#password
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo

###########DEBUG############
#kubectl describe -n jenkins pod/jenkins-0
############################
```
###Install prometheus-operator
```bash
#install prometheus-community operator
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
#если не запущен конфиг мап
kubectl port-forward deployment/prometheus-grafana 3000:3000 --address 0.0.0.0
```

###Install config-map
```bash
kubectl apply -f config-all.yaml
kubectl apply -f config-map.yaml
```
