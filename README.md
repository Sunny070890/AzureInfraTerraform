# Azure platform infrastructure

This repository provisions Azure resources with reusable Terraform modules and
separate `dev` and `qa` root configurations. Each environment includes a
resource group, virtual network, AKS subnet, private AKS cluster, Azure
Container Registry (ACR), and storage account.

## Prerequisites

- Terraform 1.5 or later (below 2.0)
- Azure CLI and an authenticated Azure identity, or workload identity/service
  principal credentials supported by the AzureRM provider
- Azure permissions to create the resources and role assignments in the target
  subscription
- Network access from the AKS administration workstation or runner to the AKS
  private endpoint (for example through VNet peering, VPN, or a self-hosted
  runner in the VNet)

## Configure and deploy

1. Set the Azure subscription ID and tenant ID in the selected environment's
   `provider.tf`. The tenant ID is configured once in `locals` and used by both
   the Azure provider and AKS. Do not commit credentials.

2. Review the environment's `terraform.tfvars`. Update globally unique storage
   account and registry names, locations, CIDRs, and VM sizes for the target
   subscription. AKS node pools do not specify availability zones because the
   current subscription has no supported zones in East US. The dev and QA
   VNets use separate address spaces; pod and service CIDRs must not overlap
   either VNet or each other.
3. From the chosen environment directory, initialize, review the plan, and
   apply:

   ```powershell
   Set-Location .\environments\dev
   terraform init
   terraform plan
   terraform apply
   ```

   Use `.\environments\qa` for QA. Keep each environment's state isolated.
   Configure an approved remote Terraform backend with encryption, access
   controls, and state locking before using this configuration collaboratively
   or for production workloads. The current configuration does not create or
   configure its own backend.

## Security and operations

- AKS API access is private, local Kubernetes accounts and the AKS Run Command
  are disabled, and Azure RBAC is enabled through Microsoft Entra ID.
- AKS uses a system-assigned managed identity; its kubelet identity receives
  only the `AcrPull` role on the matching registry. ACR admin credentials are
  disabled.
- The ACR public endpoint is enabled in the sample environment settings to
  allow image pulls without requiring a private endpoint and private DNS
  module. Set `public_network_access_enabled = false` only after private
  endpoint connectivity and DNS have been configured out-of-band.
- Storage enforces HTTPS and TLS 1.2 or later.
- Kubernetes version is set to `null` in the sample values so Azure selects a
  supported version. Pin a tested version for controlled rollouts.
- Sample AKS node pools use one `Standard_D2_v4` VM because it is listed as
  allowed for the current subscription, and use the AKS Free control-plane
  tier. The Free tier applies to the control plane only; node VM compute, disks,
  networking, and other Azure resources can still incur charges. Check current
  Azure pricing before applying.
- Review cost, regional availability, and organizational policy constraints
  before applying. In particular, node pool VM sizes and selected availability
  zones must be supported in the chosen region.

## Modules

- `modules/azurerm_resource_group`
- `modules/azurerm_virtual_network`
- `modules/azurerm_subnet`
- `modules/azurerm_kubernetes_cluster`
- `modules/azurerm_container_registry`
- `modules/azurerm_storage_account`
