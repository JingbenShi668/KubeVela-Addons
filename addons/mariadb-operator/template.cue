package main

_targetNamespace: *"vela-system" | string
if parameter.namespace != _|_ {
	_targetNamespace: parameter.namespace
}

output: {
	apiVersion: "core.oam.dev/v1beta1"
	kind:       "Application"
	spec: {
		components: [
            {
                type: "k8s-objects"
                name: "mariadb-operator"
                properties: objects: [{
                        apiVersion: "v1"
                        kind:       "Namespace"
                        metadata: name: parameter.namespace
                }]
            },
          ]
		 policies: [
            {
                type: "shared-resource"
                name: "namespace"
                properties: rules: [{
                        selector: resourceTypes: ["Namespace"]
                }]
            },
         ]
	}
}
