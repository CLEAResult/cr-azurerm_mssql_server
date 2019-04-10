variable "rgid" {
  description = "RGID used for naming"
}

variable "location" {
  default     = "southcentralus"
  description = "Location for resources to be created"
}

variable "count" {
  default = "1"
}

variable "name_prefix" {
  default     = ""
  description = "Allows users to override the standard naming prefix.  If left as an empty string, the standard naming conventions will apply."
}

variable "environment" {
  default     = "dev"
  description = "Environment used in naming lookups"
}

variable "rg_name" {
  description = "Default resource group name that the database will be created in."
}

variable "server_version" {
  description = "The version for the database server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
  default     = "12.0"
}

variable "sql_admin_username" {
  description = "The administrator username of the SQL Server."
}

variable "use_random_password" {
  default     = true
  description = "Default is true. If true, deploy the Azure SQL server with a randomly created password that will be visible in the state.  If false, you must have a valid vault_name and secret_name variable entered, which will supply the password."
}

variable "key_vault_pw" {
  default     = ""
  description = "Pass in a custom password, such as an Azure Key Vault data reference."
}

# Compute default name values
locals {
  env_id = "${lookup(module.naming.env-map, var.environment, "ENV")}"
  type   = "${lookup(module.naming.type-map, "azurerm_sql_server", "TYP")}"

  default_rgid        = "${var.rgid != "" ? var.rgid : "NORGID"}"
  default_name_prefix = "c${local.default_rgid}${local.env_id}"

  name_prefix = "${var.name_prefix != "" ? var.name_prefix : local.default_name_prefix}"
  name        = "${local.name_prefix}${local.type}"

  random_pw          = "${sha256(bcrypt(random_string.password.result))}"
  key_vault_pw       = "${data.azurerm_key_vault_secret.admin_password.value}"
  sql_admin_password = "${var.use_random_password == true ? local.random_pw : var.key_vault_pw}"
}

# This module provides a data map output to lookup naming standard references
module "naming" {
  source = "git::ssh://git@github.com/clearesult/cr-azurerm-naming.git?ref=v1.0"
}
