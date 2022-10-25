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
	outputs:
	    "mariadb":{
            apiVersion: "mariadb.persistentsys/v1alpha1"
            kind:       "MariaDB"
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
                              database: "test-db"
                              username: "db-user"
                              password: "db-user"
                              rootpwd: "password"
                              size: 1
                              image: 'mariadb/server:10.3'
                              dataStoragePath: /mnt/data
                              dataStorageSize: 1Gi
                        }
                    }
            }
	}
	parameter: {
	    scname:*"maridb-sc"|string
        provisioner:*"kubernetes.io/no-provisioner"|string
        podname: *"mariadb-pod"|string
        name:*"mariadb-operator"|string
	}
}
