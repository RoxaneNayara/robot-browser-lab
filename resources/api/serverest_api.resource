*** Settings ***
Documentation    Service Object da API ServeRest (usuários e login)

Library          String
Library          RequestsLibrary


*** Variables ***
${API_URL}    https://serverest.dev


*** Keywords ***
Criar sessão na ServeRest
    [Documentation]    Cria a sessão HTTP com a URL base da ServeRest e verificação de certificado.
    Create Session    serverest    ${API_URL}    verify=True

Gerar usuário aleatório
    [Documentation]    Gera um usuário com email único para evitar conflito entre execuções.
    ${sufixo}=    Generate Random String    8    [LOWER]
    VAR    &{usuario}=
    ...    nome=QA Robot ${sufixo}
    ...    email=qa.${sufixo}@teste.com
    ...    password=senha123
    ...    administrador=true
    RETURN    ${usuario}

Cadastrar usuário
    [Documentation]    Cadastra o usuário e guarda o id para a limpeza no teardown.
    [Arguments]    ${usuario}    ${status_esperado}=201
    ${resposta}=    POST On Session    serverest    /usuarios    json=${usuario}    expected_status=${status_esperado}
    IF    ${resposta.status_code} == 201
        VAR    ${ID_USUARIO}=    ${resposta.json()}[_id]    scope=TEST
    END
    RETURN    ${resposta}

Fazer login na API
    [Documentation]    Faz login na ServeRest e valida o status code esperado.
    [Arguments]    ${email}    ${senha}    ${status_esperado}=200
    VAR    &{corpo}=    email=${email}    password=${senha}
    ${resposta}=    POST On Session    serverest    /login    json=${corpo}    expected_status=${status_esperado}
    RETURN    ${resposta}

Excluir usuário criado no teste
    [Documentation]    Exclui o usuário criado no teste, se houver, mantendo o ambiente limpo.
    ${id}=    Get Variable Value    ${ID_USUARIO}
    IF    $id
        DELETE On Session    serverest    /usuarios/${id}    expected_status=200
    END
