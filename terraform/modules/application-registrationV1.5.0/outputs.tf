output "application_id" {
  value = azuread_application.entra_app_reg.id
}

output "client_id" {
  value = azuread_application.entra_app_reg.client_id
}