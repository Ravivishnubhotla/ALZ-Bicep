targetScope = 'managementGroup'

metadata name = 'infra_azure_ea_role'
metadata description = 'Infrastructure Support Azure Enterprise EA Role with elevated permissions excluding critical actions.'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] InfraStructure Azure EA Role'
  description: 'Infrastructure Support Azure Enterprise EA Role with elevated permissions excluding critical actions.'
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
