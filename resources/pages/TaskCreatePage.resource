*** Settings ***
Documentation        Ações e elemtnos da página de cadastro de tarefas

Library    Browser


*** Keywords ***
Submit task form

    [Arguments]    ${task}

    Fill Text    css=input[placeholder*="Nome da tarefa"]        ${task}[name]

    FOR               ${tag}            IN    @{task}[tags]
        Fill Text     css=input[name=tags]    ${tag}
        Sleep         0.5
        Press Keys    css=input[name=tags]    Enter
    END

    Click        css=button >> text=cadastrar