resource "azurerm_data_factory" "adf" {
  name                = var.adf_name
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type = "SystemAssigned"
  }

  tags = {
    creator = "Terraform"
    project = "Data Integration Pipelines"
  } 
}


resource "azurerm_data_factory_linked_service_azure_blob_storage" "linkedsource" {
  name                = "linkedservicesblobource"
  data_factory_id     = azurerm_data_factory.adf.id
  connection_string   = var.primary_connection_string_blob
}


resource "azurerm_data_factory_linked_service_azure_sql_database" "linkedsql" {
  name              = "linkedservicesql"
  data_factory_id   = azurerm_data_factory.adf.id
  connection_string = var.primary_connection_string_sql
}

resource "azurerm_data_factory_linked_service_synapse" "linkedsynapse" {
  name            = "linkedservicesynapse"
  data_factory_id = azurerm_data_factory.adf.id

  connection_string = var.primary_connection_string_synapse
}