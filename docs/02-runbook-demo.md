
---

## `/docs/02-runbook-demo.md`
```markdown
# Runbook – Demo Walkthrough

## Step 1 – PR & Initial Plan
- Create a Pull Request modifying `instance_type` or adding a new tag.
- Terraform Cloud automatically runs a Plan.
- Show the Plan in the UI.

## Step 2 – Policy Failure
- Intentionally remove the `CostCenter` tag.
- Policy Set (`require-tags.sentinel`) blocks the change.
- Highlight that governance happens automatically.

## Step 3 – Fix and Apply
- Add the missing tag in code.
- Push commit → new Plan passes.
- Approve and Apply in Terraform Cloud.
- Show EC2 instance running (Apache "Hello ACME").

## Step 4 – Drift Detection
- Manually change EC2 configuration in AWS Console (e.g., remove a tag).
- Run new Plan in Terraform Cloud.
- Drift detected and flagged.
- Correct in code → Apply reconciles infrastructure.

## Step 5 – Wrap Up
- Emphasize benefits: collaboration, governance, reliability.

