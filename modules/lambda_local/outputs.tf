#outputs for aws_lambda_function
output "lambda_arn" {
  value       = aws_lambda_function.lambda_function.arn
  description = "Amazon Resource Name (ARN) identifying your Lambda Function"
}

output "lambda_invoke_arn" {
  value       = aws_lambda_function.lambda_function.invoke_arn
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri"
}

output "lambda_last_modified" {
  value       = aws_lambda_function.lambda_function.last_modified
  description = "Date this resource was last modified"
}

output "lambda_qualified_arn" {
  value       = aws_lambda_function.lambda_function.qualified_arn
  description = "ARN identifying your Lambda Function Version (if versioning is enabled via publish = true)"
}

output "lambda_signing_job_arn" {
  value       = aws_lambda_function.lambda_function.signing_job_arn
  description = "ARN of the signing job"
}

output "lambda_signing_profile_version_arn" {
  value       = aws_lambda_function.lambda_function.signing_profile_version_arn
  description = "ARN of the signing profile version"
}

output "lambda_source_code_size" {
  value       = aws_lambda_function.lambda_function.source_code_size
  description = "Size in bytes of the function .zip file"
}

output "lambda_tags_all" {
  value       = aws_lambda_function.lambda_function.tags_all
  description = "A map of tags assigned to the resource"
}

output "lambda_version" {
  value       = aws_lambda_function.lambda_function.version
  description = "Latest published version of your Lambda Function"
}

output "lambda_vpc_config_vpc_id" {
  value       = aws_lambda_function.lambda_function.vpc_config[*].vpc_id
  description = "ID of the VPC"
}

#outputs for aws_lambda_provisioned_concurrency_config
output "provisioned_concurrency_config_id" {
  value       = aws_lambda_provisioned_concurrency_config.provisioned_concurrency_config.*.id
  description = "Lambda Function name and qualifier separated by a colon (:)"
}