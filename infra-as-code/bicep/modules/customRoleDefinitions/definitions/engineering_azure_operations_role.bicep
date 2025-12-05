targetScope = 'managementGroup'

metadata name = 'engineering_azure_operations_role'
metadata description = 'Engineering Operations Azure Role with permissions to manage and operate Azure resources.'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] Engineering Operations Role'
  description: 'Engineering Operations Azure Role with permissions to manage and operate Azure resources.'
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
          'Microsoft.Compute/virtualMachines/start/action'
          'Microsoft.Compute/virtualMachines/restart/action'
          'Microsoft.Compute/virtualMachines/deallocate/action'
          'Microsoft.Compute/disks/beginGetAccess/action'
          'Microsoft.Compute/snapshots/write'
          'Microsoft.Compute/snapshots/delete'
          'Microsoft.ResourceHealth/availabilityStatuses/read'
          'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.Insights/alertRules/*'
          'Microsoft.Support/*'
          'Microsoft.Resources/deployments/validate/action'
          'Microsoft.Resources/deployments/write'
          'Microsoft.StreamAnalytics/*'
          '*/read'
        ]
        notActions: [
          'Microsoft.Compute/virtualMachines/*/delete'
          'Microsoft.Authorization/*/read'
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
