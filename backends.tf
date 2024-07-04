terraform {
  cloud {
    organization = "hrk-terraform"

    workspaces {
      name = "mtc-dev"
    }
  }
}