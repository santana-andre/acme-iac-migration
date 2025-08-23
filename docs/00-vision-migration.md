# Vision: Migration to Infrastructure as Code with Terraform Cloud

## Current Situation
- Infrastructure managed via consoles, manual scripts, and ad-hoc processes.
- Recent 4h outage caused by conflicting manual changes.
- Security and compliance processes are reactive, not embedded.

## Desired State
- Infrastructure managed as code, version-controlled in GitHub.
- All changes peer-reviewed via Pull Requests.
- Terraform Cloud provides:
  - Remote state management
  - Policy enforcement
  - Collaboration workflows
  - Audit trail for every change

## Objectives
1. Reduce outages caused by configuration drift.
2. Standardize workflows across teams.
3. Integrate security and compliance controls into the provisioning process.
4. Scale quickly as the company grows.

## Value
- Faster delivery: infrastructure changes in hours, not days.
- Increased reliability: drift detected and remediated automatically.
- Better compliance: policies block insecure configurations.

