# Security & Compliance with Terraform Cloud

## Secrets Management
- AWS credentials stored as **sensitive variables** in TFC.
- Never committed to GitHub.
- Encrypted at rest and in transit.

## RBAC & Authentication
- Role-based access control per workspace.
- SSO integration with corporate identity provider.
- Segregation of duties (dev vs. approver vs. operator).

## Policy as Code
- Sentinel policy requires mandatory tags:
  - `Owner`
  - `CostCenter`
- Prevents shadow resources and improves cost tracking.

## Audit & Logging
- Every run logged with who, when, what was changed.
- Policy check results included in audit log.
- Compliance reports exportable for audits.

## Resilience
- State stored remotely in TFC (encrypted, versioned).
- CLI workflow available as fallback in case of service disruption.

