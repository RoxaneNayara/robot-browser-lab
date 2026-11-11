*** Settings ***
Documentation    Passos em linguagem de negócio (BDD) para o login

Resource         ../base.resource
Resource         ../data/usuarios.resource
Resource         ../pages/login_page.resource
Resource         ../pages/products_page.resource


*** Keywords ***
que estou na página de login
    [Documentation]    Abre o navegador na página de login.
    Abrir o navegador na página inicial

faço login com o usuário "${usuario}" e a senha "${senha}"
    [Documentation]    Realiza o login com as credenciais informadas no cenário.
    Fazer login com    ${usuario}    ${senha}

devo ver a página de produtos
    [Documentation]    Confirma que o login levou à página de produtos.
    Validar que está na página de produtos

devo ver a mensagem de erro "${mensagem}"
    [Documentation]    Confirma a mensagem de erro exibida no login.
    Validar mensagem de erro    ${mensagem}

continuo na tela de login
    [Documentation]    Confirma que o usuário permaneceu na tela de login.
    Validar que continua na tela de login
