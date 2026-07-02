*** Settings ***
Documentation    Neste arquivo temos um exemplo de uso do Robot em singlePage
...    Nao é pratica comum no mercado manter Keywords e Test Cases no mesmo 
...    arquivo, mas para verificar se a instalação está ok, este é o meio mais rapido           

Library        SeleniumLibrary

*** Test Cases ***
CT01 Abrir site da mazon e realizar pesquisa
    Abrir navegador
    # Clicar em continuar comprando
    Digitar o termo 'testes automatizados'
    Clicar no pesquisar

*** Keywords ***
Abrir navegador
    Open Browser    http://www.amazon.com.br    chrome    #options=add_experimental_option("detach",True)
	Maximize Browser Window
    Log To Console    Abrir site da Amazon no navegador

Clicar em continuar comprando
    Click Element    //*[.='Continuar comprando']
    Log To Console    Clicar em continuar comprando

Digitar o termo 'testes automatizados'
    Wait Until Element Is Enabled    //*[@id='twotabsearchtextbox']
    Input Text    //*[@id='twotabsearchtextbox']    testes automatizados
    Log To Console    Digitar o termo 'testes automatizados'

Clicar no pesquisar
    Press Keys    NONE    ENTER
    Sleep    2
    Log To Console    Clicar em pesquisar e aguardar resultado