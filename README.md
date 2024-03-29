## GITHUB LINK TO THIS PROJECT
https://github.com/siddharthsinh-dev/project-cloud-programming-terraform

# Static Website Hosting with Amazon S3 and CloudFront using Terraform
This documentation provides step-by-step instructions on how to deploy a static website using Amazon S3 and CloudFront with Terraform.

**Prerequisites**

Before you begin, ensure you have the following:

* An AWS account with appropriate permissions to create S3 buckets, CloudFront distributions and IAM Roles.
* AWS CLI installed on your system and ensure that you have configured your AWS credentials either by exporting them as environment variables or by using AWS CLI (**'aws configure**') before running Terraform commands.
* Terraform installed on your system.

**Cloning the Repository**

1. **Open your terminal or command prompt:**
* **Mac/Linux:** Open the terminal application
* **Windows:** Open Command Prompt or PowerShell

2. **Navigate to your desired directory:**
```bash
cd 'directory name'
```
Replace the **'directory name'** with the name of the directory where you want to clone the GitHub repository.

3. **Clone the repository**:
```bash
git clone https://github.com/siddharthsinh-dev/project-cloud-programming-terraform.git
```

4. **Navigate to the project directory**
```bash
cd project-cloud-programming-terraform
```

## Deploying the Static Website

1. **Initialize Terraform**
```bash
terraform init
```

2. **Preview the Execution Plan**
```bash
terraform plan
```

3. **Apply the Terraform Configuration**
```bash
terraform apply
```

**Note** : Deploying time may take up to **5 minutes approximately**.

4. Type **'yes'** when prompted to confirm the deployment.

5. Once, the deployment is complete, you can access the static website by visiting your AWS Console:
* Navigate to the CloudFront Service
* Open the newly created CloudFront distribution
* Access the website through the **Distribution domain name** with .cloudfront.net extension listed in your AWS Console.


## Cleaning Up

1. After Viewing the Website, run:
```bash
terraform destroy
```
This will remove all resources created by Terraform and avoid incurring additional costs from AWS resource usage.

