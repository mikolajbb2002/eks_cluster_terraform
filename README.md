# eks_cluster_terraform

What was built and how to run it.

## 1) Create state bucket and lock table (local, once)
```
cd Dev/tfstate-bucket
terraform init
terraform apply
```
Creates S3 `tfstate-for-ecs-app` and DynamoDB `terraform-lock-table`.

## 2) Bootstrap OIDC roles for the pipeline (local, once)
```
cd Dev/bootstrap
terraform init
terraform apply
```
Creates the GitHub OIDC provider and plan/apply roles (StringLike on `sub`) with access to S3/Dynamo, etc.

## 3) Main stack (pipeline)
- `.github/workflows/terraform.yml` runs with plan role autmatically when push on main is detected.
- Run `.github/workflows/terraform.yml` manually (`workflow_dispatch` with apply_role ).
- `plan` job uses `PLAN_ROLE_ARN`, saves `tfplan` as an artifact.
- `apply` job (when `action: apply`) uses `APPLY_ROLE_ARN`, runs `terraform apply tfplan`, installs `kubectl`, runs `aws eks update-kubeconfig`, then `kubectl apply -f Dev/simple-nginx.yaml`.
- AWS profiles in CI are forced empty (`TF_VAR_aws_profile=""`); OIDC assume-role is used.

## 4) Manual cluster check (optional)
```
aws eks update-kubeconfig --region eu-central-1 --name eks-cluster --role-arn <apply-role-arn>
kubectl get nodes
kubectl get pods,svc -A
```

- Or you can just hit on Load Balancer's DNS in AWS console. 
