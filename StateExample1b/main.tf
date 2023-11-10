resource "aws_lambda_function" "test_lambda" {
  filename  	   = "lambda.zip"
  function_name    = "TestLambda"
  role      	   = data.terraform_remote_state.global.outputs.lambda_iam_role
  handler   	   = "index.js"
  source_code_hash = filebase64sha256("lambda.zip")
 
  runtime = "nodejs12.x"
  vpc_config {
    subnet_ids     	= [data.terraform_remote_state.global.outputs.lambda_subnet_id]
    security_group_ids  = [data.terraform_remote_state.global.outputs.tls_security_group_id]
  }
}
