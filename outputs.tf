output "s3_bucket_id" {
  value       = aws_s3_bucket.bucket.id
  description = "Name of Backend S3 Bucket"
}

output "dynamodb_table_id" {
  value       = aws_dynamodb_table.this.id
  description = "Name of Backend DynamoDB Table"
}