resource "aws_sns_topic" "invoke_screenshot" {
  name = "invoke-screenshot-topic"
}

resource "aws_sns_topic_policy" "custom" {
  arn = "${aws_sns_topic.invoke_screenshot.arn}"

  /* TODO: Principal might be wrong here */

  policy = <<POLICY
  {
      "Version":"2012-10-17",
      "Id":"AWSAccountTopicAccess",
      "Statement" :[
          {
              "Sid":"give-1234-publish",
              "Effect":"Allow",
              "Principal" : "*",
              "Action":["sns:Publish"],
              "Resource":"${aws_sns_topic.invoke_screenshot.arn}"
          }
      ]
  }
POLICY
}

resource "aws_sns_topic_subscription" "screenshots_invoke_lambda" {
  topic_arn = "${aws_sns_topic.invoke_screenshot.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.take_screenshot_lambda.arn}"
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.take_screenshot_lambda.arn}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.invoke_screenshot.arn}"
}
