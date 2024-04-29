# main.tf

provider "aws" {
  region = "us-east-1" # Change to your desired region
}

module "lambda_sqs_dlq" {
  source = "./module"

  function_name     = var.function_name
  lambda_handler    = var.lambda_handler
  lambda_runtime    = var.lambda_runtime
  lambda_source_dir = var.lambda_source_dir
  file_name         = var.file_name
  sqs_queue_name    = var.sqs_queue_name
  sqs_dlq_name      = var.sqs_dlq_name
}
