variable "mysql-admin-login" {
  type = string
  description = "Login to authenticate to MySQL Server"
}
variable "mysql-admin-password" {
  type = string
  description = "Password to authenticate to MySQL Server"
}
variable "mysql-version" {
  type = string
  description = "MySQL Server version to deploy"
  default = "5.7"
}
variable "mysql-sku-name" {
  type = string
  description = "MySQL SKU Name"
  default = "5.7"
}
variable "mysql-storage" {
  type = string
  description = "MySQL Storage in MB"
  default = "5120"
}