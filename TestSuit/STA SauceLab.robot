*** Settings ***
Documentation    Suite de Testes Automatizados para Pesquisar no google
Resource     ../Resources/base.robot

*** Test Cases ***
Login com user padrao
    [Documentation]     Caso de Teste 235 
    ...    ID: 1 Tipo do CT: Positivo 
    Dado que abri a url no navegador
    Quando eu preencher o login e senha do user padrao
    E clicar no botao login
    Entao a tela de produtos sera exibida
    
