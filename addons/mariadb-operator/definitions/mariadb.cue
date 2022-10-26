"mariadb": {
	alias: "mariadb"
    	annotations: {}
    	attributes: {}
    	description: "Mariadb represents a mariadb server"
    	labels: {}
    	type: "component"
}

template: {
	outputs:
	    "mariadb-demo":{
            apiVersion: "mariadb.persistentsys/v1alpha1"
            kind:       "MariaDB"
            "metadata":{
                    name:      parameter.name
                    namespace: parameter.namespace
            }

            spec: {
                    replicas: 1
                    template: {
                        metadata: labels: name: "mariadb"
                        spec: {
                              database: "test-db"
                              username: "db-user"
                              password: "db-user"
                              rootpwd: "password"
                              size: 1
                              image: 'mariadb/server:10.3'
                              dataStoragePath: parameter.storagepath
                              dataStorageSize: 1Gi
                        }
                    }
                }
	    }

	    "mariadb-pv": {
              apiVersion: "v1"
              kind:       "PersistentVolume"
              metadata: name: parameter.pvname
              spec: {
                      storageClassName: parameter.scname
                      accessModes: ["ReadWriteOnce"]
                      capacity: storage: parameter.storage
                      hostPath: path:    "/mnt/mariadb-data"
              }
        }

        "mariadb-pv": {
              apiVersion: "v1"
              kind:       "PersistentVolumeClaim"
              metadata: name: parameter.pvcname
              spec: {
                      storageClassName: parameter.scname
                      accessModes: ["ReadWriteOnce"]
                      capacity: storage: parameter.storage
                      volumeName: parameter.volumename
              }
        }

	parameter: {
            scname:*"maridb-sc"|string
            provisioner:*"kubernetes.io/no-provisioner"|string
            storagepath:*"/mnt/mariadbdata"|string

            pvname:*"mariadb-pv-volume"|string
            pvcname:*"mariadb-pv-claim"|string

            volumename:*"mariadb-pv-volume"|string

            podname: *"mariadb-pod"|string
            name:*"mariadb-operator"|string
	}
}
