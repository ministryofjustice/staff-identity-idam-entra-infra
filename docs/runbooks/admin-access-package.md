# Managing Administrator Access Packages

## Overview

You can manage Administrator Access Pacakages from the file [../../terraform/data.admin-access-packages.tf](../../terraform/data.admin-access-packages.tf).

To create a new one you can add a new unique key under `admin_access_packages` and supply the appropriate properties and values to configure your application.

Once complete you can raise a Pull Request which the IDAM team will review and process further.

## Example Usage

```
MoJO_Admin_EUCS_Security = {
    team_name       = "Security"
    department_name = "EUCS"
    role_name       = "Engineers"

    roles = ["Security Reader", "Reports Reader"]
}
```

## Argument Reference

| Property Name | Description | Example |
| --- | --- | --- |
| `department_name` | Department name such as EUCS, OPG, LAA, etc. | `department_name = "EUCS"` |
| `team_name` | Team name acronym such as IDAM, MWP, AP, etc. | `team_name = "Security"` |
| `role_name` | The Role of the teams Access Package such as Security, Engineers, etc. | `role_name = "Engineers"` |
| `roles` | List of Built-in Entra Roles to give Eligible permissions such as Security Reader, Reports Reader, User Administrator, etc. | `roles = ["Security Reader", "Reports Reader"]` |
