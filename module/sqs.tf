resource "aws_sqs_queue" "sqs_queue" {
  name                      = var.sqs_queue_name
  message_retention_seconds = 86400 # Change as needed
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_dlq.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue" "sqs_dlq" {
  name                      = var.sqs_dlq_name
  message_retention_seconds = 86400 # Change as needed
}

resource "aws_sqs_queue_redrive_allow_policy" "terraform_queue_redrive_allow_policy" {
  queue_url = aws_sqs_queue.sqs_dlq.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.sqs_queue.arn]
  })
}
