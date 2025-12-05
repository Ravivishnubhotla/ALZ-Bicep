targetScope = 'managementGroup'

metadata name = 'infra_azure_reservations_role'
metadata description = 'Infrastructure Support Azure Reservations Role with permissions to manage Azure Reservations.'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] Infrstructure Azure Reservations Role'
  description: 'Infrastructure Support Azure Reservations Role with permissions to manage Azure Reservations.'
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
          'Microsoft.Capacity/reservationorders/write'
          'Microsoft.Capacity/reservationorders/read'
          'Microsoft.Capacity/reservationorders/delete'
          'Microsoft.Capacity/reservationorders/reservations/action'
          'Microsoft.Capacity/reservationorders/return/action'
          'Microsoft.Capacity/reservationorders/swap/action'
          'Microsoft.Capacity/reservationorders/split/action'
          'Microsoft.Capacity/reservationorders/merge/action'
          'Microsoft.Capacity/reservationorders/calculaterefund/action'
          'Microsoft.Capacity/reservationorders/changeBilling/action'
          'Microsoft.Capacity/reservationorders/availablescopes/action'
          'Microsoft.Capacity/reservationorders/changedirectory/action'
          'Microsoft.Capacity/reservationorders/reservations/read'
          'Microsoft.Capacity/reservationorders/reservations/write'
          'Microsoft.Capacity/reservationorders/reservations/delete'
          'Microsoft.Capacity/reservationorders/reservations/availablescopes/action'
        ]
        notActions: [
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
