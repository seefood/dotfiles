if hash kubectl 2>/dev/null; then
	export KUBECONFIG=/etc/rancher/rke2/rke2.yaml
	alias k=kubectl
fi
