# GITHUB LINK TO THIS PROJECT
https://github.com/siddharthsinh-dev/project-cloud-programming-terraform

## Static Website Hosting with Amazon S3 and CloudFront using Terraform

This project demonstrates how to host a static website using Amazon S3 and CloudFront with Terraform.

### Steps to Deploy

1. **Clone the repository**:
```bash
git clone https://github.com/siddharthsinh-dev/project-cloud-programming-terraform.git
```

2. **Navigate to the project directory**
```bash
cd project
```

3. **Initialize Terraform**
```bash
terraform init
```

4. **Preview the Execution Plan**
```bash
terraform plan
```

5. **Apply the Terraform Configuration**
```bash
terraform apply
```

6. Type **'yes'** when prompted to confirm the deployment.

7. Once, the deployment is complete, you can access the static website through **CloudFront distribution URL** in your AWS Console. 

8. After Viewing the Website, run:
```bash
terraform destroy
```
to avoid incurring any additional costs of AWS resources usage.

