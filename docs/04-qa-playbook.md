# Q&A Playbook

## CTO
**Q:** How will this migration impact incident response speed?  
**A:** With versioned infrastructure, emergency changes can still be applied via Terraform CLI if TFC is unavailable. PR workflow ensures normal changes are faster and safer.

**Q:** What’s the learning curve for the team?  
**A:** Terraform syntax is straightforward; modules abstract complexity. Training sessions in the first 30 days reduce ramp-up time.

---

## DevOps Lead
**Q:** How do we transition from manual to IaC without breaking production?  
**A:** Start with new resources in Terraform, gradually import existing ones with `terraform import`. Migration is incremental.

**Q:** How does this integrate with pipelines?  
**A:** TFC supports VCS-driven runs and integrates with GitHub Actions, Jenkins, or GitLab CI out-of-the-box.

---

## Security Engineer
**Q:** How are secrets protected?  
**A:** Variables marked as sensitive in TFC, encrypted at rest. Integration with Vault possible for dynamic secrets.

**Q:** What if TFC is down?  
**A:** Terraform CLI workflows remain available; state can be exported from TFC. Business continuity plan ensures fallback.

---

## Platform Engineer
**Q:** Why not use CloudFormation/ARM?  
**A:** Terraform is cloud-agnostic, avoids lock-in, and provides reusable modules across clouds. Governance with Sentinel is not available in native tools.

**Q:** How do we handle conflicts?  
**A:** Remote state locking in TFC prevents simultaneous conflicting changes. Workspaces isolate environments safely.

