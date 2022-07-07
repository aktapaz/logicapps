param location string
param automationAccountName string
@secure()
param uri string
param runbookName string

resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: automationAccountName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    sku: {
      name: 'Basic'
    }
  }
}

resource runbook 'Microsoft.Automation/automationAccounts/runbooks@2019-06-01' = {
  name: runbookName
  parent: automationAccount
  location: location
  properties: {
    runbookType: 'PowerShell'
    logProgress: true
    logVerbose: true
    publishContentLink: {
      uri: uri
      version: '1.0.0.0'
    }
  }
}
