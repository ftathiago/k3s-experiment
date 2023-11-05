kubectl delete namespace postgres-database
helm uninstall dev-pg
kubectl delete -f deploy.sh
kubectl delete -f local-path-storage.yml
kubectl delete -f pv.yaml
kubectl delete -f role-local-path.yaml
kubectl delete -f service.yaml
kubectl delete namespace postgres-storage