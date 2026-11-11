*** Settings ***
Documentation     Page Object da tela de produtos
Library           Browser

*** Variables ***
${TITULO_PAGINA}    css=.title

*** Keywords ***
Validar que está na página de produtos
    Get Url     contains    inventory.html
    Get Text    ${TITULO_PAGINA}    ==    Products