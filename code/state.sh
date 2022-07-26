RESOURCE_GROUP_NAME=devops-ressources
STORAGE_ACCOUNT_NAME=storageaccountnamestate
CONTAINER_NAME=contentstate
ACCOUNT_KEY=?sv=2021-06-08&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2022-07-18T18:58:16Z&st=2022-07-18T10:58:16Z&spr=https&sig=GYKoIllQXgocKTOxYclsWXt3XDiVhxDL1581Gz47epY%3D
# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location southafricanorth

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name myKeyVault --query value -o tsv)
