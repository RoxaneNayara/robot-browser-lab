*** Settings ***
Documentation    Configurações comuns a todos os testes web

Library          Browser


*** Variables ***
${URL}         https://www.saucedemo.com
${BROWSER}     chromium
${HEADLESS}    False


*** Keywords ***
Abrir o navegador na página inicial
    [Documentation]    Abre o navegador configurado e acessa a URL inicial do Sauce Demo.
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Page    ${URL}

Fechar o navegador
    [Documentation]    Fecha o navegador e todas as páginas abertas.
    Close Browser
