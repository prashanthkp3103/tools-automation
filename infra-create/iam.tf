resource "aws_iam_role" "terraformrole" {
  name = "${var.name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })


  tags = {
    tag-key = "${var.name}-role"
  }
}

  #attacing policy to role
#   inline_policy {
#     name = "Admina-policy"
#
#     policy = jsonencode({
#       Version = "2012-10-17"
#       Statement = [
#         {
#           Action   = ["ec2:Describe*"]
#           Effect   = "Allow"
#           Resource = "*"
#         },
#       ]
#     })
#   }
  #existing role policy attachment
  resource "aws_iam_role_policy_attachment" "policy" {
    #since it is list hence count
    count      = length(var.policy_name)
    role       = aws_iam_role.terraformrole.name
    policy_arn = "arn:aws:iam::aws:policy/${var.policy_name[count.index]}"
  }

#creating instance profile for ec2
resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.name}-role"
  role = aws_iam_role.terraformrole.name
}


