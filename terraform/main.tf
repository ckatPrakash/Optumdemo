name: Terraform Destroy

on:
  workflow_dispatch:  # Trigger manually from GitHub Actions UI

jobs:
  terraform-destroy:
    name: Destroy Infrastructure
    runs-on: ubuntu-latest

    env:
      AWS_REGION: us-west-2

    steps:
      # Step 1: Checkout repository
      - name: Checkout repository
        uses: actions/checkout@v4

      # Step 2: Set up Terraform
      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.7.5  # Use your version

      # Step 3: Configure AWS credentials
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: ${{ env.AWS_REGION }}

      # Step 4: Initialize Terraform
      - name: Terraform Init
        run: terraform init

      # Step 5: Validate Terraform Files
      - name: Terraform Validate
        run: terraform validate

      # Step 6: Destroy Infrastructure
      - name: Terraform Destroy
        run: terraform destroy -auto-approve

      # Step 7: Clean up .terraform cache (optional but recommended)
      - name: Cleanup Terraform Cache
        run: rm -rf .terraform
