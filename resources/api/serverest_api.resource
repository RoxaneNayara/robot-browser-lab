*** Settings ***
Documentation    Service Object da API ServeRest (usuários e login)

Library          RequestsLibrary
Library          String


*** Variables ***
${API_URL}    https://serverest.dev


*** Keywords ***
Criar sessão na ServeRest
    Create Session    serverest    ${API_URL}    verify=True

Gerar usuário aleatório
    ${sufixo}=    Generate Random String    8    [LOWER]
    ${usuario}=    Create Dictionary
    ...    nome=QA Robot ${sufixo}
    ...    email=qa.${sufixo}@teste.com
    ...    password=senha123
    ...    administrador=true
    RETURN    ${usuario}

Cadastrar usuário
    [Arguments]    ${usuario}    ${status_esperado}=201
    ${resposta}=    POST On Session    serverest    /usuarios    json=${usuario}    expected_status=${status_esperado}
    IF    ${resposta.status_code} == 201
        Set Test Variable    ${ID_USUARIO}    ${resposta.json()}[_id]
    END
    RETURN    ${resposta}

Fazer login na API
    [Arguments]    ${email}    ${senha}    ${status_esperado}=200
    ${corpo}=    Create Dictionary    email=${email}    password=${senha}
    ${resposta}=    POST On Session    serverest    /login    json=${corpo}    expected_status=${status_esperado}
    RETURN    ${resposta}

Excluir usuário criado no teste
    ${id}=    Get Variable Value    ${ID_USUARIO}
    IF    $id
        DELETE On Session    serverest    /usuarios/${id}    expected_status=200
    END
