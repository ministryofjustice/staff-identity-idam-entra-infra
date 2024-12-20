output "application_id" {
  value = azuread_application.entra_app_reg.id
}

output "client_id" {
  value = azuread_application.entra_app_reg.client_id
}

output "display_name" {
  value = azuread_application.entra_app_reg.display_name
}
