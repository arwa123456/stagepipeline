provider "azurerm" {

    features {}
}
resource "azurerm_resource_group" "example" {
  name     = "stage-resources"
  location = "southafricanorth"
}
///////////////////////////////////////////////////////////////////
//Storage account 
resource "azurerm_storage_account" "example" {
  name                     = "storageaccountnamee"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
//storage account module
/*module "storageacc" {
    source = "../modules/storage_v1"
    storage_account_Name= var.storageaccountname
    resource_group_name=module.trainingrg.azurerm_resource_group_name
    location =module.trainingrg.azurerm_resource_group_location
    accounttier=var.accountier
    accountreplicationtype=var.actrepltype
}*/
/////////////////////////////////////////////////////////////////
resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example" {
  name                   = "my-awesome-content.zip"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "some-local-file.zip"
}

   terraform {   
 backend "azurerm" {   
      resource_group_name = "devops-ressources"  
 storage_account_name  = "storageaccountnamestate"     
 container_name        = "contentstate"     
 key                   = "terraform.tfstate"   
 } 
} 
  




