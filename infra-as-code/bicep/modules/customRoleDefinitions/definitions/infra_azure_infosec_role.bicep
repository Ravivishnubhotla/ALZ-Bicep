targetScope = 'managementGroup'

metadata name = 'infra_azure_infosec_role'
metadata description = 'Infrastructure Infosec Role with information security related permissions.'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] Infrastructure InfoSec Role'
  description: 'Infrastructure InfoSec Role with information security related permissions.'
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
          'Microsoft.Support/*'
          'Microsoft.Authorization/policyExemptions/write'
          'Microsoft.Authorization/policyExemptions/delete'
          'Microsoft.Authorization/policyAssignments/exempt/action'
          'Microsoft.Security/assessments/write'
          'Microsoft.Security/locations/alerts/read'
          'Microsoft.Security/locations/alerts/dismiss/action'
          'Microsoft.Security/locations/alerts/activate/action'
          'Microsoft.Security/locations/alerts/resolve/action'
          'Microsoft.Security/locations/alerts/simulate/action'
          'Microsoft.Storage/storageAccounts/blobServices/read'
          'Microsoft.Storage/storageAccounts/blobServices/containers/read'
          'Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action'
        ]
        notActions: [
          'Microsoft.Compute/disks/beginGetAccess/action'
        ]
        dataActions: [
          'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read'
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
