*** Settings ***
Documentation        Cenários de cadastros de tarefas

Library         JSONLibrary

Resource        ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa

    ${data}    Get fixture    tasks    create

    Reset user from database         ${data}[user] 

    Do login                         ${data}[user]

    Go to task form
    Submit task form                 ${data}[tasks]
    Tasks should be registered       ${data}[tasks][name]


Não deve cadastrar tarefa com nome duplicado
    [Tags]    dup
    
    ${data}        Get fixture       tasks    duplicate

    Reset user from database         ${data}[user] 

    Create a new task from API       ${data}
    
    Do login                         ${data}[user]

    Go to task form
    Submit task form                 ${data}[tasks]

    Notice should be                 Oops! Tarefa duplicada.


Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]    tags_limit


    ${data}        Get fixture       tasks    tags_limit

    Reset user from database         ${data}[user] 
    
    Do login                         ${data}[user]

    Go to task form
    Submit task form                 ${data}[tasks]

    Notice should be                 Oops! Limite de tags atingido.