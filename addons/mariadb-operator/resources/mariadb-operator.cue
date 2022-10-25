package main

redisOperator: {
	name: "mariadb-operator"
	type: "webservice"
	properties: {
		image:           parameter.image
		imagePullPolicy: "IfNotPresent"
	}
}