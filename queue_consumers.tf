resource "aws_sqs_queue" "screenshot_queue" {
  name                      = "screenshots-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = "${aws_sqs_queue.screenshot_queue.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal" : "*",
      "Action":["sqs:SendMessage", "sqs:ReceiveMessage", "sqs:GetQueueUrl"],
      "Resource": "${aws_sqs_queue.screenshot_queue.arn}"
    }
  ]
}
POLICY
}

# Create the lambda function
resource "aws_lambda_function" "screenshot_lambda" {
  filename         = "build/screenshot.zip"
  function_name    = "screenshot"
  role             = "${aws_iam_role.role.arn}"
  handler          = "screenshot.lambda_handler"
  runtime          = "python2.7"
  source_code_hash = "${base64sha256(file("build/screenshot.zip"))}"
}
