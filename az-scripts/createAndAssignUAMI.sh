#!/bin/bash
# This script creates a new user-assigned managed identity and assignes it to a set of roles on a given scope.

roles=("Virtual Machine Contributor" "Log Analytics Contributor" "Azure Connected Machine Resource Administrator")
# if resource group exists, skip creation
existingRgp=$(az group list --query [].name -o tsv)
if [[ $existingRgp == *$uamiResourceGroup* ]]; then
   echo "Resource group $uamiResourceGroup already exists. Skipping creation."
else
   echo "Creating resource group $uamiResourceGroup"
   az group create -n $uamiResourceGroup -l $uamiLocation;
fi

existingIdentiy=$(az identity list --query [].name -o tsv)
if [[ $existingIdentiy == *$UAMI_NAME* ]]; then
   echo "Identity $UAMI_NAME already exists. Skipping creation."
else
   echo "Creating identity $UAMI_NAME"
   az identity create -g $uamiResourceGroup -n $UAMI_NAME --query id -o tsv;
fi

rgId=$(az group show --name $uamiResourceGroup --query "id" -o tsv)
uamiId=$(az identity show -g $uamiResourceGroup -n $UAMI_NAME --query principalId -o tsv)

for role in "${roles[@]}";
   do echo $role;
   az role assignment create --role "$role" --assignee-object-id $uamiId --assignee-principal-type ServicePrincipal --scope $rgId;
done