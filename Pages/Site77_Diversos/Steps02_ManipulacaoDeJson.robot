*** Settings ***
Documentation       Palavras chaves para a suite Learn

Resource            ../../Resources/base.robot


*** Variables ***
${url}          http://www.google.com
${navegador}    chrome
 

*** Keywords ***
Dado que eu li o json geral
    ${conteudoJson}    Ler Arquivo Json [TestData\\geral.json]
    Set Suite Variable    ${conteudoJson}
Quando eu ler o nome do profissional
    ${nome_profissional}    Get Value From Json    ${conteudoJson}    $.usuarios.profissional.nome
    Set Suite Variable    ${nome_profissional}
Entao o nome deve ser exibido no log
    Log To Console    nome do(a) profissional: ${nome_profissional}[0]
E o nome deve ser [${nome}]
    Should Be Equal    ${nome_profissional}[0]    ${nome}

Dado que li o json e abri o arquivo html
    Dado que eu li o json geral
    ${arquivo}    Get Value From Json    ${conteudoJson}    $.urls.local
    ${path}    Catenate     SEPARATOR=    ${EXECDIR}    ${arquivo}[0]
    #Abrir arquivo html [${path}]
   
Quando eu preencher os dados do formulario com as informacoes do aluno
    ${nome}        Get Value From Json    ${conteudoJson}    $.usuarios.aluno.nome
    ${endereco}    Get Value From Json    ${conteudoJson}    $.usuarios.aluno.endereco
    ${telefone}    Get Value From Json    ${conteudoJson}    $.usuarios.aluno.telefone
    ${email}       Get Value From Json    ${conteudoJson}    $.usuarios.aluno.email
    Input Text    name    ${nome}[0]
    Input Text    address    ${endereco}[0]
    Input Text    phone    ${telefone}[0]
    Input Text    email    ${email}[0]

Quando eu nao preencher os dados do formulario
    Log    Nenhum dado preenchido
    Log To Console    Nenhum dado preenchido

E clicar em Contar inputs preenchidos
    Click Button    contador
    Sleep    3
Entao sera exibida a mensagem ${msg}
    Alert Should Be Present        ${msg}

Quando eu preencher os dados da conta do usuario [${usuario}]
    Input Text    usuario    ${usuario}
    ${banco}        Get Value From Json    ${conteudoJson}    massa.validar-conta.${usuario}.banco
    Input Text    banco    ${banco}[0]
    ${agencia}      Get Value From Json     ${conteudoJson}   $.massa.validar-conta.${usuario}.agencia
    Input Text    agencia    ${agencia}[0]
    ${conta}        Get Value From Json    ${conteudoJson}    $.massa.validar-conta.${usuario}.conta
    Input Text    conta    ${conta}[0]
    ${digito}       Get Value From Json    ${conteudoJson}    $.massa.validar-conta.${usuario}.digito
    Input Text    digito    ${digito}[0]
    ${saldo}        Get Value From Json    ${conteudoJson}    $.massa.validar-conta.${usuario}.saldo
    Input Text    saldo    ${saldo}[0]

    Set Suite Variable    ${banco}
    Set Suite Variable    ${agencia}
    Set Suite Variable    ${conta}
    Set Suite Variable    ${digito}
    Set Suite Variable    ${saldo}
    Sleep    2
    
E clicar em Ver a mensagem
    Click Button    mostraMsg
Entao será exibida a mensagem com os dados informados
    Element Should Contain    mensagem    ${banco}[0]
    Element Should Contain    mensagem    ${agencia}[0]
    Element Should Contain    mensagem    ${conta}[0]
    Element Should Contain    mensagem    ${digito}[0]
    Sleep    2


Quando iterar os usuarios
    ${massa}    Get Dictionary Values    ${conteudoJson}    $.massa
    ${caso_de_teste}    Get Dictionary Values    ${massa}[0]    $.validar-conta
    ${users}    Get Dictionary Keys    ${casoDeTeste}[0]    sort_keys=False
    ${qtde_users}    Get Length   ${users}   
    Log To Console   ${users}
    Log To Console   ${users}[2]

    Log To Console   ${qtde_users}
            ${user}    Get Value From Json    ${conteudoJson}    $.massa.validar-conta.${users}[2]
        Log To Console   ${user}
    # FOR    ${i}    IN RANGE    0    ${qtde_users}-1
    #     ${user}    Get Value From Json    ${conteudoJson}    $.massa.validar-conta.${users}[${i}]
    #     Log To Console   ${user}
        
    # END
Entao as contas de cada usuario serao verificadas
    No Operation
    