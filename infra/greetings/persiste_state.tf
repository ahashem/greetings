module "terraform_state_lock_dynamodb" {
  source = "../modules/dynamodb"

  name     = local.tf_state_lock_dynamodb_name
  hash_key = "LockID"

  attributes = [
    {
      name = "LockID"
      type = "S"
    },
  ]

  read_capacity  = 1
  write_capacity = 1
}

module "tf_state_bucket" {
  source = "../modules/s3-private-encrypted"

  name                                   = local.tf_state_bucket_name
  acl                                    = "private"
  block_public_policy                    = true
  block_public_acls                      = true
  noncurrent_version_lifecycle           = "Enabled"
  noncurrent_version_lifecycle_keep_days = 90
  versioning                             = "Enabled"

  policy = data.aws_iam_policy_document.s3_bucket.json
}

data "aws_iam_policy_document" "s3_bucket" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        module.environment.aws_account_id,
      ]
    }

    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${local.tf_state_bucket_name}",
      "arn:aws:s3:::${local.tf_state_bucket_name}/*",
    ]
  }
}

