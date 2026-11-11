*** Settings ***
Documentation    Testes de login no Sauce Demo (site de prática)

Resource         ../../resources/base.resource
Resource         ../../resources/data/usuarios.resource
Resource         ../../resources/pages/login_page.resource
Resource         ../../resources/pages/products_page.resource

Test Setup       Abrir o navegador na página inicial
Test Teardown    Fechar o navegador

Test Tags        login


*** Test Cases ***
Login com usuário válido
    [Documentation]    Usuário padrão acessa a página de produtos.
    [Tags]    smoke
    Fazer login com    ${USUARIO_VALIDO}    ${SENHA_VALIDA}
    Validar que está na página de produtos

Login com senha inválida
    [Documentation]    Senha incorreta exibe mensagem de erro.
    [Tags]    negativo
    Fazer login com    ${USUARIO_VALIDO}    ${SENHA_INVALIDA}
    Validar mensagem de erro    Username and password do not match

Login com usuário bloqueado
    [Documentation]    Usuário bloqueado não consegue acessar o sistema.
    [Tags]    negativo
    Fazer login com    ${USUARIO_BLOQUEADO}    ${SENHA_VALIDA}
    Validar mensagem de erro    Sorry, this user has been locked out.
