resource "aws_dynamodb_table" "terraform_state_lock" {
 name           = var.dynamodb_table_name
 billing_mode   = var.billing_mode
 hash_key       = var.hash_key

 attribute {
   name = var.dynamodb_attribute_name
   type = var.dynamodb_attribute_type

 }
}