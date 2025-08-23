📖 Overview

This repository demonstrates how ACME Financial Services can migrate from manual cloud changes and ad-hoc scripts to a secure, auditable, and automated Infrastructure as Code (IaC) workflow using Terraform Cloud (TFC).

The focus is on:

Eliminating configuration drift 🚫

Enabling collaboration via PR + policy checks 🤝

Enforcing governance and security from day one 🔒

Reducing outages and increasing delivery speed ⚡

🏗️ Architecture
flowchart LR
    A[Developer PR in GitHub] --> B[Terraform Cloud]
    B -->|Plan & Policy Check| C[Approval]
    C -->|Apply| D[AWS Infrastructure]
    D --> E[Auditable State + Logs]


Components:

GitHub → Version control, Pull Requests

Terraform Cloud → Remote state, Plans, Policies, RBAC, Audit

AWS (Demo) → VPC + Subnet + Security Group + EC2 with Apache “Hello ACME”

📂 Repository Structure
/docs/              -> Vision, architecture diagrams, runbooks
/envs/              -> tfvars per environment (dev, prod)
/modules/           -> Reusable IaC modules (network, compute)
/live/              -> Root configuration consuming modules
/policies/          -> Sentinel policies (governance)

⚙️ Demo Workflow

Create a PR with changes to Terraform code.

Terraform Cloud runs Plan automatically.

Policy Check validates mandatory tags (Owner, CostCenter).

Approval & Apply → infrastructure provisioned in AWS.

Audit & Logs ensure traceability.

Drift Detection → any manual change in the console is flagged on the next Plan.

🔑 Key Features

✅ Versioned Infrastructure (GitOps style)

✅ Secure variables (no secrets in repo, encrypted in TFC)

✅ Policy as Code (Sentinel requiring mandatory tags)

✅ Reusable modules for network and compute

✅ Multi-workspace setup for dev/prod

🧩 Modules

Network: VPC, Subnet, Internet Gateway, Route Table

Compute: EC2 instance with Apache, SG inbound on :80, user_data startup script

🛡️ Governance Example

Sentinel Policy – require tags

import "tfplan/v2" as plan

main = rule {
  all resources as r {
    r.applied.tags contains "Owner" and r.applied.tags contains "CostCenter"
  }
}


Blocks any resource created without Owner and CostCenter.

🚦 Roadmap (30/60/90 days)

30d → Dev environment live, team trained on IaC basics

60d → Add DB/containers modules, integrate with CI/CD pipeline

90d → Production rollout, advanced policies, compliance metrics

🧑‍🤝‍🧑 Personas addressed

CTO: Scalability, ROI, faster delivery

DevOps Lead: Standardization with modules, smoother change flow

Security Engineer: Secrets management, audit trails, policy enforcement

Platform Engineer: Easy migration path, state management, multi-team collaboration

📸 Demo Preview


Gif: PR → Plan → Policy Fail → Fix → Apply → Drift Detection

📜 License

This repository is for technical demonstration purposes only.
Not intended for production use.
