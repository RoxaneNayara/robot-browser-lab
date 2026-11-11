*** Settings ***
Documentation     Passos em linguagem de negócio (BDD) para o login
Resource          ../base.resource
Resource          ../data/usuarios.resource
Resource          ../pages/login_page.resource
Resource          ../pages/products_page.resource

*** Keywords ***
que estou na página de login
    Abrir o navegador na página inicial

faço login com o usuário "${usuario}" e a senha "${senha}"
    Fazer login com    ${usuario}    ${senha}

devo ver a página de produtos
    Validar que está na página de produtos

devo ver a mensagem de erro "${mensagem}"
    Validar mensagem de erro    ${mensagem}

continuo na tela de login
    Validar que continua na tela de login