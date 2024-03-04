*** Settings ***
Documentation    Suite de Testes Automatizados para login no SauceLab

Resource    ../../Pages/Site02_SauceLab/Steps01_Login.robot

Test Teardown    E o navegador sera fechado

*** Test Cases ***
CT01 Login com user padrao
    [Documentation]     Caso de Teste 235 - Login e senha validos
    [Tags]    Positivo    Login     
    Dado que abri a url no navegador
    Quando eu preencher o login e senha do user padrao
    E clicar no botao login
    Entao a tela de produtos sera exibida
    
CT02 Login sem usuario
    [Documentation]     Caso de Teste 237 - Login nao preenchido
    [Tags]    Negativo    Login    
    Dado que abri a url no navegador
    Quando eu preencher a senha do user padrao
    E clicar no botao login
    Entao sera exibida a mensagem de erro "Epic sadface: Username is required"
    
CT03 Login sem senha
    [Documentation]     Caso de Teste 243 - Senha nao preenchida
    [Tags]    Negativo    Login    
    Dado que abri a url no navegador
    Quando eu preencher user padrao
    E clicar no botao login
    Entao sera exibida a mensagem de erro "Epic sadface: Password is required"