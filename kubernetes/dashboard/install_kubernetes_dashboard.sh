#!/bin/bash
kubectl create -f https://raw.githubusercontent.com/sonal0409ORG/educka/master/dashboard/dashboard-insecure-v2.4.0.yml
kubectl create namespace cep-project1
kubectl create serviceaccount sandry --namespace cep-project1
kubectl create clusterrolebinding sandry-access --serviceaccount=cep-project1:sandry --clusterrole=cluster-admin
#
kubectl get pods -n kubernetes-dashboard -o wide
kubectl get deployment -n kubernetes-dashboard -o wide
kubectl get svc -n kubernetes-dashboard -o wide
#
kubectl apply -f ServiceAccount.yaml
kubectl create -f token.yml
kubectl apply -f ClusterRoleBinding.yaml
kubectl -n kubernetes-dashboard describe secret mysecretname
#
