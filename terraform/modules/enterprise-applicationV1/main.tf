resource "azuread_application" "enterprise_app" {
  display_name               = var.display_name
  identifier_uris            = var.identifier_uris 
  owners = var.owners
}

resource "azuread_service_principal" "application" {
  client_id = azuread_application.enterprise_app.client_id
}

resource "azuread_application_single_sign_on" "application_sso" {
  application_object_id = azuread_application.enterprise_app.object_id
  single_sign_on_mode   = var.sso_mode
}

resource "azuread_application_saml_configuration" "enterprise_app" {
  application_object_id = azuread_application.enterprise_app.object_id
  identifier_uris       = azuread_application.enterprise_app.identifier_uris
}

resource "azuread_application_saml_claim" "email" {
  application_object_id = azuread_application.enterprise_app.object_id
  name                  = "email"
  source_attribute      = "user.mail"
}

resource "azuread_application_saml_claim" "first_name" {
  application_object_id = azuread_application.enterprise_app.object_id
  name                  = "firstName"
  source_attribute      = "user.givenname"
}

resource "azuread_application_saml_claim" "last_name" {
  application_object_id = azuread_application.enterprise_app.object_id
  name                  = "lastName"
  source_attribute      = "user.surname"
}
