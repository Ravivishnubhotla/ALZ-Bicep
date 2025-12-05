targetScope = 'managementGroup'

metadata name = 'ALZ Bicep - Custom Role Definitions'
metadata description ='Custom Role Definitions for ALZ Bicep'

@sys.description('The management group scope to which the role can be assigned. This management group ID will be used for the assignableScopes property in the role definition.')
param parAssignableScopeManagementGroupId string = 'alz'

@sys.description('Set Parameter to true to Opt-out of deployment telemetry.')
param parTelemetryOptOut bool = false

// Customer Usage Attribution Id
var varCuaid = '032d0904-3d50-45ef-a6c1-baa9d82e23ff'

module modRolesSubscriptionOwnerRole 'definitions/cafSubscriptionOwnerRole.bicep' = {
  name: 'deploy-subscription-owner-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesApplicationOwnerRole 'definitions/cafApplicationOwnerRole.bicep' = {
  name: 'deploy-application-owner-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesNetworkManagementRole 'definitions/cafNetworkManagementRole.bicep' = {
  name: 'deploy-network-management-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesSecurityOperationsRole 'definitions/cafSecurityOperationsRole.bicep' = {
  name: 'deploy-security-operations-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

//Custom Roles
module modRolesEngineeringDBARoleRole 'definitions/engineering_azure_dba_role.bicep' = {
  name: 'deploy-engineering-dba-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesEngineeringDeveloperRole 'definitions/engineering_azure_developer_role.bicep' = {
  name: 'deploy-engineering-developer-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesEngineeringOperationsRole 'definitions/engineering_azure_operations_role.bicep' = {
  name: 'deploy-engineering-operations-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesInfraEARole 'definitions/infra_azure_ea_role.bicep' = {
  name: 'deploy-infra-ea-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesInfraEngRole 'definitions/infra_azure_eng_role.bicep' = {
  name: 'deploy-infra-eng-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesInfraGovernanceRole 'definitions/infra_azure_governance_role.bicep' = {
  name: 'deploy-infra-governance-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesInfraInfosecRole 'definitions/infra_azure_infosec_role.bicep' = {
  name: 'deploy-infra-infosec-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesInfraNetworkingRole 'definitions/infra_azure_networking_role.bicep' = {
  name: 'deploy-infra-networking-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesInfraReservationsRole 'definitions/infra_azure_reservations_role.bicep' = {
  name: 'deploy-infra-reservations-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesInfraSRERole 'definitions/infra_azure_sre_role.bicep' = {
  name: 'deploy-infra-sre-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}

module modRolesInfraSupportMonitoringRole 'definitions/infra_support_monitoring_role.bicep' = {
  name: 'deploy-infra-support-monitoring-role'
  params: {
    parAssignableScopeManagementGroupId: parAssignableScopeManagementGroupId
  }
}



// Optional Deployment for Customer Usage Attribution
module modCustomerUsageAttribution '../../CRML/customerUsageAttribution/cuaIdManagementGroup.bicep' = if (!parTelemetryOptOut) {
  #disable-next-line no-loc-expr-outside-params //Only to ensure telemetry data is stored in same location as deployment. See https://github.com/Azure/ALZ-Bicep/wiki/FAQ#why-are-some-linter-rules-disabled-via-the-disable-next-line-bicep-function for more information
  name: 'pid-${varCuaid}-${uniqueString(deployment().location)}'
  params: {}
}

output outRolesSubscriptionOwnerRoleId string = modRolesSubscriptionOwnerRole.outputs.outRoleDefinitionId
output outRolesApplicationOwnerRoleId string = modRolesApplicationOwnerRole.outputs.outRoleDefinitionId
output outRolesNetworkManagementRoleId string = modRolesNetworkManagementRole.outputs.outRoleDefinitionId
output outRolesSecurityOperationsRoleId string = modRolesSecurityOperationsRole.outputs.outRoleDefinitionId
output outRolesEngineeringDBARoleRole string = modRolesEngineeringDBARoleRole.outputs.outRoleDefinitionId
output outRolesEngineeringDeveloperRole string = modRolesEngineeringDeveloperRole.outputs.outRoleDefinitionId
output outRolesEngineeringOperationsRole string = modRolesEngineeringOperationsRole.outputs.outRoleDefinitionId
output outRolesInfraEARole string = modRolesInfraEARole.outputs.outRoleDefinitionId
output outRolesInfraGovernanceRole string = modRolesInfraGovernanceRole.outputs.outRoleDefinitionId
output outRolesInfraInfosecRole string = modRolesInfraInfosecRole.outputs.outRoleDefinitionId
output outRolesInfraNetworkingRole string = modRolesInfraNetworkingRole.outputs.outRoleDefinitionId
output outRolesInfraReservationsRole string = modRolesInfraReservationsRole.outputs.outRoleDefinitionId
output outRolesInfraEngRole string = modRolesInfraEngRole.outputs.outRoleDefinitionId
output outRolesInfraSRERole string = modRolesInfraSRERole.outputs.outRoleDefinitionId
output outRolesInfraSupportMonitoringRole string = modRolesInfraSupportMonitoringRole.outputs.outRoleDefinitionId
