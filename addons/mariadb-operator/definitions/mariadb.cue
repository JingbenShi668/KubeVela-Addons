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
                      storageClassName: parameter.storagename
                      accessModes: ["ReadWriteOnce"]
                      capacity: storage: parameter.storagecapacity
                      hostPath: path:    "/mnt/mariadb-data"
              }
        }

        "mariadb-pvc": {
              apiVersion: "v1"
              kind:       "PersistentVolumeClaim"
              metadata: name: parameter.pvcname
              spec: {
                      storageClassName: parameter.storagename
                      accessModes: ["ReadWriteOnce"]
                      capacity: storage: parameter.storagecapacity
                      volumeName: parameter.volumename
              }
        }

	parameter: {
	        name:*"mariadb-operator"|string
            namespace:*"mariadb-namespace"|string

            storagepath:*"/mnt/mariadbdata"|string
            storagename:*"maridb-sc"|string
            storagecapacity:*"1Gi"|string

            pvname:*"mariadb-pv-volume"|string
            pvcname:*"mariadb-pv-claim"|string
            volumename:*"mariadb-pv-volume"|string
	}
}
