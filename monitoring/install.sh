#!/bin/bash

kubectl create namespace monitoring

kubectl apply --server-side -f ./operator/bundle.yaml

kubectl apply -f ./longhorn

kubectl apply -f ./node-exporter

kubectl apply -f ./kube-state-metrics

kubectl apply -f ./kubelet

# Install Prometheus

kubectl apply -f ./prometheus

watch kubectl get pods -n monitoring

# Install Grafana
kubectl apply -f ./grafana