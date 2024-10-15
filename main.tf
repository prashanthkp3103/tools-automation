module "tool-infra-create" {
  #below loop is map variable of tools
  for_each = var.tools
  source = "./infra-create"
  name = each.key
  instance_type = each.value["instance_type"]
  #policy_name comes from variable of actual code
  policy_name = each.value["policy_name"]
  hostedzone_id = var.hostedzone_id
  ports         = each.value["ports"]
  volume_size   = each.value["volume_size"]


}