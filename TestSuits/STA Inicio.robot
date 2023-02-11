*** Settings ***
Documentation    Suite de Testes Automatizados para Pesquisar no google
Resource     ../Resources/base.robot

*** Test Cases ***
Abrir site
    Abrir browser    http://www.google.com    chrome
    Digitar termo [testes automatizados]
    Apertar tab
    Clicar no pesquisar