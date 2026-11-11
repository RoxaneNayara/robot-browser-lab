*** Settings ***
Documentation    Page Object da tela de login

Library          Browser


*** Variables ***
${CAMPO_USUARIO}    id=user-name
${CAMPO_SENHA}      id=password
${BOTAO_LOGIN}      id=login-button
${MENSAGEM_ERRO}    css=[data-test="error"]


*** Keywords ***
Fazer login com
    [Documentation]    Preenche usuário e senha e clica no botão de login.
    [Arguments]    ${usuario}    ${senha}
    Fill Text    ${CAMPO_USUARIO}    ${usuario}
    Fill Text    ${CAMPO_SENHA}    ${senha}
    Click    ${BOTAO_LOGIN}

Validar mensagem de erro
    [Documentation]    Valida que a mensagem de erro do login contém o texto esperado.
    [Arguments]    ${mensagem_esperada}
    Get Text    ${MENSAGEM_ERRO}    contains    ${mensagem_esperada}

Validar que continua na tela de login
    [Documentation]    Garante que o usuário não entrou no sistema (botão de login visível).
    Wait For Elements State    ${BOTAO_LOGIN}    visible
