locals {
  tags = {
    department = "justice-digital"
    team       = "laa"
    source     = "terraform"
  }
}
data "azapi_resource_list" "custom_claims" {
  type      = "microsoft.graph/customAuthenticationExtension@beta"
  parent_id = "/"
}

output "available_custom_claims" {
  value = data.azapi_resource_list.custom_claims.output
}
/*
resource "azapi_resource" "custom_auth_extension" {
  name      = "laa-claims-enrichment"
  type      = "Microsoft.AzureActiveDirectory/b2cDirectories@2023-05-17-preview"
}

 resource "azapi_resource" "custom_auth_extension" {
  name      = "LAAD- LASSIE claims"
  parent_id = "/"
  type      = "microsoft.graph/identity/authenticationEventsPolicy/onTokenIssuanceStartListeners@beta"

  body = jsonencode({
    displayName = "LAAD - LASSIE claims"
    priority    = 100
    conditions  = {
      clientAppTypes = ["all"]
    }

    authenticationEventListener = {
      "@odata.type" = "#microsoft.graph.onTokenIssuanceStartExternal"
      externalUrl   = "https://laa-landing-page-dev.apps.live.cloud-platform.service.justice.gov.uk/api/v1/claims/enrich"
      timeoutInMilliseconds = 2000
      maximumRetries        = 1
      authenticationConfiguration = {
        "@odata.type"   = "#microsoft.graph.apiAuthenticationConfigurationBase"
        appId           = "77595545-15fc-4d83-89d4-3e36387dafa9"
      }
      claimsToInclude = [
        "LAA_ACCOUNTS",
        "LAA_APP_ROLES",
        "USER_EMAIL",
        "USER_NAME"
      ]
    }

    description = "Test Issuance"
  })
} */

#region Application Registrations
module "application-registration" {
  source                         = "../../../modules/application-registrationV1.2.1"
  for_each                       = var.applications
  notes                          = each.value.notes
  service_management_reference   = each.value.service_management_reference
  display_name                   = each.value.display_name
  department_name                = each.value.department_name
  team_name                      = each.value.team_name
  application_name               = each.value.application_name
  create_access_package          = each.value.create_access_package
  access_package_reviewers       = each.value.access_package_reviewers
  owners                         = each.value.owners
  allowed_groups                 = each.value.allowed_groups
  homepage_url                   = each.value.homepage_url
  logout_url                     = each.value.logout_url
  redirect_uris                  = each.value.redirect_uris
  mobile_desktop_redirect_uris   = each.value.mobile_desktop_redirect_uris
  app_roles                      = each.value.app_roles
  graph_application_permissions  = each.value.graph_application_permissions
  graph_delegated_permissions    = each.value.graph_delegated_permissions
  tenants_required               = each.value.tenants_required
  federated_identity_credentials = each.value.federated_identity_credentials
  service_principle              = each.value.service_principle
  identifier_uris                = each.value.identifier_uris
  application_contacts           = each.value.application_contacts
}
#endregion

