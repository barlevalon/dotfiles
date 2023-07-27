function set_xpna_k8s_cluster_region -d "Set k8s context to a specific xpna region" -a region
  aws eks --region $region update-kubeconfig --name xpna-$region
end

abbr -a xk8s set_xpna_k8s_cluster_region
