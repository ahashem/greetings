resource "aws_dynamodb_table" "dynamodb_table" {
  name           = "${var.name}-dynamodb"
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key
  table_class = var.table_class

  lifecycle {
    prevent_destroy = true
  }

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value["name"]
      type = attribute.value["type"]
    }
  }
}
