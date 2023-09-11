module "greetings_service" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "4.6.0"
  create_role   = false
  timeout       = 30
  source_path   = local.lambda_src_path
  function_name = local.lambda_function_name
  handler       = local.lambda_function_handler
  runtime       = local.lambda_function_runtime
  lambda_role   = aws_iam_role.iam_for_lambda.arn
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda_${local.lambda_function_name}"

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

  tags = {
    Name = "iam_for_lambda_${local.lambda_function_name}"
  }

}

## API Gateway

resource "aws_apigatewayv2_api" "lambda" {
  name          = "greetings_service"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id = aws_apigatewayv2_api.lambda.id

  name        = local.lambda_function_stage
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "greetings_service_api" {
  api_id = aws_apigatewayv2_api.lambda.id

  integration_uri    = module.greetings_service.lambda_function_invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "greetings_service_greet_route" {
  api_id = aws_apigatewayv2_api.lambda.id

  route_key = "GET /greet"
  target    = "integrations/${aws_apigatewayv2_integration.greetings_service_api.id}"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.lambda.name}"

  retention_in_days = 14
}

resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.greetings_service.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.lambda.execution_arn}/*/*"
}