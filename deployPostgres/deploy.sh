#!/bin/bash

helm install postgres-container bitnami/postgresql --set persistence.existingClaim=postgres-pvc --set volumePermissions.enabled=true --namespace postgres-server