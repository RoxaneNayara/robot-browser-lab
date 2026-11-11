*** Settings ***
Documentation     Page Object da tela de login
Library           Browser

*** Variables ***
${CAMPO_USUARIO}    id=user-name
${CAMPO_SENHA}      id=password
${BOTAO_LOGIN}      id=login-button
${MENSAGEM_ERRO}    css=[data-test="error"]

*** Keywords ***
Fazer login com
    [Arguments]    ${usuario}    ${senha}
    Fill Text    ${CAMPO_USUARIO}    ${usuario}
    Fill Text    ${CAMPO_SENHA}      ${senha}
    Click        ${BOTAO_LOGIN}

Validar mensagem de erro
    [Arguments]    ${mensagem_esperada}
    Get Text    ${MENSAGEM_ERRO}    contains    ${mensagem_esperada}

Validar que continua na tela de login
    Wait For Elements State    ${BOTAO_LOGIN}    visible