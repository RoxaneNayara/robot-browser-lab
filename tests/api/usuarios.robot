*** Settings ***
Documentation    Testes de API de usuários e login na ServeRest

Resource         ../../resources/api/serverest_api.resource

Suite Setup      Criar sessão na ServeRest
Test Teardown    Excluir usuário criado no teste

Test Tags        api


*** Test Cases ***
Cadastrar usuário com sucesso
    [Documentation]    POST /usuarios com dados válidos retorna 201 e o id do usuário.
    [Tags]    smoke
    ${usuario}=    Gerar usuário aleatório
    ${resposta}=    Cadastrar usuário    ${usuario}
    Should Be Equal    ${resposta.json()}[message]    Cadastro realizado com sucesso
    Should Not Be Empty    ${resposta.json()}[_id]

Não permitir cadastro com email duplicado
    [Documentation]    Cadastrar o mesmo email duas vezes retorna 400.
    [Tags]    negativo
    ${usuario}=    Gerar usuário aleatório
    Cadastrar usuário    ${usuario}
    ${resposta}=    Cadastrar usuário    ${usuario}    status_esperado=400
    Should Be Equal    ${resposta.json()}[message]    Este email já está sendo usado

Login com sucesso retorna token
    [Documentation]    POST /login com credenciais válidas retorna 200 e token Bearer.
    [Tags]    smoke
    ${usuario}=    Gerar usuário aleatório
    Cadastrar usuário    ${usuario}
    ${resposta}=    Fazer login na API    ${usuario}[email]    ${usuario}[password]
    Should Be Equal    ${resposta.json()}[message]    Login realizado com sucesso
    Should Start With    ${resposta.json()}[authorization]    Bearer${SPACE}

Login com senha inválida
    [Documentation]    POST /login com senha incorreta retorna 401.
    [Tags]    negativo
    ${usuario}=    Gerar usuário aleatório
    Cadastrar usuário    ${usuario}
    ${resposta}=    Fazer login na API    ${usuario}[email]    senha_errada    status_esperado=401
    Should Be Equal    ${resposta.json()}[message]    Email e/ou senha inválidos
