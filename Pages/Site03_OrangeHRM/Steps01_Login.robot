*** Settings ***
Documentation    Palavras chaves para o site https://www.saucedemo.com/
...     Pagina do Login
Resource    ../../Resources/base.robot

*** Variables ***
# valores padrao
${user_padrao}    Admin
${senha}    admin123

# xpaths na ordem em que apareceram
# ===== CT 235 =====
${input_usuario}    name=username
${input_senha}      name=password
${btn_login}        //button[contains(.,'Login')]
${title_products}   //*[@id="app"]/div[1]/div[1]/header/div[1]/div[1]/span/h6
# ===== CT 237 =====
${h3_username_required}     //h3[contains(.,'Username is required')] 
${h3_password_required}     //h3[contains(.,'Password is required')] 

*** Keywords ***
# =============== CT 235 ===============
Dado que abri a url no navegador
    #exemplo de uso de palavras chaves, ou métodos criados por nós
    Abrir browser    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login    chrome     

Quando eu preencher o login e senha do user padrao
    Log To Console    Preencher login e senha
    Wait Until Element Is Visible    ${input_usuario}
    Input Text    ${input_usuario}    ${user_padrao}
    Input Password    ${input_senha}    ${senha}

E clicar no botao login
    Log To Console    Clicar no Login
    Click Element    ${btn_login}

Entao a tela inicial sera exibida
    Log To Console    Validar titulo Products
    Wait Until Element Is Visible    ${title_products}
    Element Text Should Be    ${title_products}    Dashboard

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
    
Entao sera exibida a mensagem de erro "Epic sadface: Password is required"
    Log To Console    Validar mensagem de erro da senha
    Wait Until Element Is Visible    ${h3_password_required}
    ${texto_erro}    Get Text    ${h3_password_required}
    Should Be True    '${texto_erro}' == 'Epic sadface: Password is required'

Dado que realizo o login no site
    [Documentation]     Caso de Teste 235 - Login e senha validos
    [Tags]    Positivo    Login     
    Dado que abri a url no navegador
    Quando eu preencher o login e senha do user padrao
    E clicar no botao login
    Entao a tela inicial sera exibida