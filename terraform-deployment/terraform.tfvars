aws_region         = "eu-west-3"
key_name           = "redmine-key2"
instance_type      = "t3.small"
local_ip_cidr      = "82.124.10.127/32"

redmine_private_key = <<EOT
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAwji3JwgHoHzQvIYygDA93ErnxORqISSAPlJ/xrrs1Tcpyl1z
UJOiOLdHNxDPbiiKgYpiGsL+k7oLfwQg6SOM8ZDJqh2XKS7lY+p4sHN/h+WkT5G/
mS6025O54srI921UJ1qVCEoCv6ZqxU+GBFBNJVLJU3j8VCGRmPAoyLkpo33Bw+J2
FjNXqeSTx+AVSLn/n4+VSNzsxRS0NGqK/CJu4d4AzRb0Zjzff1iepgGfAeF+HfQs
0sZEmj6MMvYcYibBXKM0dgiDpkkJi9ATkeCRjEFjbat0Rjxw9/5mnqwML4DbSLwk
EfSpzBTm2VXhyrZCw5IUqpxyYmLqZXxtg4OP+QIDAQABAoIBAHnldq38kCzdqXRp
FVD29hxItuYQJbvfWM3EoYVs1C+Ni6ECvdkYj3vhK8UXu9h7gVKEM8ZwE69L2OND
CBTKxy7lnGw0Xibu0/G9uzmjg6sbKeD2rLXLZp9ZPBVnCHKiH2sDov2s1cTLAcAM
hSQ38fM23jyRdmynFOZT9ITmEYgVz87C4lE4x03McTKwwK8GayvLSx3+0NswywxN
WIKVycPs4Rqd7AcLtCLKwKEbk2687bWjXP2EJ29hMu3RL4Ylz2FC1HzUXB11hpiE
mJVUlz+B6v23ThLRwBtO7SEixhUmMqFrTrMV0XrMCsDPGJdSvDtTUDJrnH0PhHxh
BLAiyzECgYEA+crCZxGHp69JDLivFYBYyUd04NUTl7zLxgRWFZX4tHGHxcXkQP6s
d3ftNnmWqWAg2Xp2L0ysplIBxFiwZY1C41zPVN2Orv7JF6JBCBnJEOv1/lUrwA6z
uVDNa9+F366/UKUcXfqK5O1R5iyDywOrm+rIzOW2QAmcByrxqBahbZsCgYEAxwxn
B2ZKl4P7dL3e5dfSDLrmKEhoEp+p9YARCviu8RLc4jqpvAMpkX1BtexCzL01v6Jd
fELZrkr405wCEJvYp5vIrznRbpJUFC5AGC2/JRW+eJdTsKsmT/T4g4v9U0QCZUYB
UD8Rgtf0ry/b3TqiqosdgTEyFbZ7vlWRtdvFW/sCgYEAlYr4tYG+J/p9jjsmvoWX
IfFAnLWTxDzH9eV0r/mX6lcphJKDoxGUqPVIM1u5ge9F201AYfLSTcQ8wJKkEDfw
unM+wLzfhg6MzzRZIINnZ1UMcVYGGjXzDNe+E32/BPn2GU6v2+d5rbISXO17fVfW
LkLyMhC3+kCGg5gHEq1xuU8CgYBRyE/Ao4+8RzcW1Thy+UTNhDEyleVk2YMsYm0e
M+U1Gcn1jaLVo/r9Uxifla4wjwE5do2wk4r66MTptOzIRDA1VXWUQU5Cfw7ap9If
3RPvOcrjo1F4gimgqoc9DVSNVKEjWSsK/I7GUtKu9BwC/qd9KOF7hmoMr8iSAHh4
3w5s5wKBgQDnWpdjdxOPM4a6u4y05Pau4tucvJodOS0XxLPWexgbfWhyx57KkLmG
E+K7pvpBwGyPMPH0HnhEwlKsRbcgs7Cn2RQGo3u2dF20U4LTRkZ7AlyQPvMhnCSM
1N4VdADqHLnAz+z/crucwtXVDKqneu94ZPpKJVyi4Wfu4Twj3Ml7pw==
-----END RSA PRIVATE KEY-----
EOT


vpc_name           = "redmine-vpc"
cidr_block         = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.4.0/24"]
public_subnets     = ["10.0.1.0/24","10.0.4.0/24"]
private_subnets    = ["10.0.2.0/24", "10.0.3.0/24"]
availability_zones = ["eu-west-3a"]
security_group_id = "sg-0abcd1234ef567890"
private_subnet_ids = ["subnet-070fc170870d42e4c", "subnet-0e97a1389851135fa"]
allowed_cidrs = ["10.0.0.0/16"]
acm_certificate_arn = "arn:aws:acm:eu-west-3:156041410917:certificate/8915de65-6b23-4b52-8b3d-3d850548fa02"

db_name     = "redminedb"
db_username = "admin_redmine"
db_password = "Shikan244"