data "aws_kms_key" "kvs" {
  key_id = "alias/aws/kinesisvideo"
}