"mariadb-operator": {
	alias: ""
	annotations: {}
	attributes: workload: definition: {
		apiVersion: "<change me> apps/v1"
		kind:       "<change me> Deployment"
	}
	description: ""
	labels: {}
	type: "component"
}

template: {
	output: {
		metadata: name: "mariadb-operator"
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
							valueFrom: fieldRef: fieldPath: "metadata.namespace"
						}, {
							name: "POD_NAME"
							valueFrom: fieldRef: fieldPath: "metadata.name"
						}, {
							name:  "OPERATOR_NAME"
							value: "mariadb-operator"
						}]
						command: ["mariadb-operator"]
						image:           "quay.io/manojdhanorkar/mariadb-operator:v0.0.4"
						imagePullPolicy: "Always"
					}]
					serviceAccountName: "mariadb-operator"
				}
			}
		}
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}
	outputs: {}
	parameter: {}
}
