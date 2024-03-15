# AWS Terraform Devops

## Introduction

This repository contains the terraform code to create a simple AWS infrastructure. The infrastructure consists of a VPC, a public subnet, a private subnet, an internet gateway, a route table, a security group, an EC2 instance, and an S3 bucket.

### Backend.tf

The `backend.tf` file is used to store the configuration for the backend. The backend is used to store the state file

### Variables.tf

The `variables.tf` file is used to store the input variables. The input variables are used to parameterize the terraform code.


## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [License](#license)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)
- [AWS Account](https://aws.amazon.com/)
- [AWS Access Key and Secret Access Key](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys)
- [AWS IAM User](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users.html)

## Getting Started

1. Clone the repository

```bash
git clone
```

2. Change into the directory

```bash
cd aws-terraform
```

3. Initialize the working directory

```bash
terraform init
```

4. Create an execution plan

```bash
terraform plan
```

5. Apply the changes

```bash
terraform apply
```

6. Destroy the infrastructure

```bash
terraform destroy
```

## License

This project is open source and available under the [MIT License](LICENSE).
