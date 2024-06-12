@TimeEntries
Feature: TimeEntries
Background:
  And header x-api-key = NDlhOThjM2UtOTFhYi00MmQ3LTg0MzQtM2RhZDJlZjE2NjVm
  And header Content-Type = application/json
  Given base url https://api.clockify.me/api

@ConsultarHorasRegistradas
Scenario: Consultar horas registradas de un usuario en un espacio de trabajo
  Given call ClockifyWorkspace.feature@getUserIdFromWorkspace
  And endpoint /v1/workspaces/{{workspaceId}}/user/{{userId}}/time-entries
  When execute method GET
  Then the status code should be 200


@AgregarHorasAProyecto
Scenario: Agregar horas a un proyecto
  Given call ClockifyProject.feature@getProjectID
  And endpoint /v1/workspaces/{{workspaceId}}/time-entries
  And define unique descripcion
  And set value {{descripcion}} of key description in body jsons/bodies/AddTimeBody.json
  And set value {{projectId}} of key projectId in body jsons/bodies/AddTimeBody.json
  And set value "2019-01-01T08:00:00Z" of key start in body jsons/bodies/AddTimeBody.json
  And set value "2019-01-01T12:00:00Z" of key end in body jsons/bodies/AddTimeBody.json
  When execute method POST
  Then the status code should be 201
  * define timeEntryId = response.id

@EditarHorasTimeEntry
Scenario: Editar horas de un time entry
  Given call ClockifyTimeEntries.feature@AgregarHorasAProyecto
  And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
  And set value "2020-01-01T08:00:00Z" of key start in body jsons/bodies/EditTimeBody.json
  And set value "2020-01-01T12:00:00Z" of key end in body jsons/bodies/EditTimeBody.json
  When execute method PUT
  Then the status code should be 200

@BorrarTimeEntry
Scenario: Eliminar un time enty
  Given call ClockifyTimeEntries.feature@AgregarHorasAProyecto
  And endpoint /v1/workspaces/{{workspaceId}}/time-entries/{{timeEntryId}}
  When execute method DELETE
  Then the status code should be 204