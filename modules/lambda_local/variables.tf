#variables for aws_lambda_function
variable "function_name" {
  description = "Unique name for your Lambda Function"
  type        = string
}

variable "role" {
  description = "Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources"
  type        = string
}

variable "architectures" {
  description = "Instruction set architecture for your Lambda function. Valid values are [x86_64] and [arm64]"
  type        = string
  default     = "x86_64"
  validation {
    condition     = contains(["x86_64", "arm64"], var.architectures)
    error_message = "Valid values for architectures are x86_64 and arm64. Please select on these as architectures parameter."
  }
}

variable "code_signing_config_arn" {
  description = "To enable code signing for this function, specify the ARN of a code-signing configuration"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of what your Lambda Function does"
  type        = string
  default     = null
}

variable "source_code" {
  description = <<-DOC
    source_dir:
     Package entire contents of this directory into the archive.
    content:
    Add only this content to the archive with source_content_filename as the filename.
    filename:
     Set this as the filename when using source_content.
    DOC

  type = object({
    source_dir = optional(string)
    content    = optional(string)
    filename   = optional(string)
  })

  validation {
    condition     = var.source_code.source_dir == null && var.source_code.content != null && var.source_code.filename == null || var.source_code.source_dir == null && var.source_code.filename != null && var.source_code.content == null ? false : true
    error_message = "Error! Both content and filename are required."
  }

  validation {
    condition     = var.source_code.source_dir != null && var.source_code.content != null && var.source_code.filename == null || var.source_code.source_dir != null && var.source_code.filename != null && var.source_code.content == null ? false : true
    error_message = "Error! Either provide source_dir or provide both content & filename."
  }

  validation {
    condition     = var.source_code.source_dir == null && var.source_code.content == null && var.source_code.filename == null ? false : true
    error_message = "Error! Either provide source_dir or provide both content & filename."
  }

  validation {
    condition     = var.source_code.source_dir != null && var.source_code.content != null && var.source_code.filename != null ? false : true
    error_message = "Error! Either provide source_dir or provide both content & filename."
  }

}

variable "handler" {
  description = "Function entrypoint in your code"
  type        = string
  default     = null
}

variable "layers" {
  description = "list of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function"
  type        = list(string)
  default     = null
  validation {
    condition = (var.layers == null ? true : (
    "${length(var.layers)}" <= 5))
    error_message = "Layers should not exceed a maximum of five."
  }
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 128
  validation {
    condition = (
      var.memory_size >= 128 &&
    var.memory_size <= 1024)
    error_message = "Set a value from 128 MB to 1024 MB."
  }
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version"
  type        = bool
  default     = false
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations"
  type        = number
  default     = -1
  validation {
    condition     = contains([-1, 0], var.reserved_concurrent_executions)
    error_message = "Valid values for reserved_concurrent_executions are 0 and -1. Please select on these as reserved_concurrent_executions parameter."
  }
}

variable "runtime" {
  description = "Identifier of the function's runtime"
  type        = string
  validation {
    condition     = contains(["nodejs14.x", "nodejs12.x", "python3.7", "python3.8", "python3.9", "ruby2.7", "java11", "java8.al2", "java8", "go1.x", "dotnet6", "dotnetcore3.1"], var.runtime)
    error_message = "Error! enter a valid value for runtime.Valid values are nodejs14.x, nodejs12.x, python3.7, python3.8, python3.9, ruby2.7, java11, java8.al2, java8, go1.x, dotnet6, dotnetcore3.1."
  }
}

variable "timeout" {
  description = "Amount of time your Lambda Function has to run in seconds"
  type        = number
  default     = 3
  validation {
    condition = (
      var.timeout >= 1 &&
    var.timeout <= 900)
    error_message = "Lambda function timeout value should be between 1 second to  900 seconds."
  }
}

variable "lambda_function_create_timeouts" {
  description = "How long to wait for slow uploads or EC2 throttling errors in minutes"
  type        = string
  default     = "10m"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}

module "validate_tags" {
  source  = "app.terraform.io/pgetech/validate-pge-tags/aws"
  version = "0.0.3"
  tags    = var.tags
}

variable "dead_letter_config_target_arn" {
  description = "ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted"
  type        = string
  default     = null
}

variable "environment_variables" {
  description = <<-DOC
    variables:
       Map of environment variables that are accessible from the function code during execution.
    kms_key_arn:
      Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables.The kms key is mandatory when we set the environment variables.
  DOC
  type = object({
    variables   = map(string)
    kms_key_arn = string
  })
  default = {
    variables   = null
    kms_key_arn = null
  }
  #If the argument variables is not empty then the validation will check whether the kms is valid or not.
  #If the kms_key_arn is invalid, It will give the validation error.
  validation {
    condition     = var.environment_variables.variables == null ? true : can(regex("^arn:aws:kms:\\w+(?:-\\w+)+:[[:digit:]]{12}:key/([a-zA-Z0-9])+(.*)$", var.environment_variables.kms_key_arn))
    error_message = "Error! enter a valid Kms key Arn."
  }
}

variable "file_system_config_arn" {
  description = "Amazon Resource Name (ARN) of the Amazon EFS Access Point that provides access to the file system"
  type        = string
  default     = null
}

variable "file_system_config_local_mount_path" {
  description = "Path where the function can access the file system, starting with /mnt/"
  type        = string
  default     = null
}

variable "tracing_config_mode" {
  description = "Whether to to sample and trace a subset of incoming requests with AWS X-Ray. Valid values are PassThrough and Active"
  type        = string
  default     = null
}

variable "vpc_config_security_group_ids" {
  description = "List of security group IDs associated with the Lambda function"
  type        = list(string)
}

variable "vpc_config_subnet_ids" {
  description = "List of subnet IDs associated with the Lambda function"
  type        = list(string)
}

#variables for aws_lambda_provisioned_concurrency_config
variable "provisioned_concurrent_executions" {
  description = "Amount of capacity to allocate. Must be greater than or equal to 1"
  type        = number
  default     = 0
  validation {
    condition = (var.provisioned_concurrent_executions == 0 ? true : (
    var.provisioned_concurrent_executions >= 1))
    error_message = "Error! The value must be greater than or equal to 1."
  }
}

variable "provisioned_concurrency_config_create_timeouts" {
  description = "How long to wait for the Lambda Provisioned Concurrency Config to be ready on creation"
  type        = string
  default     = "15m"
}

variable "provisioned_concurrency_config_update_timeouts" {
  description = "How long to wait for the Lambda Provisioned Concurrency Config to be ready on update"
  type        = string
  default     = "15m"
}

#variables for aws_lambda_function_event_invoke_config
variable "event_invoke_config_create" {
  description = "Specifies if aws_lambda_function_event_invoke_config is set or not"
  type        = bool
  default     = false
}

variable "event_invoke_config_maximum_event_age_in_seconds" {
  description = "Maximum age of a request that Lambda sends to a function for processing in seconds. Valid values between 60 and 21600"
  type        = number
  default     = null
  validation {
    condition = (var.event_invoke_config_maximum_event_age_in_seconds == null ? true : (
    var.event_invoke_config_maximum_event_age_in_seconds >= 60 && var.event_invoke_config_maximum_event_age_in_seconds <= 21600))
    error_message = "Error! The value must be between 60 and 21600."
  }
}

variable "event_invoke_config_maximum_retry_attempts" {
  description = "Maximum number of times to retry when the function returns an error. Valid values between 0 and 2. Defaults to 2."
  type        = number
  default     = 2
  validation {
    condition     = contains([0, 1, 2], var.event_invoke_config_maximum_retry_attempts)
    error_message = "Error! The value must be between 0 and 2."
  }
}

variable "destination_on_failure" {
  description = "Amazon Resource Name (ARN) of the destination resource for failed asynchronous invocations"
  type        = string
  default     = null
}

variable "destination_on_success" {
  description = "Amazon Resource Name (ARN) of the destination resource for successful asynchronous invocations"
  type        = string
  default     = null
}

#variables for aws_lambda_permission
variable "lambda_permission_action" {
  description = "The AWS Lambda action you want to allow in this statement"
  type        = string
  default     = null
}

variable "lambda_permission_event_source_token" {
  description = "The Event Source Token to validate. Used with Alexa Skills"
  type        = string
  default     = null
}

variable "lambda_permission_principal" {
  description = "The principal who is getting this permissionE.g., s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com"
  type        = string
  default     = null
}

variable "lambda_permission_source_account" {
  description = "This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner"
  type        = string
  default     = null
}

variable "lambda_permission_source_arn" {
  description = "When the principal is an AWS service, the ARN of the specific resource within that service to grant permission to. Without this, any resource from principal will be granted permission – even if that resource is from another account"
  type        = string
  default     = null
}