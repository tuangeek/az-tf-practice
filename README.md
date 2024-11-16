# Terraform Azure Backend setup

This project creats Azure storage accounts for storing backend

# Create Github Workload identities

Reference: https://www.willvelida.com/posts/using-workload-identities-bicep-deployments-powershell/

# Create a service principle to manage resources in specified Subscription

Ref: [https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli](Store Terraform state in Azure Storage)

```bash
az ad sp create-for-rbac --role="Contribtor" --scopes="/subscriptions/20000000-0000-0000-0000-000000000000"
```

# Using creds
```ps
get-content .env | foreach {
 $name, $value = $_.split('=')
 set-content env:\$name $value
}
```

## These values map to the Terraform variables like so:

- appId is the `client_id` defined above.
- password is the `client_secret` defined above.
- tenant is the `tenant_id` defined above.

example:

```json
{
  "appId": "9cd********-****-*****-*******",
  "displayName": "azure-cli-2024-11-10-14-57-19",
  "password": "**********",
  "tenant": "11f1********-****-*****-*******"
}
```


## Resource Group

Create a [resource group using TF](terraform/az-backend/main.tf#8)


## Create Storage Account

Create a [storage account using TF](terraform/az-backend/main.tf#13)


## Deployment Proection Rules

TODO

## Container

Pushing to ACR

1. Create a service principal to access ACR
2. 
```
https://stackoverflow.com/questions/68580196/how-to-push-a-docker-image-to-azure-container-registry-using-terraform
```

Logging in AZ with service principal

```ps
az login --service-principal -t "$env:ARM_TENANT_ID" -u "$env:ARM_CLIENT_ID" -p="$env:ARM_CLIENT_SECRET"
```

Get docker login
```ps
az acr login --name appregistrydevelopmentacr --expose-token
```

Save token to variable
```bash
TOKEN=$(az acr login --name appregistrydevelopmentacr --expose-token --output tsv --query accessToken)
```

Docker push
```
docker push appregistrydevelopmentacr.azurecr.io/nginx
```

# Storage Account Backend

== 1. Go to container ==
== 2. Access Control (IAM) ==
== 3. Add role assignment ==
== 4. Select `Storage Blob Data Contributor` ==
== 5. Members -> User, group, or service principal -> Select members -> azure-cli-2024-11-10-14-57-19 ==


# Issues

Needed to have service principal add roles and permissions
```
does not have authorization to perform action 'Microsoft.Authorization/roleAssignments/write' over scope
```

```
https://learn.microsoft.com/en-us/answers/questions/287573/authorization-failed-when-when-writing-a-roleassig
```