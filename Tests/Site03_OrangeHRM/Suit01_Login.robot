*** Settings ***
Documentation    Suite de Testes Automatizados para login no SauceLab

Resource    ../../Pages/Site03_OrangeHRM/Steps01_Login.robot

#Test Teardown    E o navegador sera fechado

*** Test Cases ***
CT01 Login com user padrao
    [Documentation]     Caso de Teste 235 - Login e senha validos
    [Tags]    Positivo    Login     
    Dado que abri a url no navegador
    Quando eu preencher o login e senha do user padrao
    E clicar no botao login
    Entao a tela inicial sera exibida