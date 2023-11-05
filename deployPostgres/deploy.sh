#!/bin/bash

# Install Postgres
kubectl apply -f local-path-storage.yml
kubectl patch storageclass local-path -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl apply -f role-local-path.yaml
kubectl apply -f pv.yaml
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install dev-pg bitnami/postgresql \
    --set primary.persistence.existingClaim=pg-pvc,auth.postgresPassword=pgpass,volumePermissions.enabled=true \
    --set auth.database=WebApiDB \
    --namespace postgres-database --create-namespace
kubectl rollout status statefulset/dev-pg-postgresql -n default --request-timeout 5m
kubectl apply -f service.yaml

# helm install dev-pg bitnami/postgresql \
#     --set primary.persistence.existingClaim=pg-pvc,auth.postgresPassword=pgpass,volumePermissions.enabled=true \
#     --set auth.database=WebApiDB