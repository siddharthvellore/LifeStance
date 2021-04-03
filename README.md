# LifeStance Assignment

<u>DevOps Engineer Assessment</u>

1. Terraform
   Write a reusable terraform modular structure code which deploys following components in AWS Cloud
1. Creates a VPC with Public,Private Subnets, NAT and IGW.
2. Creates more than one, Linux/Windows ec2 instances in the above deployed VPC in a private subnet.
3. Create a Name Tag to the instances based on count of instances. For example if Count of instances is 2, the value of Name tag should look like "Instance01", "Instance02".
   Limit your self to use the free tier of AWS.

-----------

<u>**Prerequisites:**</u>
1. Terraform Required
2. AWS Account **(Free Tier Recommended)**
3. AWS Profile Setup on the machine


<u>**Best Practices**</u>
1. Always call <u>reusable or common</u> modules from **Source Control** as follows
      ``` terraform
      module "serverless-lambda" { 
      source = github.com/siddharthvellore/example
      }
      ```
2. Store your Terraform State Lock using **AWS S3** & **DynamoDB**
   - <u>Reference for my project</u>: [main.tf](https://github.com/siddharthvellore/LifeStance/blob/main/create-state/main.tf)
3. Encrypt your Terraform State **(Using AWS KMS in this case)**
      ``` terraform
      terraform {
      backend "s3" {
      bucket         = "<Bucket Name>"
      key            = "<Project Keyname for S3 Storage>"
      region         = "<AWS Region>"
      profile        = "<AWS Profile"
      kms_key_id     = "<kms key ARN>"
      encrypt        = "true" #boolean value
      dynamodb_table = "<Table Name>"
        }
     }
      ```   
4. Never store your AWS credentials on the Terraform files, instead use
AWS profiles or assume IAM Roles.
5. Always use **Terraform variables** for reusable template across
   environments or stacks   

**<u>Terraform basic CLI Commands**</u>
 - **init** - Prepare your working directory for other commands
 - **validate** - Check whether the configuration is valid
 - **plan** - Show changes required by the current configuration
 - **apply** - Create or update infrastructure
 - **destroy** - Destroy previously-created infrastructure  
 - **version** - Show the current Terraform version
 - **help** - Show this help output

**<u>Terraform Variables & Outputs**</u>
1) You can declare input values are variables using a file [variables.tf](https://github.com/siddharthvellore/LifeStance/blob/main/version-2/project/variables.tf)
   - <u>You need to declare those **variables** in your **Terraform main file** using the format below</u>
    ```terraform
    region  = var.region
    profile = var.profile
    ```
2) You can declare output values using [output.tf](https://github.com/siddharthvellore/LifeStance/blob/main/version-2/project/output.tf)
   - <u>We use module outputs in this project</u>
    ```terraform
    output "vpc_id" {
    value = module.networking.vpc_id
    }
    ```

**<u>Solution Approach**</u>
- **Version 1** - <u>This is useful when a security group is used only for
  one module</u>
    - VPC Module 
    - EC2 Module with Security Group
- **Version 2** - <u>This is useful when a security group is used across
  multiple modules or resources</u>
    - VPC Module
    - Security Group
    - EC2 Module

**<u>Run the script**</u>
1) Navigate to project (https://github.com/siddharthvellore/LifeStance/blob/main/version-2/project)
2) Run the following **Terraform** commands
   ``` shell
    terraform init
    terraform validate
    terraform plan  #Answer yes on your validation
    terraform apply #Answer yes on your validation
    ``` 
3) You can use ```depends_on``` Meta-Argument as necessary when a resource or module relies on some other resource's behavior but doesn't access any of that resource's data in its arguments.
4) Terraform output values are displayed on successful creation of stack
5) The Ec2 name tags can be created based on count of instances as follows
   ``` terraform
    tags = {
    created_by = "terraform"
    Name = "${var.instance_name}-${count.index+1}"
    }
    ``` 
   - Instance name is declared using a **Variable**
6) Finally, use ```terraform destroy``` to delete your entire stack resource after a successful test.   

**<u>Screenshots for reference**</u>
1) S3 State file for the resource
2) DynamoDB state lock for the resource
3) Public Subnet, Internet Gateway and association
4) Private Subnet, NAT Gateway and association
5) Ec2 instances name tags based on count of instances

![alt text](https://luckyday-sid.s3-us-west-2.amazonaws.com/LifeStance/S3-State-File.png)
![alt text](https://luckyday-sid.s3-us-west-2.amazonaws.com/LifeStance/DynamoDB-Table-Lock.png)
![alt text](https://luckyday-sid.s3-us-west-2.amazonaws.com/LifeStance/Public-Subnet.png)
![alt text](https://luckyday-sid.s3-us-west-2.amazonaws.com/LifeStance/Private-Subnet.png)
![alt text](https://luckyday-sid.s3-us-west-2.amazonaws.com/LifeStance/Ec2-Instances.png)