#!/bin/bash

echo "[INFO] Creating a Tiller-serviceAccount "

kubectl create serviceaccount tiller --namespace kube-system

echo "[INFO] Bind the tiller Service Account to the Cluster -Admin Role "

kubectl create -f tiller-clusterrolebinding.yaml

echo "[INFO] Update the existing tille-deploy "

helm init --service-account tiller --upgrade
