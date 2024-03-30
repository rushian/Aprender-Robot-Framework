*** Settings ***
Documentation    Palavras chaves para a suite BancoDeDados

Resource    ../../Resources/base.robot
Library     ../../Resources/database.py
Library    string

*** Variables ***
${contato}     Teste
${cargo}       CargoTeste


*** Keywords ***

    ${headers}    Create Dictionary    accept=teste/json     Content-Type=teste/json  
############### CT 01 ################
Dado que eu esteja conectado na VPN
    [Documentation]    Testa se a conexao com a internet esta funcionando  
    ${session}    Create Session    minhaSessao    http://www.google.com.br    verify=False
    ${response}    GET On Session    minhaSessao    http://www.google.com.br
    Log To Console    Status Code da response: ${response.status_code}
    Should Be True    ${response.status_code} == 200

Quando eu informar os dados de Contato
    [Documentation]    Atencao! Email deve ser unico na tabela, o db nao vai permitir repetidos
        
    ${email}    Set Variable    padrao
    Set Suite Variable    ${contato}
    Set Suite Variable    ${email}
    Set Suite Variable    ${cargo}

E executar a query de insercao no banco de dados
    ${retorno_insert_contato}    Inserir Contato     ${contato}    ${email}    ${cargo}
    Log To Console    ${retorno_insert_contato}
Entao os dados de contato serao exibidos ao consultar
    Log to console     Inserir contatos na tabela FESTB750_CONTATO do DB
     ${retorno_listar_contatos}    Listar Contatos
     Log To Console    \nID - Nome - Email - Cargo
     
     FOR     ${contato}     IN     @{retorno_listar_contatos}
         Log To Console    ${contato[0]} - ${contato[1]} - ${contato[2]} - ${contato[3]}\n
     END


Dado que verifico a existencia da base [${base}] no diretorio [${diretorio}]
    ${base existe}    Run Keyword And Return Status    File Should Exist    ${diretorio}\\${base}
    Set Suite Variable    ${base existe}
    Set Suite Variable    ${base}
    Set Suite Variable    ${diretorio}
    Log To Console    \nBase existe: ${base existe}
Entao crio um banco de dados sqlite
    IF    ${base existe} == False
        Run    sqlite3 ${diretorio}\\${base} "create table users (id integer, nome text)"
        Log To Console    Base ${base} criada no diretorio TestData
    ELSE
        Log To Console    Base ja existe no diretorio
    END
    #Run    sqlite3 testData\\database.sqlite "create table nome (id)"
    #Execute Command  sqlite3  database.sqlite
    # Connect To Database    TestData\\database.sqlite
    # #Open Database Connection  database.sqlite
    # Execute Sql String    Create Table  users  (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)
    
    # Execute Sql String    Insert Into Table  users  (name, age) VALUES ("John Doe", 30)
    # Execute Sql String    Insert Into Table  users  (name, age) VALUES ("Jane Doe", 25)
    # Execute Sql String    Select Rows From Table  users
    # Execute Sql String    Close Database Connection