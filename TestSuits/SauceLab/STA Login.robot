*** Settings ***
Documentation    Suite de Testes Automatizados para Pesquisar no google
Resource     ../../Resources/base.robot

*** Test Cases ***
Login com user padrao
    [Documentation]     Caso de Teste 235 
    ...    ID: 1 Tipo do CT: Positivo 
    Dado que abri a url no navegador
    Quando eu preencher o login e senha do user padrao
    E clicar no botao login
    Entao a tela de produtos sera exibida
Login sem usuario
    [Documentation]     Caso de Teste 237 
    ...    ID: 2 Tipo do CT: Negativo 
    Dado que abri a url no navegador
    Quando eu preencher a senha do user padrao
    E clicar no botao login
    Entao sera exibida a mensagem de erro "Epic sadface: Username is required"
    
