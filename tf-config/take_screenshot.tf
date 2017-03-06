# Create the lambda function
resource "aws_lambda_function" "take_screenshot_lambda" {
  filename         = "dist/take_screenshot.zip"
  function_name    = "take_screenshot"
  role             = "${aws_iam_role.role.arn}"
  handler          = "take_screenshot.lambda_handler"
  runtime          = "python2.7"
  source_code_hash = "${base64sha256(file("dist/take_screenshot.zip"))}"
}
