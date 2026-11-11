*** Settings ***
Documentation    Testes de API de usuários e login na ServeRest

Resource         ../../resources/api/serverest_api.resource

Suite Setup      Criar sessão na ServeRest
Test Teardown    Excluir usuário criado no teste


*** Test Cases ***
Cadastrar usuário com sucesso
    [Tags]    api    smoke
    ${usuario}=    Gerar usuário aleatório
    ${resposta}=    Cadastrar usuário    ${usuario}
    Should Be Equal    ${resposta.json()}[message]    Cadastro realizado com sucesso
    Should Not Be Empty    ${resposta.json()}[_id]

Não permitir cadastro com email duplicado
    [Tags]    api    negativo
    ${usuario}=    Gerar usuário aleatório
    Cadastrar usuário    ${usuario}
    ${resposta}=    Cadastrar usuário    ${usuario}    status_esperado=400
    Should Be Equal    ${resposta.json()}[message]    Este email já está sendo usado

Login com sucesso retorna token
    [Tags]    api    smoke
    ${usuario}=    Gerar usuário aleatório
    Cadastrar usuário    ${usuario}
    ${resposta}=    Fazer login na API    ${usuario}[email]    ${usuario}[password]
    Should Be Equal    ${resposta.json()}[message]    Login realizado com sucesso
    Should Start With    ${resposta.json()}[authorization]    Bearer${SPACE}

Login com senha inválida
    [Tags]    api    negativo
    ${usuario}=    Gerar usuário aleatório
    Cadastrar usuário    ${usuario}
    ${resposta}=    Fazer login na API    ${usuario}[email]    senha_errada    status_esperado=401
    Should Be Equal    ${resposta.json()}[message]    Email e/ou senha inválidos
