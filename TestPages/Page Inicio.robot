*** Settings ***
Resource    000_configuracoes.robot

*** Keywords ***
Digitar termo [${termo}]
    Input Text    //*[@name='q']    ${termo}

Apertar tab
    Press Keys    NONE    TAB
    Log to console    First tab
    BuiltIn.Sleep    2

Clicar no pesquisar
    Click Element    (//*[@name='btnK'])[2]
    BuiltIn.Sleep    4