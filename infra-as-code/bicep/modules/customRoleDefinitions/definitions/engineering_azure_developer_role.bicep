targetScope = 'managementGroup'

metadata name = 'engineering_azure_developer_role'
metadata description = 'Azure Developer Role with permissions to develop and manage Azure resources'

@sys.description('The management group scope to which the role can be assigned.  This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string

var varRole = {
  name: '[${managementGroup().name}] Engineering Developer Role'
  description: 'Azure Developer Role with permissions to develop and manage Azure resources'
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
          'Microsoft.ContainerRegistry/registries/artifacts/delete'
          'Microsoft.ContainerRegistry/registries/sign/write'
          'Microsoft.ContainerRegistry/registries/pull/read'
          'Microsoft.ContainerRegistry/registries/push/write'
          'Microsoft.ContainerRegistry/registries/quarantine/read'
          'Microsoft.ContainerRegistry/registries/quarantine/write'
          'Microsoft.ContainerService/managedClusters/listClusterUserCredential/action'
          'Microsoft.ContainerService/managedClusters/read'
          'Microsoft.Search/searchServices/*'
          'Microsoft.Insights/alertRules/*'
          'Microsoft.ResourceHealth/availabilityStatuses/read'
          'Microsoft.Resources/deployments/*'
          'Microsoft.Support/*'
          'Microsoft.Authorization/*/read'
          'Microsoft.Web/serverFarms/*'
          'Microsoft.Web/hostingEnvironments/Join/Action'
          'Microsoft.Insights/components/*'
          'Microsoft.Web/certificates/*'
          'Microsoft.Web/listSitesAssignedToHostName/read'
          'Microsoft.Web/sites/*'
          'Microsoft.Automation/automationAccounts/hybridRunbookWorkerGroups/read'
          'Microsoft.Automation/automationAccounts/jobs/read'
          'Microsoft.Automation/automationAccounts/jobs/resume/action'
          'Microsoft.Automation/automationAccounts/jobs/stop/action'
          'Microsoft.Automation/automationAccounts/jobs/streams/read'
          'Microsoft.Automation/automationAccounts/jobs/suspend/action'
          'Microsoft.Automation/automationAccounts/jobs/write'
          'Microsoft.Automation/automationAccounts/jobs/output/read'
          'Microsoft.ClassicStorage/storageAccounts/listKeys/action'
          'Microsoft.ClassicStorage/storageAccounts/read'
          'Microsoft.Insights/metricAlerts/*'
          'Microsoft.Insights/diagnosticSettings/*'
          'Microsoft.Insights/logdefinitions/*'
          'Microsoft.Insights/metricDefinitions/*'
          'Microsoft.Logic/*'
          'Microsoft.Storage/storageAccounts/listkeys/action'
          'Microsoft.Storage/storageAccounts/read'
          'Microsoft.Web/connectionGateways/*'
          'Microsoft.Web/connections/*'
          'Microsoft.Web/customApis/*'
          'Microsoft.Web/sites/functions/listSecrets/action'
          'Microsoft.ApiManagement/service/*'
          'Microsoft.AppConfiguration/configurationStores/*/read'
          'Microsoft.EventGrid/eventSubscriptions/write'
          'Microsoft.EventGrid/topicTypes/eventSubscriptions/read'
          'Microsoft.EventGrid/locations/eventSubscriptions/read'
          'Microsoft.EventGrid/locations/topicTypes/eventSubscriptions/read'
          'Microsoft.Logic/integrationServiceEnvironments/read'
          'Microsoft.Logic/integrationServiceEnvironments/join/action'
          'Microsoft.CognitiveServices/*/read'
          'Microsoft.CognitiveServices/accounts/listkeys/action'
          'Microsoft.DataFactory/dataFactories/*'
          'Microsoft.DataFactory/factories/*'
          'Microsoft.EventHub/*/eventhubs/consumergroups/read'
          'Microsoft.EventHub/*/eventhubs/read'
          'Microsoft.ServiceBus/*/queues/read'
          'Microsoft.ServiceBus/*/topics/read'
          'Microsoft.ServiceBus/*/topics/subscriptions/read'
          'Microsoft.Storage/storageAccounts/blobServices/containers/delete'
          'Microsoft.Storage/storageAccounts/blobServices/containers/read'
          'Microsoft.Storage/storageAccounts/blobServices/containers/write'
          'Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action'
          'Microsoft.Storage/storageAccounts/blobServices/containers/delete'
          '*/read'
          'Microsoft.MachineLearningServices/workspaces/*/delete'
          'Microsoft.MachineLearningServices/workspaces/write'
          'Microsoft.MachineLearningServices/workspaces/computes/*/write'
          'Microsoft.MachineLearningServices/workspaces/computes/*/delete'
          'Microsoft.Logic/workflows/disable/action'
          'Microsoft.Logic/workflows/enable/action'
          'Microsoft.Logic/workflows/validate/action'
          'Microsoft.Insights/metricDefinitions/*/read'
          'Microsoft.StreamAnalytics/*'
          'microsoft.web/sites/workflows/read'
        ]
        notActions: [
          'Microsoft.Compute/disks/beginGetAccess/action'
        ]
        dataActions: [
          'Microsoft.CognitiveServices/*'
          'Microsoft.EventHub/*/receive/action'
          'Microsoft.EventHub/*/send/action'
          'Microsoft.ServiceBus/*/send/action'
          'Microsoft.ServiceBus/*/receive/action'
          'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete'
          'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read'
          'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write'
          'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/move/action'
          'Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action'
          'Microsoft.KeyVault/vaults/*'
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
