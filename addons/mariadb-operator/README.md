# mariadb-operator

The addon is for mariadb-operator, which setups a MariaDB server on the kubernetes.

## Install

```shell
vela addon enable /KubeVela-Addons/addons/mariadb-operator
```

## Uninstall

```shell
vela addon disable /KubeVela-Addons/addons/mariadb-operator
```

### Keep the following to mariadb-app.yaml, then vela up -f mariadb-app.yaml
```shell
apiVersion: core.oam.dev/v1beta1
kind: Application
metadata:
  name: mariadb-app
  namespace: mariadb
spec:
  components:
    - name: mariadb-component
      type: mariadb

```
