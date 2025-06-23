
## 🚀 Pull Request Summary

**Title:**  
_A clear and concise title for the PR._

**Description:**  
<!--
Provide a concise summary of what this PR changes related to Azure IAM.
Example: "Add new Azure RBAC role assignment for monitoring service principal" or
"Update automation script to rotate Azure Key Vault access policies"
-->

**Fixes:** [Jira-xxxx](https://dsdmoj.atlassian.net/browse/IDAM-xxxx)

## 🔐 Identity & Access Management (Azure)

### The below boxes are general guidance and points to consider. Only the relevant box's require ticking, relevant to the changes you are implementing.  

- [ ] Have all Azure resources been assigned **least privilege** access?
- [ ] Are **Managed Identities** used instead of hardcoded credentials or secrets?
- [ ] Are **Azure RBAC roles** scoped appropriately (e.g., resource group vs. subscription)?
- [ ] Have **role assignments** been reviewed for over-permissioning?
- [ ] Are **Azure AD groups** used for access control where applicable?
- [ ] Are **Key Vaults** used for storing secrets, certificates, or keys?
- [ ] Have **access policies** or **RBAC roles** for Key Vaults been reviewed?

## 🧪 Testing & Validation

- [ ] Have changes been tested in a **non-production** environment?
- [ ] Are there **unit/integration tests** for IAM logic or automation scripts?

## 📄 Documentation

- [ ] Is there documentation for new IAM roles, policies, or automation logic ect?
- [ ] Have runbooks or operational guides been updated?

## 📎 Related Issues / Tickets

_Reference any related issues, JIRA tickets, or documentation._

## ✅ Checklist

- [ ] I have reviewed the code and confirm it meets the project’s IAM, security and automation standards.
- [ ] I have verified that no sensitive data is exposed in logs or code.
- [ ] I have updated relevant documentation and diagrams.
- [ ] I have reviewed my own code and the plan

---

🛡️ **Security is everyone's responsibility. Please ensure all IAM changes are reviewed carefully.**


## ✅ Reviewer Checklist
- [ ] I have reviewed the code and confirm it meets the project’s IAM, security and automation standards.
- [ ] I have verified that no sensitive data is exposed in logs or code.
