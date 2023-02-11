*** Settings ***
Documentation    Neste arquivo temos um exemplo de uso do Robot em singlePage
...    Nao é pratica comum no mercado manter Keywords e Test Cases no mesmo 
...    arquivo, mas para verificar se a instalação está ok, este é o meio mais rapido           

Library        SeleniumLibrary
Library        OperatingSystem
Library        pyautogui

*** Variables ***
${url}    http://www.google.com
${browser}    chrome
*** Keywords ***
Abrir browser
    Open Browser    ${url}    ${browser}   
	Maximize Browser Window

Digitar termo [${termo}]
    Input Text    //*[@name='q']    ${termo}
Apertar tab
    Press Keys    NONE    TAB
    Log to console    First tab
    BuiltIn.Sleep    2
   
Apertar tab com pyAutoGui
    Press   TAB    4    1.5
    Log To Console    More four tabs
    BuiltIn.Sleep    2

Clicar no pesquisar
    Click Element    (//*[@name='btnK'])[2]
    BuiltIn.Sleep    4

*** Test Cases ***
Abrir site
    Abrir browser
    Digitar termo [testes automatizados]
    Apertar tab
    Apertar tab com pyAutoGui
    Clicar no pesquisar

Escrever no arquivo
    ${Text} =  Catenate    SEPARATOR=    Text1    \n     Text2     \n 
    ${Value}     set variable  Text4
    createFile          ${EXECDIR}/File.txt      ${Text}
    Append To File      ${EXECDIR}/File.txt   ${Value}