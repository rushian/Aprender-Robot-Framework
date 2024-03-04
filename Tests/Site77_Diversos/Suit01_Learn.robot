*** Settings ***
Documentation       Suite de Testes para aprender o uso de palavras-chaves

Resource            ../../Pages/Site77_Diversos/Steps01_Learn.robot
# Test Teardown    Close Browser


*** Test Cases ***
CT01 Verificar ambiente python
    [Documentation]    Caso de Teste no RQM 52358
    [Tags]    ct01
    Dado que o python esteja instalado
    Entao posso consultar a versao instalada

CT02 Converter xlsx em json
    [Documentation]    Caso de Teste no RQM 52359
    [Tags]    ct02    argumentos na keyword
    Realizar conversao do xlsx (TestData\\massa_simples.xlsx) para o json (TestData\\massa_simples.json)

CT03 Converter xlsx com subnivel em json
    [Documentation]    Caso de Teste no RQM 52365
    [Tags]    ct03    argumentos na chamada
    Converter xlsx com subnivel para o json    TestData\\massa_pacientes.xlsx    TestData\\massa_simples.json

CT04 Iterar json simples
    [Documentation]    Caso de Teste no RQM 52378
    [Tags]    ct04
    Iterar indices de um json    TestData\\cidades.json

CT05 Buscar dados de um json
    [Documentation]    Caso de Teste no RQM 52379
    [Tags]    ct05
    Buscar dados de um paciente (indice: 1)

CT06 Iterar json encadeado
    [Documentation]    Caso de Teste no RQM 52401
    [Tags]    ct06
    Buscar dados de todos pacientes

CT07 Printar tela
    [Documentation]    Caso de Teste no RQM 52425
    [Tags]    ct07
    Printar tela inteira

CT08 Ler option
    Dado que abri o arquivo
    Leio option

CT09 Ler linha de tabela
    Dado que abri o arquivo
    Altero o check da tr de uma tabela especifica

CT10 Voltar o cursor no campo
    Dado que abri o arquivo
    Aperto as teclas no campo indicado

CT11 Gerar substring
    Dado que abri o arquivo
    Gerar substring

CT12 Imprimir e cancelar
    Dado que abri o arquivo
    E imprimo a tela
    Entao cancelo a impressao

CT13 Clicar por atributo
    Dado que abri o arquivo
    Quando encontro a caixa marcada, eu clico

CT14 Enviar pra Git
    Dado que abri o arquivo
    Quando eu altero alguma linha

CT15 Limpar campo
    Dado que abri o arquivo
    Quando eu limpo o campo

CT16 Remover espaco de var
    Dado que abri o arquivo
    Quando copio o valor e colo tirando espacos

CT17 Manipular valores de um json pego em textarea
    Dado que abri o arquivo
    Quando leio um payload posso manipular seus valores

CT18 ler docx e verificar dados
    Quando leio um docx

CT19 ler xls e verificar quantidade de linhas
    Quando leio um xls

CT20 Listar itens
    Create order
