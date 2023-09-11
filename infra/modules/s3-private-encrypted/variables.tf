variable "name" {
}

variable "versioning" {
  description = "The versioning state of the bucket. Valid values: Enabled, Suspended, or Disabled."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Enabled", "Suspended", "Disabled"], var.versioning)
    error_message = "Must be a valid value. Valid values: Enabled, Suspended, or Disabled."
  }
}

variable "object_ownership" {
  default = "BucketOwnerPreferred"
}

variable "acl" {
  default = "private"
}

variable "policy" {
  default = ""
}

variable "cleanup_lifecycle" {
  description = "Whether the cleanup_lifecycle rule is currently being applied. Valid values: Enabled or Disabled."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.cleanup_lifecycle)
    error_message = "Must be a valid value. Valid values: Enabled or Disabled."
  }
}

variable "lifecycle_keep_days" {
  default = 90
}

variable "noncurrent_version_lifecycle" {
  description = "Whether the noncurrent_version_lifecycle rule is currently being applied. Valid values: Enabled or Disabled."
  type        = string
  default     = "Disabled"

  validation {
    condition     = contains(["Enabled", "Disabled"], var.noncurrent_version_lifecycle)
    error_message = "Must be a valid value. Valid values: Enabled or Disabled."
  }
}

variable "noncurrent_version_lifecycle_keep_days" {
  default = 365
}

variable "block_public_acls" {
  default = false
}

variable "block_public_policy" {
  default = false
}

variable "ignore_public_acls" {
  default = false
}

variable "restrict_public_buckets" {
  default = false
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use. Valid values are AES256 and aws:kms."
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "Must be a valid value. Valid values are AES256 and aws:kms."
  }
}

variable "kms_key_id" {
  description = "The AWS KMS master key ID used for the SSE-KMS encryption."
  type        = string
  default     = ""
}