parameter: {
	//+usage=Maraidb Operator image.
    image: *"quay.io/manojdhanorkar/mariadb-operator:v0.0.4" | string
    //+usage=Namespace to deploy to, defaults to mariadb-namespace
    namespace:*"mariadb-namespace"|string
}

