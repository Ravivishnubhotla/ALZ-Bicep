targetScope = 'managementGroup'

metadata name = 'infra_azure_networking_role'
metadata description = 'Infrastructure Support Azure Networking Role with networking-related permissions.'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] Infrastructure Support Azure Networking Role'
  description: 'Infrastructure Support Azure Networking Role with networking-related permissions.'
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
          '*/read'
          'Microsoft.Authorization/*/read'
          'Microsoft.Cdn/edgenodes/read'
          'Microsoft.Cdn/operationresults/*'
          'Microsoft.Cdn/profiles/endpoints/*'
          'Microsoft.Insights/alertRules/*'
          'Microsoft.Resources/deployments/*'
          'Microsoft.Resources/subscriptions/providers/read'
          'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.Support/*'
          'Microsoft.Cdn/profiles/*'
          'Microsoft.ClassicNetwork/*'
          'Microsoft.ResourceHealth/availabilityStatuses/read'
          'Microsoft.Network/virtualNetworks/read'
          'Microsoft.Network/virtualNetworks/join/action'
          'Microsoft.Network/privateDnsZones/*'
          'Microsoft.Network/privateDnsOperationResults/*'
          'Microsoft.Network/privateDnsOperationStatuses/*'
          'Microsoft.Network/*'
          'Microsoft.Network/trafficManagerProfiles/*'
          'Microsoft.ResourceHealth/availabilityStatuses/read'
          'Microsoft.Resources/subscriptions/resourceGroups/moveResources/action'
          'Microsoft.Resources/subscriptions/resourceGroups/validateMoveResources/action'
          'Microsoft.Resources/subscriptions/resourceGroups/write'
          'Microsoft.Compute/virtualMachines/write'
          'Microsoft.Compute/virtualMachines/start/action'
          'Microsoft.Compute/virtualMachines/deallocate/action'
          'Microsoft.Network/networkInterfaces/write'
          'Microsoft.Network/virtualNetworks/subnets/join/action'
          'Microsoft.Network/virtualNetworks/read'
          'Microsoft.Storage/storageAccounts/write'
          'Microsoft.Storage/storageAccounts/listKeys/action'
          'Microsoft.Compute/disks/write'
        ]
        notActions: [
          'Microsoft.Management/managementGroups/*'
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
