# Create the lambda function
resource "aws_lambda_function" "take_screenshot_lambda" {
  filename         = "lambdas_to_upload/take_screenshot.zip"
  function_name    = "take_screenshot"
  role             = "${aws_iam_role.role.arn}"
  handler          = "take_screenshot.lambda_handler"
  runtime          = "python2.7"
  source_code_hash = "${base64sha256(file("lambdas_to_upload/take_screenshot.zip"))}"
}
