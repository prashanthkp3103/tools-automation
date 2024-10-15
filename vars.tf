variable "tools" {
  default = {
    github-runner = {
      instance_type = "t3.small"
      policy_name = [
        "AdministratorAccess"
      ]
      ports = {}
      volume_size = 40

    }

    vault = {
      instance_type = "t3.small"
      policy_name = []
      ports = {
        vault = 8200
      }
      volume_size = 30
    }

    minikube = {
      instance_type = "t3.medium"
      policy_name = []
      ports = {
        vault = 8433
      }
      volume_size = 50
    }



  }
}

variable "hostedzone_id" {
  default = "Z0668859214N41P8Y7GLH"
}