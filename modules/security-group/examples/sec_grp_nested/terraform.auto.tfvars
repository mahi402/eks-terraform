account_num = "477027688362"
aws_region  = "us-west-2"
user        = "rxuu"
aws_role    = "CloudAdmin"

nested_name = "ccoe_security_group"
description = "security group creation for ccoe terrform"

AppID              = "443"      #"Identify the application this asset belongs to by its AMPS APP ID.Format = APP-####"
Environment        = "Dev"      #Dev, Test, QA, Prod (only one)
DataClassification = "Internal" #Public, Internal, Confidential, Restricted, Privileged (only one)
CRIS               = "Low"      #"Cyber Risk Impact Score High, Medium, Low (only one)"
Notify             = ["abc1@pge.com", "def2@pge.com", "ghi3@pge.com"]
Owner              = ["abc1", "def2", "ghi3"] #"List three owners of the system, as defined by AMPS Director, Client Owner and IT Leadeg"
Compliance         = ["SOX", "HIPAA"]         #Identify assets with compliance requirements SOX, HIPAA, CCPA or None


cidr_ingress_rules = [{
  from             = 5701,
  to               = 5703,
  protocol         = "tcp",
  cidr_blocks      = ["10.90.195.128/25"]
  ipv6_cidr_blocks = []
  description      = "CCOE Ingress rules"
  },
  {
    from             = 445,
    to               = 445,
    protocol         = "tcp",
    cidr_blocks      = ["10.90.195.128/25"]
    ipv6_cidr_blocks = []
    description      = "CCOE Ingress rules"
  },
  {
    from             = 53,
    to               = 53,
    protocol         = "udp",
    cidr_blocks      = ["10.90.108.0/23"]
    ipv6_cidr_blocks = []
    description      = "CCOE Ingress rules"
  },
  {
    from             = 21,
    to               = 21,
    protocol         = "tcp",
    cidr_blocks      = ["10.90.195.128/25"]
    ipv6_cidr_blocks = []
    description      = "CCOE Ingress rules"
  },
  {
    from             = 4333,
    to               = 4333,
    protocol         = "tcp",
    cidr_blocks      = ["10.90.195.128/25"]
    ipv6_cidr_blocks = []
    description      = "CCOE Ingress rules"
  }
]

cidr_egress_rules = [{
  from             = 0,
  to               = 65535,
  protocol         = "tcp",
  cidr_blocks      = ["10.90.108.0/23"]
  ipv6_cidr_blocks = []
  description      = "CCOE egress rules"
  },
  {
    from             = 0,
    to               = 443,
    protocol         = "tcp",
    cidr_blocks      = ["10.90.108.0/23"],
    ipv6_cidr_blocks = [],
    description      = "CCOE egress rules",
  }
]

security_group_ingress_rules = [{
  from                     = 0,
  to                       = 65535,
  protocol                 = "tcp",
  source_security_group_id = "sg-0f7e9dde6768d1215",
  description              = "CCOE Ingress rules",
  },
  {
    from                     = 80,
    to                       = 80,
    protocol                 = "tcp",
    source_security_group_id = "sg-006d70663ae2e809b",
    description              = "CCOE Ingress rules",
  },
]

security_group_egress_rules = [{
  from                     = 0,
  to                       = 65535,
  protocol                 = "tcp",
  description              = "CCOE egress rules",
  source_security_group_id = "sg-0f7e9dde6768d1215",
  },
]
