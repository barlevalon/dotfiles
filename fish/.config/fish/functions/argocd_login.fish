#!/usr/bin/env fish

# Fish function to get ArgoCD admin password and login
function argocd_login
  set -l namespace $argv[1]
  if test -z "$namespace"
    set namespace "argocd"
  end
  
  set -l context (kubectl config current-context)
  set -l region (echo $context | string replace -r ".*:(us|eu)-(east|west|north|south|central)-([0-9]).*" '$1-$2-$3')
  set -l cluster (echo $context | string replace -r ".*-([A-Z])\$" '$1')
  
  set -l server_host "argocd.$region.intacct-planning.com.cdn.cloudflare.net"
  set -l server_path "/xpna-$region-$cluster"
  
  echo "Logging in to ArgoCD at $server_host$server_path"
  set -l password (kubectl -n $namespace get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
  argocd login $server_host --username admin --password $password --insecure --grpc-web-root-path $server_path
end