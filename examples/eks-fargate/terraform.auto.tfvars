
#account_num = "750713712981"
account_num        = "514712703977"
aws_region         = "us-west-2"
aws_role           = "CloudAdmin"
user               = "m7tc"
AppID              = "443"
Environment        = "Dev"      #Dev, Test, QA, Prod (only one) */
DataClassification = "Internal" #Public, Internal, Confidential, Restricted, Privileged (only one)
CRIS               = "Low"      #"Cyber Risk Impact Score High, Medium, Low (only one)"
Notify             = ["vxyk@pge.com", "sukx@pge.com", "m7tc@pge.com"]
Owner              = ["vxyk", "sukx", "m7tc"] #"List three owners of the system, as defined by AMPS Director, Client Owner and IT Leadeg"
Compliance         = ["SOX", "HIPAA"]

#uncomment this value,if testing from TFC, the value is passed to respective role arn and will be assuming for eks token generation
terraformassumerole = "TFCBProvisioningRole"
#terraformassumerole = "CloudAdmin"
k8s-version    = "1.23"    #kubernetes(eks) version, can be given latest
cluster_name   = "farg-68" #------THIS TO BE CHANGED AS PER USER NEED
fargate_type   = true
eks-param-name = "/eks/fargate"
#aws_ssm_parameters                                                 
parameter_vpc_id_name = "/vpc/id"
###for aws 750713712981 subnets
#parameter_subnet_id1_name = "/vpc/2/privatesubnet1/id"
#parameter_subnet_id2_name = "/vpc/2/privatesubnet2/id"
#parameter_subnet_id3_name = "/vpc/2/privatesubnet3/id"
##for aws 514712703977 subnets
parameter_subnet_id1_name = "/vpc/privatesubnet1/id"
parameter_subnet_id2_name = "/vpc/privatesubnet2/id"
parameter_subnet_id3_name = "/vpc/privatesubnet3/id"



#######################################
# RBAC Variables , that are need to be set by developers only.
#######################################

application_team_role     = "SuperAdmin"
readonly_roles            = ["readonly"]
create_aws_auth_configmap = false

### KMS key needed for cluster encryption

aws_kms_key_arn = "arn:aws:kms:us-west-2:514712703977:key/e41b54e1-23ca-4906-8ca0-417f10463731"
#aws_kms_key_arn                     = "arn:aws:kms:us-west-2:750713712981:key/9e70ed49-99f9-48b0-83a2-1ca4d95fad36"
enable_aws_load_balancer_controller = false # Load Balancer controller installation
enable_kube_state_metrics           = false

####External dns controller installation....below 3 parameter are required
enable_external_dns = false
eks_domain_env      = "nonprod"


#uncomment if creating the cluster in non shared account, also this is diff for prod account
#external_dns_role                   = "arn:aws:iam::514712703977:role/TFCBR53Role"
enable_external_secrets = false ######for external secrets addon

enable_fargate_efs                  = false       ##to created efs addon or not
efsvolumeid                         = "fs-abcedf" ##EFS to be created by user and given here for eks-fargate to use                            
enable_fargate_fluentbit            = false
enable_fargate_insights             = false
create_fargatecloudwatch_dashboards = false                                                 #fargate-insights should be enabled for dashboards
create_fargatecloudwatch_alarms     = false                                                 #fargate-insights should be enabled for dashboards
sns-topic                           = "arn:aws:sns:us-west-2:750713712981:eks-alarms-topic" ##sns topic to be created manually in the aws account...u execuete
cpu-evaluation-periods              = 15                                                    ##need to be given in minutes, eg: 1 min need to wait to trigger alarm
fargate-cpu-threshold               = 20000                                                 ##how much percentage the cpu threshold so that alarm triggers after 20000 cycles
network-evaluation-period           = 15                                                    ###Evaluation period in mins.
network-threshold                   = 360                                                   ## fargate pod network threshold in bytes
mem-evaluation-periods              = 15                                                    ##need to be given in minutes, eg: 15 min need to wait to trigger alarm
fargate-mem-threshold               = 180000                                                ##how much percentage the cpu threshold so that alarm triggers after 108k bytes