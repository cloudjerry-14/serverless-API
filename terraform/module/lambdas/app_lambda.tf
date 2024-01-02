# resource "aws_iam_role" "lambda_role" {
# name   = "api_Lambda_Function_Role"
# assume_role_policy = <<EOF
# {
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": "sts:AssumeRole",
#      "Principal": {
#        "Service": "lambda.amazonaws.com"
#      },
#      "Effect": "Allow",
#      "Sid": ""
#    }
#  ]
# }
# EOF
# }
# resource "aws_iam_policy" "iam_policy_for_lambda" {
 
#  name         = "aws_iam_policy_for_terraform_aws_lambda_role"
#  path         = "/"
#  description  = "AWS IAM Policy for managing aws lambda role"
#  policy = <<EOF
# {
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Action": [
#        "logs:CreateLogGroup",
#        "logs:CreateLogStream",
#        "logs:PutLogEvents"
#      ],
#      "Resource": "arn:aws:logs:*:*:*",
#      "Effect": "Allow"
#    }
#  ]
# }
# EOF
# }
 
# resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
#  role        = aws_iam_role.lambda_role.name
#  policy_arn  = aws_iam_policy.iam_policy_for_lambda.arn
# }

data "aws_iam_role" "existing_lambda_role" {
  name = "api_Lambda_Function_Role"
}
 
data "archive_file" "zip_the_python_code" {
type        = "zip"
source_dir  = "../lambda/src"
output_path = "../lambda/artifacts/app.zip"
}

resource "aws_lambda_function" "api_lambda" {
filename                       = "../lambda/artifacts/app.zip"
function_name                  = "api_lambda"
role                           = aws_iam_role.existing_lambda_role.arn
handler                        = "index.lambda_handler"
runtime                        = "python3.8"
# depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}