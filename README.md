## Terraform EC2 Deployment

Simple example of using **Terraform** to provision an **AWS EC2 instance** on AWS as part of an **Infrastructure as Code (IaC)** workflow.

---

### 1. Quick Start

- **Clone this repo**
  ```bash
  git clone <your-repo-url>
  cd <your-project-folder>
  ```

- **Configure AWS credentials**
  ```bash
  aws configure
  ```

- **Initialize Terraform**
  ```bash
  terraform init
  ```

- **See what will be created**
  ```bash
  terraform plan
  ```

- **Create the EC2 instance**
  ```bash
  terraform apply
  ```

- **Tear everything down**
  ```bash
  terraform destroy
  ```

---

### 2. What This Project Does

- **Configures the AWS provider** and region.
- **Provisions a single EC2 instance** with Terraform.
- **Adds useful tags** so you can easily identify the instance in the AWS console.

This is intentionally minimal so you can focus on understanding the basic Terraform workflow.

---

### 3. Project Structure

```text
.
├── main.tf              # Core Terraform configuration
├── .terraform/          # Provider plugins (auto‑generated, ignore)
├── terraform.tfstate    # Current state (do not edit)
└── terraform.tfstate.backup
```

- **`main.tf`**: Where you define provider, resources (EC2), and any variables.
- **State files**: Managed by Terraform; treat them as internal implementation details.

---

### 4. Prerequisites

- **Terraform** installed (`terraform -version`).
- **AWS CLI** installed and on your `PATH`.
- **AWS credentials** configured with permissions to create EC2 instances.

If you haven’t configured AWS before:

```bash
aws configure
```

You’ll be prompted for:
- **Access key ID**
- **Secret access key**
- **Default region name**
- **Default output format**

---

### 5. Typical Terraform Workflow

- **Initialize providers**
  ```bash
  terraform init
  ```

- **Validate configuration**
  ```bash
  terraform validate
  ```

- **Preview changes**
  ```bash
  terraform plan
  ```

- **Apply changes**
  ```bash
  terraform apply
  ```

- **Destroy created resources**
  ```bash
  terraform destroy
  ```

---

### 6. Learning Focus

This mini‑project is part of a **DevOps learning journey**, focusing on:

- **Infrastructure as Code (IaC)** concepts.
- **Terraform fundamentals** (providers, resources, state).
- **Basic AWS provisioning** (EC2 instance lifecycle).

Use this as a starting point to:
- Add security groups and key pairs.
- Parameterize AMI, instance type, and region with variables.
- Separate configuration into multiple `.tf` files as it grows.

---

### 7. Author

**Prashant**


