resource "aws_lambda_function" "func" {
    filename    = data.archive_file.zip.output_path
    source_code_hash = data.archive_file.zip.output_base64sha256
    function_name = "func"
    role = aws_iam_role.iam_for_lambda.arn
    handler = "func.handler"
    runtime = "python3.8"
}

resource "aws_iam_role" "iam_for_lambda" {
    name = "iam_for_lambda"

    assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

data "archive_file" "zip" {
    type = "zip"
    source_dir = "${path.module}/lambda/"
    output_path = "${path.module}/packedlambda.zip"
}