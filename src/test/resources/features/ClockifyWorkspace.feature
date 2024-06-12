@Workspace
Feature: Workspace
Background:
  And header x-api-key = NDlhOThjM2UtOTFhYi00MmQ3LTg0MzQtM2RhZDJlZjE2NjVm
  And header Content-Type = application/json
  Given base url https://api.clockify.me/api

@getWorkspaceID #para call
Scenario: get workspace ID
  And endpoint /v1/workspaces
  When execute method GET
  Then the status code should be 200
  * define workspaceId = response[0].id


@getUserIdFromWorkspace
Scenario: get workspace ID y user ID
  Given call ClockifyWorkspace.feature@getWorkspaceID
  * define userId = response[0].memberships[0].userId