language: pt-BR

*** Settings ***
Documentation    Login no Sauce Demo escrito em BDD (Dado/Quando/Então)

Resource         ../../resources/steps/login_steps.resource

Test Teardown    Fechar o navegador


*** Test Cases ***
Cenário: Login com usuário válido
    [Tags]    bdd    smoke
    Dado que estou na página de login
    Quando faço login com o usuário "${USUARIO_VALIDO}" e a senha "${SENHA_VALIDA}"
    Então devo ver a página de produtos

Cenário: Login com senha inválida
    [Tags]    bdd    negativo
    Dado que estou na página de login
    Quando faço login com o usuário "${USUARIO_VALIDO}" e a senha "${SENHA_INVALIDA}"
    Então devo ver a mensagem de erro "Username and password do not match"
    E continuo na tela de login

Cenário: Login com usuário bloqueado
    [Tags]    bdd    negativo
    Dado que estou na página de login
    Quando faço login com o usuário "${USUARIO_BLOQUEADO}" e a senha "${SENHA_VALIDA}"
    Então devo ver a mensagem de erro "Sorry, this user has been locked out."
    E continuo na tela de login
