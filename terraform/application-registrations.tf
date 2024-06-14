locals {
  app_registration_list = {
    "eucs-idam-tf-test-app-reg" = {
      display_name  = "eucs-idam-tf-test-app-reg"
      owners        = ["02acc612-0cc1-4231-a44d-b1bbfcd132f7"]
      homepage_url  = "https://example.com"
      logout_url    = "https://example.com/logout"
      redirect_uris = ["https://example.com/account"]
    },
    "eucs-idam-tf-test-app-reg2" = {
      display_name  = "eucs-idam-tf-test-app-reg2"
      owners        = ["02acc612-0cc1-4231-a44d-b1bbfcd132f7"]
      homepage_url  = "https://example.com"
      logout_url    = "https://example.com/logout"
      redirect_uris = ["https://example.com/account"]
    }
  }
}
