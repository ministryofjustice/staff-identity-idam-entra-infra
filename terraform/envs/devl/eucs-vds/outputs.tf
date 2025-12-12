output "app_roles" {
    value = data.azuread_service_principal.nerdio_api.app_role_ids
    description = "Debug app roles"
}
