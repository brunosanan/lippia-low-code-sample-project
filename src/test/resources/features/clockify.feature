@clockify
Feature: Clockify
Background:
  And header x-api-key = NDlhOThjM2UtOTFhYi00MmQ3LTg0MzQtM2RhZDJlZjE2NjVm
  And header Content-Type = application/json
  Given base url https://api.clockify.me/api

@getWorkspaceID #para call
Scenario: get all workspaces
  And endpoint /v1/workspaces
  When execute method GET
  Then the status code should be 200
  * define workspaceID = response[0].id

@getProjectID #para call
Scenario: get project id
  Given call clockify.feature@getWorkspaceID
  And endpoint /v1/workspaces/{{workspaceID}}/projects/
  When execute method GET
  Then the status code should be 200
  * define projectID = response[0].id

@CreateProject
Scenario: create project in a workspace
  Given call clockify.feature@getWorkspaceID
  And endpoint /v1/workspaces/{{workspaceID}}/projects
  And define unique nombre
  And set value {{nombre}} of key name in body jsons/bodies/bodyProject.json
  When execute method POST
  Then the status code should be 201

@CreateProjectError @errors
Scenario Outline: create project in a workspace fallido por <motivo>
  Given header x-api-key = <apiKey>
  Given call clockify.feature@getWorkspaceID
  And endpoint <endpoint>
  And set value <nombre> of key <key> in body jsons/bodies/bodyProject.json
  When execute method POST
  Then the status code should be <statusCode>

Examples:
  | motivo                    | statusCode | apiKey                                           | key       |endpoint |
  | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | "name"    |/workspaces/{{workspaceID}}/projects |
  | Proyecto no encontrado    | 404        | NDlhOThjM2UtOTFhYi00MmQ3LTg0MzQtM2RhZDJlZjE2NjVm | "name"    |/workspaces/{{workspaceID}}/project  |
  | Bad Request               | 400        | NDlhOThjM2UtOTFhYi00MmQ3LTg0MzQtM2RhZDJlZjE2NjVm | "isPublic"|/workspaces/{{workspaceID}}/projects |

@ArchiveProject #para call
Scenario: archivar proyecto
  Given call clockify.feature@getProjectID
  And endpoint /v1/workspaces/{{workspaceID}}/projects/{{projectID}}
  And set value true of key archived in body jsons/bodies/bodyUpdateProject.json
  When execute method PUT
  Then the status code should be 200

@DeleteProject
Scenario: delete project in a workspace
  Given call clockify.feature@ArchiveProject
  And endpoint /v1/workspaces/{{workspaceID}}/projects/{{projectID}}
  When execute method DELETE
  Then the status code should be 200

@DeleteProjectByIdError @errors
Scenario Outline: delete project in a workspace <motivo>
  Given call clockify.feature@getProjectID
  And header x-api-key = <apiKey>
  And endpoint <endpoint>
  When execute method POST
  Then the status code should be <statusCode>

Examples:
  | motivo                    | statusCode | apiKey                                           | endpoint                                              |
  | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | /workspaces/{{workspaceID}}/projects/{{projectID}}    |
  | Proyecto no encontrado    | 404        | Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5 | /workspaces/{{workspaceID}}/project/{{projectID}}     |
  | Bad Request               | 400        | Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5 | /workspaces/{{workspaceID}}/projects/;                |

@GetProjectById
Scenario: get project by id
  Given call clockify.feature@getProjectID
  And endpoint /v1/workspaces/{{workspaceID}}/projects/{{projectID}}
  When execute method GET
  Then the status code should be 200

@GetProjectByIdError @errors
Scenario Outline: delete project in a workspace <motivo>
  Given call clockify.feature@getProjectID
  And header x-api-key = <apiKey>
  And endpoint <endpoint>
  When execute method DELETE
  Then the status code should be <statusCode>

Examples:
  | motivo                    | statusCode | apiKey                                           | endpoint                                              |
  | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | /workspaces/{{workspaceID}}/projects/{{projectID}}    |
  | Proyecto no encontrado    | 404        | Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5 | /workspaces/{{workspaceID}}/project/{{projectID}}     |
  | Bad Request               | 400        | Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5 | /workspaces/{{workspaceID}}/projects/;                |


@GetProjectByIdError @errors
Scenario Outline: get project by id erroneo <motivo>
  Given call clockify.feature@getProjectID
  And header x-api-key = <apiKey>
  And endpoint <endpoint>
  When execute method GET
  Then the status code should be <statusCode>

Examples:
  | motivo                    | statusCode | apiKey                                           | endpoint                                              |
  | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | /workspaces/{{workspaceID}}/projects/{{projectID}}    |
  | Proyecto no encontrado    | 404        | Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5 | /workspaces/{{workspaceID}}/project/{{projectID}}     |
  | Bad Request               | 400        | Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5 | /workspaces/{{workspaceID}}/projects/;                |



@UpdateProject
Scenario: get project by id
  Given call clockify.feature@getProjectID
  And endpoint /v1/workspaces/{{workspaceID}}/projects/{{projectID}}
  And define unique nombre
  And set value {{nombre}} of key name in body jsons/bodies/bodyUpdateProject.json
  When execute method PUT
  Then the status code should be 200
  And response should be name = {{nombre}}


@UpdateProjectError @errors
  Scenario Outline: get project by id erroneo <motivo>
  Given call clockify.feature@getProjectID
  And header x-api-key = <apiKey>
  And endpoint <endpoint>
  And define unique nombre
  And set value {{nombre}} of key name in body jsons/bodies/bodyProject.json
  When execute method PUT
  Then the status code should be <statusCode>

Examples:
  | motivo                    | statusCode | apiKey                                           | endpoint                                              |
  | No autorizado             | 401        | AAU5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjZZ | /workspaces/{{workspaceID}}/projects/{{projectID}}    |
  | Proyecto no encontrado    | 404        | Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5 | /workspaces/{{workspaceID}}/project/{{projectID}}     |
  | Bad Request               | 400        | Y2U5NzYwZTMtNDdjMy00ZDgyLThmNmYtMTc0YmViYWJjNjg5 | /workspaces/{{workspaceID}}/projects/;                |




