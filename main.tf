module "tool-infra-create" {
  for_each = var.tools
  source = "./infra-create"
  name = each.key
  instance_type = each.value["instance_type"]
  #policy_name comes from variable of actual code
  policy_name = each.value["policy_name"]


}