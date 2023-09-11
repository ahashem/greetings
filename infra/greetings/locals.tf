locals {
  tf_state_bucket_name        = "tf-state-demo-apps-greetings"
  tf_state_lock_dynamodb_name = "tf-state-lock-demo-apps"

  lambda_function_name              = "demo-apps-greetings"
  lambda_function_handler           = "greetings.handler"
  lambda_function_runtime           = "nodejs18.x"
  lambda_function_s3_bucket         = "demo-apps-lambda-functions"
  lambda_function_s3_key            = "greetings.zip"
  lambda_function_s3_object_version = "1.0.0"
  lambda_src_path                   = "../../dist"

  lambda_function_role_name        = "demo-apps-greetings"
  lambda_function_role_policy_name = "demo-apps-greetings"
  lambda_function_stage            = "dev"
}