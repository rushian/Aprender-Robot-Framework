*** Settings ***
Documentation    Suite de Testes para aprender o uso de palavras-chaves
Resource     ../../Pages/Site77_Diversos/Steps10_BancoDeDados.robot

*** Test Cases ***
CT01 - Inserir dados de Contato numa DB Oracle

    Dado que eu esteja conectado na VPN
    Quando eu informar os dados de Contato
    E executar a query de insercao no banco de dados
    Entao os dados de contato serao exibidos ao consultar

CT02 - Lista contatos
    [Documentation]     Caso de Teste 432
    [Tags]    CT02    
    Entao os dados de contato serao exibidos ao consultar

CT03 Criar arquivo sqlite
    Dado que verifico a existencia da base [database.sqlite] no diretorio [TestData]
    Entao crio um banco de dados sqlite