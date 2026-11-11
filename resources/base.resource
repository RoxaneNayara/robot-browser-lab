*** Settings ***
Documentation     Configurações comuns a todos os testes web
Library           Browser

*** Variables ***
${URL}         https://www.saucedemo.com
${BROWSER}     chromium
${HEADLESS}    False

*** Keywords ***
Abrir o navegador na página inicial
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Page       ${URL}

Fechar o navegador
    Close Browser