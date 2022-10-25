"mariadb-operator": {
	alias: ""
	annotations: {}
	attributes: workload: definition: {
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}
	description: ""
	labels: {}
	type: "component"
}

template: {
    output: {
            apiVersion: "storage.k8s.io/v1"
            kind:       "StorageClass"
            metadata: name: parameter.scname
            provisioner:       parameter.provisioner
            volumeBindingMode: "WaitForFirstConsumer"
    }
	outputs: mariadb{
	    apiVersion: "apps/v1"
        kind:       "Deployment"
        "metadata":{
                name:      parameter.name
                namespace: parameter.namespace
        }

        spec: {
               replicas: 1
                selector: matchLabels: name: "mariadb-operator"
                template: {
                    metadata: labels: name: "mariadb-operator"
                    spec: {
                        containers: [{
                            name: "mariadb-operator"
                            env: [{
                                name: "WATCH_NAMESPACE"
                                valueFrom: fieldRef: fieldPath: parameter.namespace
                            }, {
                                name: "POD_NAME"
                                valueFrom: fieldRef: fieldPath: parameter.podname
                            }, {
                                name:  "OPERATOR_NAME"
                                value: "mariadb-operator"
                            }]
                            command: ["mariadb-operator"]
                            image: "quay.io/manojdhanorkar/mariadb-operator:v0.0.4"
                            imagePullPolicy: "Always"
                        }]
                        serviceAccountName: "mariadb-operator"
                    }
                }
        }
	}
	parameter: {
	    scname:*"maridb-sc"|string
        provisioner:*"kubernetes.io/no-provisioner"|string

        podname: *"mariadb-pod"|string

        name:*"mariadb-operator"|string
        namespace:*"vela-system" | string
	}
}
