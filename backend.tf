
## La configuracion de backend no admite variables
## pasamos usuario y password en variables de entorno
## ARTIFACTORY_USERNAME y ARTIFACTORY_PASSWORD

terraform {
  backend "artifactory" {
    url      = "http://artifactory.rnd.saltosystems.com/artifactory"
    repo     = "software-terraform"
    subpath  = "test"
  }
}
