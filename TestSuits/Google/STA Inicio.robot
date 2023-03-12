*** Settings ***
Documentation    Suite de Testes Automatizados para Pesquisar no google
Resource     ../../Resources/base.robot

*** Test Cases ***
Caso de Teste: Abrir site
    Dado que abri o google no navegador
    Quando digitar um termo [testes automatizados]
    E apertar tab
    E clicar no pesquisar
    Entao o titulo da pagina deve conter o termo pesquisado [testes automatizados]