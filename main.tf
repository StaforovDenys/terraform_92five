# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }
  required_version = ">= 0.14.9"
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "fiveterra" {
  name     = "app-service-rg"
  location = "West Europe"
}
resource "azurerm_app_service_plan" "app_service_plan" {
  name                = "92five-plan"
  location            = azurerm_resource_group.fiveterra.location
  resource_group_name = azurerm_resource_group.fiveterra.name
  kind               = "Linux"
  reserved            = true
  sku {
        tier = "Basic"
        size = "B1"
     }
}
resource "azurerm_app_service" "app_service" {
  name                = "terra92five"
  location            = azurerm_resource_group.fiveterra.location
  resource_group_name = azurerm_resource_group.fiveterra.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id

 site_config {
      linux_fx_version = "PHP|5.6"
  }
}
resource "azurerm_mysql_server" "db-92fiveterr" {
  name                = "92-mysqlserver"
  location            = azurerm_resource_group.fiveterra.location
  resource_group_name = azurerm_resource_group.fiveterra.name

  administrator_login          =  var.mysql-admin-login
  administrator_login_password =  var.mysql-admin-password

  sku_name   = var.mysql-sku-name
  storage_mb = var.mysql-storage
  version    = var.mysql-version
  
  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = false
}
resource "azurerm_mysql_database" "mysql-db" {
  name                = "92five"
  resource_group_name = azurerm_resource_group.fiveterra.name
  server_name         = azurerm_mysql_server.db-92fiveterr.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
resource "azurerm_mysql_firewall_rule" "mysql-fw-rule" {
  name                = "MySQL Access"
  resource_group_name = azurerm_resource_group.fiveterra.name
  server_name         = azurerm_mysql_server.db-92fiveterr.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
  geo_redundant_backup_enabled      = false      