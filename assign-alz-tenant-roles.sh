
#!/usr/bin/env bash
set -euo pipefail

# ======== CONFIG =========
# Assignee can be an objectId (recommended) or appId (service principal). Use objectId if you have it.
ASSIGNEE_OBJECT_ID="c5a5468c-56cc-4b72-9fe1-472f9f024fad"  # <-- replace with your user/SP objectId
ASSIGN_OWNER="false"  # set to "true" if you need to create custom role definitions
LOCATION="eastus"     # used for a quick token/portal consistency; not required for assignments
# ========================

# Helper: get current account
echo ">> Checking current Azure account..."
az account show --output table || { echo "Not logged in. Run: az login"; exit 1; }

# Helper: test if a role assignment exists at tenant scope
has_assignment() {
  local role_name="$1"
  az role assignment list \
    --assignee "$ASSIGNEE_OBJECT_ID" \
    --scope "/" \
    --role "$role_name" \
    --query "length(@)" -o tsv
}

assign_role() {
  local role_name="$1"
  echo ">> Ensuring role '$role_name' at tenant scope '/' for assignee $ASSIGNEE_OBJECT_ID"
  if [[ "$(has_assignment "$role_name")" -gt 0 ]]; then
    echo "   - Already assigned."
  else
    az role assignment create \
      --assignee "$ASSIGNEE_OBJECT_ID" \
      --role "$role_name" \
      --scope "/"
    echo "   - Assigned."
  fi
}

echo ">> Registering core resource providers (safe to rerun)..."
# Registration at tenant is mostly implicit, but these help in fresh tenants
az provider register --namespace Microsoft.Authorization || true
az provider register --namespace Microsoft.Management || true
az provider register --namespace Microsoft.Resources || true

echo ">> Assigning required roles for ALZ bootstrap at tenant scope..."
assign_role "Contributor"
assign_role "Resource Policy Contributor"
assign_role "User Access Administrator"

if [[ "$ASSIGN_OWNER" == "true" ]]; then
  assign_role "Owner"
else
  echo ">> Skipping 'Owner'. Set ASSIGN_OWNER=true if you need to create custom role definitions."
fi

echo ">> Summary of effective roles at tenant scope for assignee:"
az role assignment list \
  --assignee "$ASSIGNEE_OBJECT_ID" \
  --scope "/" \
  --output table

cat <<'NOTE'
-----------------------------------------------------------------------------
Notes:
- Contributor               -> needed for deployments (Microsoft.Resources/deployments/*)
- Resource Policy Contributor -> needed to create/modify policy definitions & initiatives
- User Access Administrator   -> needed to create role assignments (Microsoft.Authorization/roleAssignments/write)
- Owner (optional)            -> needed to create custom role definitions (Microsoft.Authorization/roleDefinitions/*)

If you just updated roles:
- If you're a user: 'az logout && az login'
- If using OIDC (e.g., GitHub Actions): rerun the job to mint a new token.

If you use appId instead of objectId:
- Replace ASSIGNEE_OBJECT_ID with the app's objectId (preferred), or pass --assignee-object-id/--assignee to appId accordingly.
-----------------------------------------------------------------------------
NOTE
