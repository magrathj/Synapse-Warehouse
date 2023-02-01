resource "azurerm_storage_account" "adlsnycpayroll" {
    name = "adlsnycpayroll${var.user_name}${var.user_second_initial}"
    resource_group_name      = var.resource_group_name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind             = "StorageV2"
    is_hns_enabled           = "true"

    tags = {
        creator = "Terraform"
        project = "Data Integration Pipelines"
    }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "adlsnycpayroll" {
  name               = "adlsnycpayrollstoragedatalake"
  storage_account_id = azurerm_storage_account.adlsnycpayroll.id
}



# # create containers 
resource "azurerm_storage_container" "bronze" {
  name                  = "bronze"
  storage_account_name  = azurerm_storage_account.adlsnycpayroll.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "silver" {
  name                  = "silver"
  storage_account_name  = azurerm_storage_account.adlsnycpayroll.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "gold" {
  name                  = "gold"
  storage_account_name  = azurerm_storage_account.adlsnycpayroll.name
  container_access_type = "private"
}


# upload files to blob
resource "azurerm_storage_blob" "Employee" {
  name                   = "Employee.json"
  storage_account_name   = azurerm_storage_account.adlsnycpayroll.name
  storage_container_name = azurerm_storage_container.bronze.name
  type                   = "Block"
  source                 = "./data/Employee.json"

  metadata = {
        creator = "Terraform"
        project = "Data Integration Pipelines"
  }
}
