resource "aws_lambda_function" "lambda_function" {
  function_name = var.function_name
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  filename      = data.archive_file.notifier_package.output_path # Assume that you have your Lambda source code in a ZIP file

  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.sqs_queue.id
    }
  }

  # Specify the role for the Lambda function
  role = aws_iam_role.lambda_execution_role.arn
}

data "archive_file" "notifier_package" {
  type        = "zip"
  source_file = "${path.module}/${var.lambda_source_dir}/${var.file_name}"
  output_path = "${path.module}/${var.lambda_source_dir}/${var.file_name}.zip"
}

resource "aws_lambda_event_source_mapping" "lambda_sqs_trigger" {
  event_source_arn = aws_sqs_queue.sqs_queue.arn
  function_name    = aws_lambda_function.lambda_function.arn
  enabled          = true
  batch_size       = 10
}

