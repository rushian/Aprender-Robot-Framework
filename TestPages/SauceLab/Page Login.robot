*** Settings ***
Documentation    Palavras chaves para o site https://www.saucedemo.com/
Resource    ../000_configuracoes.robot
*** Variables ***
${user_padrao}    standard_user
${senha}    secret_sauce

# xpaths na ordem em que apareceram
# ===== CT 235 =====
${input_usuario}    //*[@data-test='username']
${input_senha}      //*[@data-test='password']
${btn_login}        //*[@id='login-button']
${title_products}   //span[.='Products'] 
# ===== CT 237 =====
${h3_username_required}    //h3[contains(.,'Username is required')] 


*** Keywords ***
# =============== CT 235 ===============
Dado que abri a url no navegador
    #exemplo de uso de palavras chaves, ou métodos criados por nós
    Abrir browser    https://www.saucedemo.com/    chrome

Quando eu preencher o login e senha do user padrao
    Log To Console    Preencher login e senha
    Wait Until Element Is Visible    ${input_usuario}
    Input Text    ${input_usuario}    ${user_padrao}
    Input Password    ${input_senha}    ${senha}

E clicar no botao login
    Log To Console    Clicar no Login
    Click Element    ${btn_login}

Entao a tela de produtos sera exibida
    Log To Console    Validar titulo Products
    Wait Until Element Is Visible    ${title_products}
    Element Text Should Be    ${title_products}    PRODUCTS

# =============== CT 237 ===============
Quando eu preencher a senha do user padrao
    Log to Console    Preencher somente a senha
    Wait Until Element Is Visible    ${input_senha}
    Input Password    ${input_senha}    ${senha}
    
Entao sera exibida a mensagem de erro "Epic sadface: Username is required"
    Log To Console    Validar mensagem de erro do Usuario
    Wait Until Element Is Visible    ${h3_username_required}
    ${texto_erro}    Get Text    ${h3_username_required}
    Should Be True    '${texto_erro}' == 'Epic sadface: Username is required'

# =============== CT 243 ===============
Quando eu preencher user padrao
    Log to Console    Preencher somente a senha
    Wait Until Element Is Visible    ${input_usuario}
    Input Password    ${input_usuario}    ${user_padrao}
    
Entao sera exibida a mensagem de erro "Epic sadface: Username is required"
    Log To Console    Validar mensagem de erro da senha
    Wait Until Element Is Visible    ${h3_username_required}
    ${texto_erro}    Get Text    ${h3_username_required}
    Should Be True    '${texto_erro}' == 'Epic sadface: Username is required'