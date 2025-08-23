# Architecture Diagram

```mermaid
flowchart LR
    A[Developer creates PR in GitHub] --> B[Terraform Cloud]
    B -->|Plan & Policy Check| C[Approval]
    C -->|Apply| D[AWS Infrastructure]
    D --> E[Audit & State stored in TFC]
