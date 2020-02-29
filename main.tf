# can be used for additional accounts
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "#$%&-_+<>:"
}

resource "azurerm_sql_server" "server" {
  name                         = format("%s%03d", local.name, count.index + 1)
  count                        = var.num
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = var.server_version
  administrator_login          = var.sql_admin_username
  administrator_login_password = local.sql_admin_password

  tags = {
    InfrastructureAsCode = "True"
  }

  lifecycle {
    ignore_changes = [
      administrator_login_password,
      tags,
    ]
  }
}

