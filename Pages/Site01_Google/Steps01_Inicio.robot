*** Settings ***
Documentation       Em Page Objects separamos a pasta onde ficam as palavras chaves
...                 Para cada arquivo na pasta Test deve haver um ou mais correspondente(s) na pasta Pages
...                 O gherkin do caso de teste fica na testSuit, a implementação das palavras-chaves ficam na Pages

Resource    ../../Resources/base.robot

*** Variables ***
${proxima_pagina}       //*[@id="pnnext"]/span[2]

*** Keywords ***
Dado que abri o google no navegador
    Abrir browser    http://www.google.com    chrome

Quando digitar um termo [${termo}]
    [Documentation]    Insira o termo a ser pesquisado no lugar da variavel entre colchetes
    Log To Console    Digitar termo '${termo}'
    Input Text    //*[@name='q']    ${termo}

E apertar tab
    Log to console    Apertar tab
    Press Keys    NONE    TAB
    BuiltIn.Sleep    2

E clicar no pesquisar
    Wait Until Element Is Visible    (//*[@name='btnK'])[2]    6
    Log To Console    Pesquisar
    Click Element    (//*[@name='btnK'])[2]

Entao o titulo da pagina deve conter o termo pesquisado [${termo}]
    Log To Console    Verificar titulo da pagina
    Wait Until Element Is Visible    //div[@class='logo']/a/img
    Title Should Be    ${termo} - Pesquisa Google
    Sleep    3    #tempo para visualizar o resultado da busca

E deve haver mais de uma pagina de resultados
    Scroll Element Into View    ${proxima_pagina}
    Sleep    3
    E o navegador sera fechado