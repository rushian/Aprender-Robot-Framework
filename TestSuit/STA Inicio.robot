*** Settings ***
Resource     ../Resources/base.robot

*** Test Cases ***
Abrir site
    Abrir browser
    Digitar termo [testes automatizados]
    Apertar tab
    Clicar no pesquisar