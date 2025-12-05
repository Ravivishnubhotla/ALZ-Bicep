targetScope = 'managementGroup'

metadata name = 'infra_azure_governance_role'
metadata description = 'Infrastructure Support Azure Goverance'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] InfraStructure Goverance Role'
  description: 'Infrastructure Support Azure Goverance'
}

resource resRoleDefinition 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(varRole.name, parAssignableScopeManagementGroupId)
  properties: {
    roleName: varRole.name
    description: varRole.description
    type: 'CustomRole'
   permissions: [
      {
        actions: [
          'Microsoft.Billing/*/read'
          'Microsoft.Commerce/*/read'
          'Microsoft.Consumption/*/read'
          'Microsoft.CostManagement/*/read'
          'Microsoft.Resources/subscriptions/read'
          'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.Advisor/configurations/read'
          'Microsoft.Advisor/recommendations/read'
          'Microsoft.Management/managementGroups/subscriptions/read'
          'Microsoft.Resources/tags/*'
          'Microsoft.Support/*'
          'Microsoft.Authorization/*/read'
          'Microsoft.Consumption/*/read'
          'Microsoft.Management/managementGroups/read'
        ]
        notActions: [
          'Microsoft.Compute/disks/beginGetAccess/action'
        ]
        dataActions: [
        ]
        notDataActions: [
        ]
      }
    ]
    assignableScopes: [
      tenantResourceId('Microsoft.Management/managementGroups', parAssignableScopeManagementGroupId)
    ]
  }
}

output outRoleDefinitionId string = resRoleDefinition.id
