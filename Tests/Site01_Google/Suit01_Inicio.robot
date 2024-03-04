*** Settings ***
Documentation       Suite de Testes Automatizados para Pesquisar no google

Resource            ../../Pages/Site01_Google/Steps01_Inicio.robot

*** Test Cases ***
CT01 Abrir site e pesquisar
    [Documentation]    ID JIRA 2065557 - Abrir navegador na pagina do google e pesquisar um termo
    [Tags]    positivo    abrirsite
    Dado que abri o google no navegador
    Quando digitar um termo [testes automatizados]
    E apertar tab
    E clicar no pesquisar
    Entao o titulo da pagina deve conter o termo pesquisado [testes automatizados]
    E deve haver mais de uma pagina de resultados