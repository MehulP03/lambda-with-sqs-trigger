variable "function_name" {
  description = "Name of the Lambda function"
}

variable "lambda_handler" {
  description = "Handler function for the Lambda"
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda"
}

variable "lambda_source_dir" {
  description = "Directory containing Lambda source code"
}

variable "sqs_queue_name" {
  description = "Name of the SQS queue"
}

variable "sqs_dlq_name" {
  description = "Name of the SQS Dead Letter Queue (DLQ)"
}

variable "file_name" {
  description = "Name of the file to make zip"
}
