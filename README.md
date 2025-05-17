# Helm repo example

## How to use

```bash
# 1. add the repo in helm
helm repo add giropops-senhas https://eduardothums.github.io/giropops-helm-repo

# 2. install/upgrade the chart
helm upgrade --install giropops-senhas giropops-senhas/giropops-senhas

# 3. port foward the application service at 5000
k port-forward services/giropops-senhas-service 5000:5000

# 4. open the application in the browser at http://localhost:5000/
```
