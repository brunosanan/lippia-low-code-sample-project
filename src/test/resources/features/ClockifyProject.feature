@Project
Feature: Project
  Background:
    And header x-api-key = NDlhOThjM2UtOTFhYi00MmQ3LTg0MzQtM2RhZDJlZjE2NjVm
    And header Content-Type = application/json
    Given base url https://api.clockify.me/api

@getProjectID #para call
Scenario: get project id
  Given call ClockifyWorkspace.feature@getWorkspaceID
  And endpoint /v1/workspaces/{{workspaceId}}/projects/
  When execute method GET
  Then the status code should be 200
  * define projectId = response[0].id