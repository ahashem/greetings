variable "name" {
  type = string
}

variable "hash_key" {
  type = string
}

variable "table_class" {
  type = string
  default = "STANDARD_INFREQUENT_ACCESS"
}

variable "attributes" {
  type = list(any)
}

variable "read_capacity" {
}

variable "write_capacity" {
}
