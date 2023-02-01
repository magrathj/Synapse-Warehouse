output "database_name" {
  value = azurerm_sql_database.project_sql_database.name
}

output "server_name" {
  value = azurerm_sql_server.project_sqlserver.name
}