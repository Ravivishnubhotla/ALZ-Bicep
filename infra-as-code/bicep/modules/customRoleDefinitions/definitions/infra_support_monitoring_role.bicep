targetScope = 'managementGroup'

metadata name = 'infra_support_monitoring_role'
metadata description = 'Infrastructure Support Monitoring Role with read and monitoring permissions.'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] Infrastructure Support Monitoring Role'
  description: 'Infrastructure Support Monitoring Role with read and monitoring permissions.'
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
          'Microsoft.Compute/virtualMachines/start/action'
          'Microsoft.Compute/virtualMachines/restart/action'
          'Microsoft.Authorization/*/read'
          'Microsoft.Network/virtualNetworks/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/operationResults/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/operationResults/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/backup/action'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/operationResults/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/operationsStatus/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/recoveryPoints/provisionInstantItemRecovery/action'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/recoveryPoints/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/recoveryPoints/restore/action'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/recoveryPoints/revokeInstantItemRecovery/action'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/protectedItems/write'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/refreshContainers/action'
          'Microsoft.RecoveryServices/Vaults/backupJobs/*'
          'Microsoft.RecoveryServices/Vaults/backupJobsExport/action'
          'Microsoft.RecoveryServices/Vaults/backupOperationResults/*'
          'Microsoft.RecoveryServices/Vaults/backupPolicies/operationResults/read'
          'Microsoft.RecoveryServices/Vaults/backupPolicies/read'
          'Microsoft.RecoveryServices/Vaults/backupProtectableItems/*'
          'Microsoft.RecoveryServices/Vaults/backupProtectedItems/read'
          'Microsoft.RecoveryServices/Vaults/backupProtectionContainers/read'
          'Microsoft.RecoveryServices/Vaults/backupUsageSummaries/read'
          'Microsoft.RecoveryServices/Vaults/certificates/write'
          'Microsoft.RecoveryServices/Vaults/extendedInformation/read'
          'Microsoft.RecoveryServices/Vaults/extendedInformation/write'
          'Microsoft.RecoveryServices/Vaults/monitoringAlerts/read'
          'Microsoft.RecoveryServices/Vaults/monitoringConfigurations/*'
          'Microsoft.RecoveryServices/Vaults/read'
          'Microsoft.RecoveryServices/Vaults/registeredIdentities/operationResults/read'
          'Microsoft.RecoveryServices/Vaults/registeredIdentities/read'
          'Microsoft.RecoveryServices/Vaults/registeredIdentities/write'
          'Microsoft.RecoveryServices/Vaults/usages/read'
          'Microsoft.Resources/deployments/*'
          'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.Storage/storageAccounts/read'
          'Microsoft.RecoveryServices/Vaults/backupstorageconfig/*'
          'Microsoft.RecoveryServices/Vaults/backupValidateOperation/action'
          'Microsoft.RecoveryServices/Vaults/backupOperations/read'
          'Microsoft.RecoveryServices/Vaults/backupPolicies/operations/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/write'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/inquire/action'
          'Microsoft.RecoveryServices/Vaults/backupEngines/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/backupProtectionIntent/write'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/backupProtectionIntent/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectableContainers/read'
          'Microsoft.RecoveryServices/Vaults/backupFabrics/protectionContainers/items/read'
          'Microsoft.RecoveryServices/locations/backupStatus/action'
          'Microsoft.RecoveryServices/locations/backupPreValidateProtection/action'
          'Microsoft.RecoveryServices/locations/backupValidateFeatures/action'
          'Microsoft.RecoveryServices/Vaults/monitoringAlerts/write'
          'Microsoft.RecoveryServices/operations/read'
          'Microsoft.RecoveryServices/locations/operationStatus/read'
          'Microsoft.RecoveryServices/Vaults/backupProtectionIntents/read'
          'Microsoft.Support/*'
          'Microsoft.Quota/*'
          'Microsoft.Capacity/*'
          'Microsoft.OperationalInsights/workspaces/analytics/query/action'
          'Microsoft.OperationalInsights/workspaces/search/action'
          'Microsoft.RecoveryServices/locations/allocatedStamp/read'
          'Microsoft.RecoveryServices/vaults/replicationAlertSettings/read'
          'Microsoft.RecoveryServices/vaults/replicationEvents/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationNetworks/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationNetworks/replicationNetworkMappings/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectableItems/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems/recoveryPoints/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectionContainerMappings/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationRecoveryServicesProviders/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationStorageClassifications/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationStorageClassifications/replicationStorageClassificationMappings/read'
          'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationvCenters/read'
          'Microsoft.RecoveryServices/vaults/replicationJobs/read'
          'Microsoft.RecoveryServices/vaults/replicationPolicies/read'
          'Microsoft.RecoveryServices/vaults/replicationRecoveryPlans/read'
          'Microsoft.RecoveryServices/Vaults/usages/read'
          'Microsoft.RecoveryServices/Vaults/vaultTokens/read'
          'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.Resources/subscriptions/resourceGroups/resources/read'
          'Microsoft.Resources/subscriptions/resources/read'
          'Microsoft.Resources/tags/*'
          'Microsoft.Insights/alertRules/*'
        ]
        notActions: [
          'Microsoft.Compute/virtualMachines/*/delete'
          'Microsoft.OperationalInsights/workspaces/sharedKeys/read'
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
