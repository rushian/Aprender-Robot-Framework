*** Settings ***
Resource    ../000_configuracoes.robot

*** Keywords ***
Dado que abri o google no navegador
    Abrir browser    http://www.google.com    chrome

Quando digitar um termo [${termo}]
    Log To Console    Digitar termo '${termo}'
    Input Text    //*[@name='q']    ${termo}

E apertar tab
    Log to console    Apertar tab
    Press Keys    NONE    TAB
    BuiltIn.Sleep    2

 E clicar no pesquisar
    Log To Console    Pesquisar
    Click Element    (//*[@name='btnK'])[2]
    BuiltIn.Sleep    2

Entao o titulo da pagina deve conter o termo pesquisado [${termo}]
    Log To Console    Verificar titulo da pagina
    Wait Until Element Is Visible    //div[@class='logo']/a/img
    Title Should Be    ${termo} - Pesquisa Google