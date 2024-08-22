# Makefile for data-lakehouse-with-delta-lake-using-k8s (branch: branch)
# tweak

# Variables
KUBE_NAMESPACE := default


# Kubernetes deployment targets
deploy-config-maps:
	kubectl apply -f config/spark-master-configmap.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f config/spark-notebook-configmap.yaml -n $(KUBE_NAMESPACE)

deploy-spark-notebook:
	kubectl apply -f volumes/notebooks-pv.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f volumes/notebooks-pvc.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f deployments/spark-notebook-deployment.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f services/spark-notebook-service.yaml -n $(KUBE_NAMESPACE)

deploy-spark-master:
	kubectl apply -f deployments/spark-master-deployment.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f services/spark-master-service.yaml -n $(KUBE_NAMESPACE)

deploy-spark-workers:
	kubectl apply -f deployments/spark-worker-1-deployment.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f deployments/spark-worker-2-deployment.yaml -n $(KUBE_NAMESPACE)

deploy-minio:
	kubectl apply -f volumes/minio-pv.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f volumes/minio-pvc.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f deployments/minio-deployment.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f deployments/minio-client-deployment.yaml -n $(KUBE_NAMESPACE)
	kubectl apply -f services/minio-service.yaml -n $(KUBE_NAMESPACE)
	

deploy-all: deploy-config-maps deploy-spark-notebook deploy-spark-master deploy-spark-workers deploy-minio

# Clean up targets
clean-all: 
	kubectl delete namespace $(KUBE_NAMESPACE)
