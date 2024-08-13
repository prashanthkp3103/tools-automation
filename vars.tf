variable "tools" {
  default = {
    github-runner = {
      instance_type = "t3.small"
      policy_name = [
        "AdministratorAccess"
      ]
      ports = {}

    }

    vault = {
      instance_type = "t3.small"
      policy_name = []
      ports = {
        vault = 8200
      }
    }


  }
}

variable "hostedzone_id" {
  default = "Z0668859214N41P8Y7GLH"
}