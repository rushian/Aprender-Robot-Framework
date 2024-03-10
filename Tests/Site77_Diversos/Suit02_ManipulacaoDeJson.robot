*** Settings ***
Documentation       Suite de Testes para aprender o uso de palavras-chaves

Resource            ../../Pages/Site77_Diversos/Steps02_ManipulacaoDeJson.robot
Test Teardown    Close Browser

*** Test Cases ***
CT01 Verificar nome do profissional
    Dado que eu li o json geral
    Quando eu ler o nome do profissional
    Entao o nome deve ser exibido no log    
    E o nome deve ser [Alana]

CT02 Preencher dados do aluno
    [Documentation]    Caso de Teste Preenchendo dados a partir da leitura do json
    [Tags]    positivo
    Dado que li o json e abri o arquivo html
    Quando eu preencher os dados do formulario com as informacoes do aluno
    E clicar em Contar inputs preenchidos
    Entao sera exibida a mensagem campos preenchidos: 4 
CT03 Nao preencher os campos
    [Documentation]    Caso de Teste sem preencher dados 
    [Tags]    negativo
    Dado que li o json e abri o arquivo html
    Quando eu nao preencher os dados do formulario
    E clicar em Contar inputs preenchidos
    Entao sera exibida a mensagem campos preenchidos: 0

CT04 Preencher dados da contador
    [Documentation]    Caso de Teste Preenchendo dados a partir da leitura do json
    [Tags]    positivo
    Dado que li o json e abri o arquivo html
    Quando eu preencher os dados da conta do usuario [usuario1]
    E clicar em Ver a mensagem
    Entao será exibida a mensagem com os dados informados

