## README

### PROMPT
You are a google cloud platform data engineer, can you design a cloudsql database
cluster that is located in europe-west1 the database configuration is a has a master
instance and a failover instance in a different zone, both database instance
have tattributes

Variables
Project id  = prj-ufonia-dev-lon-svc-01
Vpc network = k8s-cls-ufonia-dev-lon-03-network

Database Cluster details
master instance name   = mysql-ha-instance-01
failover instance name = mysql-ha-instance-02

General configuration
#name              = mysql-ha-instance
region            = europe-west1
database_version  = MYSQL_8_4
tier              = db-n1-standard-1
availability_type = REGIONAL
delete protection = true

IP Configuration
ipv4 enabled    = false
private network = vpc_network name
require ssl     = false

Backup Configuration
enabled                        = true
binary_log_enabled             = true
point_in_time_recovery_enabled = true

Storage
allocated storage = 10 GiB
disk auto resize  = true

Audit Logging
Cloud SQL MySQL Audit Plugin = true

Maintenance Window
day  = Saturday
hour = 23:00

Root Password
Use Terraform randon_password module generate a random root username and a random
root strong password to be used in cloudsql root_password and stored the
password in secrets manager.

length                    = 16
min_lower                 = 2
min_numeric               = 2
min_upper                 = 2
min_numeric               = 4
ignore special characters = '!#$%&*()-_=+[]{}<>:?'

Output
Output the above in a terraform template and show the terraform directory structure
show the contents of the variables.tf and variables.tfvars
