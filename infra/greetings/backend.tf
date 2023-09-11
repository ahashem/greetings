terraform {
  backend "s3" {
    bucket         = "tf-state-demo-apps-greetings"
    key            = "demo/apps/greetings"
    dynamodb_table = "tf-state-lock-demo-apps-dynamodb"
    region         = "eu-central-1"
  }
}