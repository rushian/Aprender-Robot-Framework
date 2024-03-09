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

Dado que abri o arquivo html e li o json
    Abrir arquivo html
    Dado que eu li o json geral
   
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
    
    