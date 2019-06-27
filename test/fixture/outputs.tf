output "id" {
  description = "Azure resource ID of the Azure SQL Database created."
  value       = module.sql-server.*.sql_server_id
}

output "name" {
  description = "Server name of the Azure SQL Database created."
  value       = module.sql-server.*.sql_server_name
}

output "location" {
  description = "Location of the Azure SQL Database created."
  value       = module.sql-server.*.sql_server_location
}

output "version" {
  description = "Version the Azure SQL Database created."
  value       = module.sql-server.*.sql_server_version
}

output "fqdn" {
  description = "Fully Qualified Domain Name (FQDN) of the Azure SQL Database created."
  value       = module.sql-server.*.sql_server_fqdn
}

