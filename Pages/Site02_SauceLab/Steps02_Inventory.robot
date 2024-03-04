*** Settings ***
Documentation       Palavras chaves para o site https://www.saucedemo.com/
...                 Pagina de Produtos
...    Na Key Word 'Quando escolher 3 itens da lista aleatoriamente' ha um exemplo de uso 
...    da rotina feita em python, este recurso só e possivel porque no arquivo 
...    base.robot foi importada a library criada geral.py e criada a KW 


Resource    ../../Resources/base.robot

Resource            Steps01_Login.robot


*** Variables ***
# valores padrao
${user_padrao}              standard_user
${senha}                    secret_sauce

# xpaths na ordem em que apareceram
# ===== CT 374 =====
${btn_add_to_cart}          (//button[contains(.,'Add to cart')])
${link_to_cart}             //a[contains(@class,'shopping_cart_link')]
${div_preco}                //div[contains(@class,'inventory_item_price')]
${btn_checkout}             //button[contains(@data-test,'checkout')]
${input_primeiro_nome}      //input[@data-test='firstName']
${input_ultimo_nome}        //input[@data-test='lastName']
${input_cep}                //input[@data-test='postalCode']
${input_continue}           //input[contains(@data-test,'continue')]
${btn_finish}               //button[@data-test='finish']
${titulo_agradecimento}     //h2[@class='complete-header']

*** Keywords ***
# =============== CT 374 ===============
Dado que estou logado
    Dado que abri a url no navegador
    Quando eu preencher o login e senha do user padrao
    E clicar no botao login

Quando escolher 3 itens da lista aleatoriamente
    #verificar quantos produtos sao exibidos na tela
    ${valor_maximo}    Get Element Count    //button[contains(.,'Add to cart')]
    #sortear o  primeiro valor chamando a rotina python
    ${item}    Randomizar valor    1    ${valor_maximo}
    @{lista_escolhidos}    Create List    ${item}
    ${valor_maximo}    Evaluate    ${valor_maximo}-1
    ${path}    Catenate    SEPARATOR=    ${btn_add_to_cart}    [    ${item}    ]
    Click Element    ${path}

    FOR    ${counter}    IN RANGE    0    2
        ${item}    Randomizar valor    1    ${valor_maximo}
        ${valor_maximo}    Evaluate    ${valor_maximo}-1
        Append To List    ${lista_escolhidos}    ${item}
        ${path}    Catenate    SEPARATOR=    ${btn_add_to_cart}    [    ${item}    ]
        #Log To Console    ${path}
        Click Element    ${path}
    END
    Tirar print
    Log To Console    Valores sorteados ${lista_escolhidos}
    Sleep    2s

E clicar no Carrinho
    Log to Console  Clicar no carrinho
    Click Element    ${link_to_cart}

E clicar em Checkout
    Log To Console    Comparar qtde de produtos com a qtde adicionada
    Wait Until Element Is Visible    ${div_preco}
    ${precos_de_produtos_no_carrinho}    Get Element Count    ${div_preco}
    Should Be True    ${precos_de_produtos_no_carrinho} == 3
    Click Element    ${btn_checkout}

E preencher minhas informacoes
    Log to Console  Preencher dados e clicar em continue
    Input Text    ${input_primeiro_nome}    Luke
    Input Text    ${input_ultimo_nome}    The Tester
    # na equipe definimos que quando possivel vamos usar as palavras test e um numero
    # determinado para identificar quem fez o teste facilmente, meus numericos sao com 9
    Input Text    ${input_cep}    99999-999
    Execute Javascript    window.scrollTo(0,400)
    Click Element    ${input_continue}

E finalizar a Compra
    Log to Console  Finalizar compra
    Wait Until Element Is Visible    ${btn_finish}
    Click Element    ${btn_finish}

Entao e exibida a mesangem "THANK YOU FOR YOUR ORDER"
    Log to Console  Verificar titulo de retorno
    Execute Javascript    window.scrollTo(0,0)
    Tirar print
    
    Element Should Contain    ${titulo_agradecimento}    THANK YOU FOR YOUR ORDER   None    True