terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "jorge_abrego"
    workspaces {
      name = "terra-house-1"
    }
  }
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_lol_worlds" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.lolw.public_path
  content_version = var.lolw.content_version
}

resource "terratowns_home" "home" {
  name = "LoL Worlds 2023 Begins"
  description = <<DESCRIPTION
I'm excited about this tournament. All my support to Korean team T1.
DESCRIPTION
  domain_name = module.home_lol_worlds.domain_name
  town = "gamers-grotto"
  content_version = var.lolw.content_version
}

module "home_payday_hosting" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.payday.public_path
  content_version = var.payday.content_version
}

resource "terratowns_home" "home_payday" {
  name = "Making your Payday Bar"
  description = <<DESCRIPTION
Since I really like Payday candy bars but they cost so much to import
into Canada, I decided I would see how I could my own Paydays bars,
and if they are most cost effective.
DESCRIPTION
  domain_name = module.home_payday_hosting.domain_name
  town = "missingo"
  content_version = var.payday.content_version
}