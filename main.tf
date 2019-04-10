# can be used for additional accounts
resource "random_string" "password" {
  length           = 16
  special          = true
  override_special = "/@\" "
}

resource "azurerm_sql_server" "server" {
  name                         = "${local.name}${format("%3d", count.index)}"
  count                        = "${var.count}"
  resource_group_name          = "${var.rg_name}"
  location                     = "${var.location}"
  version                      = "${var.server_version}"
  administrator_login          = "${var.sql_admin_username}"
  administrator_login_password = "${local.sql_admin_password}"

  tags = {
    InfrastructureAsCode = "True"
  }

  lifecycle {
    ignore_changes = ["administrator_login_password", "tags"]
  }
}
