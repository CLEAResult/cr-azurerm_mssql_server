provider "random" {
  version = "~> 1.0"
}

resource "random_id" "name" {
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}-${random_id.name.hex}"
  location = "${var.location}"
}

module "sql-server" {
  source             = "../../"
  rgid               = "${var.rgid}"
  rg_name            = "${basename(azurerm_resource_group.rg.id)}"
  location           = "${var.location}"
  sql_admin_username = "${var.sql_admin_username}"
  key_vault_pw       = "${var.sql_admin_password}"
}
