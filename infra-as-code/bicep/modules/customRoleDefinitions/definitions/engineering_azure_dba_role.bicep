targetScope = 'managementGroup'

metadata name = 'engineering_azure_dba_role'
metadata description = 'Engineering Operations Azure Role with permissions to manage and operate Azure resources.'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] Engineering DBA Role'
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
          'Microsoft.Sql/servers/read'
          'Microsoft.Sql/servers/databases/read'
          'Microsoft.Sql/servers/firewallRules/*'
          'Microsoft.Sql/servers/databases/write'
          'Microsoft.Sql/servers/databases/delete'
          'Microsoft.DBforPostgreSQL/servers/read'
          'Microsoft.DBforPostgreSQL/servers/databases/read'
          'Microsoft.DBforPostgreSQL/servers/firewallRules/*'
          'Microsoft.DBforPostgreSQL/servers/databases/write'
          'Microsoft.DBforPostgreSQL/servers/databases/delete'
          'Microsoft.Insights/metrics/read'
          'Microsoft.Insights/diagnosticSettings/*'
          'Microsoft.Sql/managedInstances/databases/transparentDataEncryption/read'
          'Microsoft.Sql/managedInstances/databases/transparentDataEncryption/write'
          'Microsoft.Sql/servers/tdeCertificates/action'
          'Microsoft.Sql/servers/import/action'
          'Microsoft.Sql/servers/databases/move/action'
          'Microsoft.Sql/servers/databases/import/action'
          'Microsoft.Sql/servers/databases/restorePoints/action'
          'Microsoft.Sql/servers/databases/geoBackupPolicies/read'
          'Microsoft.Sql/servers/databases/geoBackupPolicies/write'
          'Microsoft.Sql/servers/databases/metrics/read'
          'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies/read'
          'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies/write'
          'Microsoft.Sql/servers/elasticPools/read'
          'Microsoft.Sql/servers/elasticPools/write'
          'Microsoft.Sql/servers/elasticPools/databases/read'
          'Microsoft.Sql/servers/failoverGroups/read'
          'Microsoft.Sql/servers/failoverGroups/write'
          'Microsoft.Sql/servers/dnsAliases/read'
          'Microsoft.Sql/servers/dnsAliases/write'
          'Microsoft.DBforPostgreSQL/flexibleServers/backups/read'
          'Microsoft.DBforPostgreSQL/flexibleServers/backups/write'
          'Microsoft.DBforPostgreSQL/flexibleServers/backups/delete'
          'Microsoft.DBforPostgreSQL/flexibleServers/startLtrBackup/action'
          'Microsoft.DBforPostgreSQL/flexibleServers/ltrPreBackup/action'
        ]
        notActions: [
          'Microsoft.Sql/servers/delete'
          'Microsoft.DBforPostgreSQL/servers/delete'
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
