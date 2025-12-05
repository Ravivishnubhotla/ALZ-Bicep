targetScope = 'managementGroup'

metadata name = 'infra_azure_eng_role'
metadata description = 'Infrastructure Support Engineering team.'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] Infrastructure Support Engineering team'
  description: 'Infrastructure Support Engineering team'
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
          '*'
        ]
        notActions: [
          'Microsoft.Authorization/elevateAccess/Action'
          'Microsoft.Blueprint/blueprintAssignments/write'
          'Microsoft.Blueprint/blueprintAssignments/delete'
          'Microsoft.Authorization/*/Write'
          'Microsoft.Authorization/*/Delete'
        ]
        dataActions: []
        notDataActions: []
      }
    ]
    assignableScopes: [
      tenantResourceId('Microsoft.Management/managementGroups', parAssignableScopeManagementGroupId)
    ]
  }
}

output outRoleDefinitionId string = resRoleDefinition.id
