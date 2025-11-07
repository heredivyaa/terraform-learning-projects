README Section — Day 2: Terraform Modules, Variables, and Outputs
---

## Day 2: Working with Modules, Variables, and Outputs in Terraform

**Goal:**  
To understand how to use **Terraform modules**, **variables**, and **outputs** to create modular, reusable, and configurable infrastructure code.

---

### Key Concepts Learned

#### 1. Terraform Modules
- A **module** is a container for multiple Terraform resources that are used together.  
- Modules help make your Terraform configurations **reusable, organized, and scalable**.
- You can define a module inside a folder (like `modules/ec2_instance`) and call it from your main configuration.

**Example (in main.tf):**
```hcl
module "ec2_instance" {
  source = "./modules/ec2_instance"
  instance_type = var.instance_type
}

2. variables.tf

The variables.tf file is used to declare input variables that make your code configurable.

Instead of hardcoding values (like instance type, region, etc.), variables are defined here.

Example:

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

3. terraform.tfvars

The terraform.tfvars file is used to assign values to variables declared in variables.tf.

It helps separate configuration values from code, which is good practice.

Example (terraform.tfvars):

instance_type = "t3.micro"

4. outputs.tf

The outputs.tf file defines the values that Terraform should display after an apply operation.

It helps you see key details (like instance ID, public IP, etc.) after resource creation.

Example:

output "public_ip_address" {
  value = aws_instance.ec2_instance.public_ip
  description = "The public IP of the created EC2 instance"
}


To display the module’s output in the root configuration:

output "ec2_public_ip" {
  value = module.ec2_instance.public_ip_address
}

Folder Structure
day2/
│
├── main.tf                        # Root configuration calling the EC2 module
├── outputs.tf                     # Displays output from the module
├── variables.tf                   # Declares variables used in main.tf
│
└── modules/
    └── ec2_instance/
        ├── main.tf                # Defines EC2 instance resource
        ├── variables.tf           # Input variables for module
        └── outputs.tf             # Module-specific outputs

Commands Used
terraform init        # Initialize Terraform and download required providers/modules
terraform plan        # Review planned actions before applying
terraform apply       # Create the EC2 instance using module configuration
terraform output      # Display output values defined in outputs.tf
terraform destroy     # Destroy created resources

Output

After running terraform apply, the EC2 instance was created successfully and the public IP was displayed as defined in outputs.tf.

Example:

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

ec2_public_ip = "13.233.75.125"

Summary of Learnings

Understood how to create and use modules for better organization and reusability.

Learned how to parameterize Terraform code using variables.tf and terraform.tfvars.

Displayed key results using outputs.tf.

Learned the importance of modular infrastructure as code for scalable projects.


---
