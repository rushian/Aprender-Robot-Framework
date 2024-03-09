*** Settings ***
Documentation       Palavras chaves para a suite Learn

Resource            ../../Resources/base.robot
Library    Telnet

*** Variables ***
${url}          http://www.google.com
${navegador}    chrome
 

*** Keywords ***
############### CT 01 ################
Dado que o python esteja instalado
    ${retorno}    Verificar Ambiente
    Set Suite Variable    ${retorno}

Dado que MERGE VAI DA ERRO
    Press Keys    NONE    TAB    TAB    SPACE

Entao posso consultar a versao instalada
    Log To Console    \nVersao do Python: ${retorno[0]}, Sistema: ${retorno[1]}, Maquina: ${retorno[2]}

############### CT 02 ################

Realizar conversao do xlsx (${caminho_xls}) para o json (${caminho_json})
    [Documentation]    Keyword para chamar a rotina python
    ...    Informe o caminho do xls de entrada e do json de saida nos respectivos parenteses
    Converter Xls Para Json    ${caminho_xls}    ${caminho_json}

############### CT 03 ################

Converter xlsx com subnivel para o json
    [Documentation]    Keyword para chamar a rotina python
    ...    Informe o caminho do xls de entrada e do json de saida como argumentos
    [Arguments]    ${caminho_xls}    ${caminho_json}
    Converter Xlsx Com Subnivel Para Json    ${caminho_xls}    ${caminho_json}

############### CT 04 ################

Iterar indices de um json
    [Arguments]    ${LocalArquivoJson}
    ${ArquivoJson}    Ler Arquivo Json    ${LocalArquivoJson}
    FOR    ${item}    IN    @{ArquivoJson}
        Log To Console    Indice: ${item['indice']} Cidade: ${item['cidade']} - ${item['uf']}
        Log To Console    ${ArquivoJson.index(${item})}
    END

Buscar dados de um paciente (indice: ${indice})
    ${LocalArquivoJson}    Set Variable    TestData\\massa_pacientes_04-07-2023_01-30.json
    ${ArquivoJson}    Ler Arquivo Json    ${LocalArquivoJson}

    ${jsonNome}    Get Value From Json    ${ArquivoJson}    $.paciente.[${indice}].dados_pessoais.nome
    ${jsonIdade}    Get Value From Json    ${ArquivoJson}    $.paciente.[${indice}].dados_pessoais.idade
    ${jsonDataConsulta}    Get Value From Json    ${ArquivoJson}    $.paciente.[${indice}].dados_clinicos.data_consulta
    ${jsonMedico}    Get Value From Json    ${ArquivoJson}    $.paciente.[${indice}].dados_clinicos.medico
    ${jsonReceituario}    Get Value From Json    ${ArquivoJson}    $.paciente.[${indice}].dados_clinicos.receituario

    Log To Console    \nPaciente: ${jsonNome}[0]\nIdade: ${jsonIdade}[0]\nData da consulta: ${jsonDataConsulta}[0]
    Log To Console    Médico: ${jsonMedico}[0]\nReceituario: ${jsonReceituario}[0]

Buscar dados de todos pacientes
    ${LocalArquivoJson}    Set Variable    TestData\\massa_pacientes_04-07-2023_01-30.json
    ${ArquivoJson}    Ler Arquivo Json    ${LocalArquivoJson}
    FOR    ${item}    IN    @{ArquivoJson['paciente']}
        ${jsonNome}    Get Value From Json    ${item}    $.dados_pessoais.nome
        ${jsonIdade}    Get Value From Json    ${item}    $.dados_pessoais.idade
        ${jsonDataConsulta}    Get Value From Json    ${item}    $.dados_clinicos.data_consulta
        ${jsonMedico}    Get Value From Json    ${item}    $.dados_clinicos.medico
        ${jsonReceituario}    Get Value From Json    ${item}    $.dados_clinicos.receituario

        Log To Console
        ...    \nIndice: ${item}\nPaciente: ${jsonNome}[0] \nIdade: ${jsonIdade}[0]\nData da consulta: ${jsonDataConsulta}[0]
        Log To Console    Médico: ${jsonMedico}[0]\nReceituario: ${jsonReceituario}[0]
    END

Dado que abri o arquivo
    Abrir arquivo html

Leio html
    ${file_content}    Get File    C:\\Users\\f675422\\Downloads\\RelatorioCertidaoNegativa (11).xls
    ${tag}    Set Variable    <tr>
    ${contador}    Get Count    ${file_content}    ${tag}

    Log To Console    Quantidade de linhas no xls: ${contador}

    Should Be True    ${contador} > 0

Leio option
    Select Radio Button    amortizacao    p

    # Click Element    //input[2]
    ${radio_opcoes}    Get WebElements    //input[contains(@name,'amortizacao')]
    FOR    ${opcao}    IN    @{radio_opcoes}
        IF    ${opcao.is_selected()} == True
            ${radio_selecionado}    Set Variable    ${opcao.get_attribute("value")}
        END
    END

    Log To Console    \namortizacao em ${radio_selecionado}

    Close Browser

Altero o check da tr de uma tabela especifica
    [Documentation]    Esse caso serve para reagir diferente de acordo com a classe encontrada na TR
    ...    No desafio original a classe é alterada quando salva uma mudança no checkbox
    ${TR1}    Get WebElement    //table[thead/tr/th[contains(.,'Ação')]]/tbody/tr[1]
    ${CLASSE}    Get Element Attribute    ${TR1}    class

    Log To Console    \nClasse: ${CLASSE}

    # Verificar classe
    IF    '${CLASSE}' == 'inativo'
        Log To Console    INATIVO ENCONTRADO

        Click Element    css=[class*='inativo'] input[type*='checkbox']
        Click Element    css=tr:nth-child(1) input[type*='text']
        Press Keys    NONE    CTRL+a    BACKSPACE    TesteA
    ELSE
        Click Element    css=tr:nth-child(3) input[type*='text']
        Press Keys    NONE    CTRL+a    BACKSPACE    TesteB
    END

Aperto as teclas no campo indicado
    Press Keys
    ...    //*[@id="campo-com-valor"]
    ...    ARROW_LEFT
    ...    A
    ...    ARROW_LEFT
    ...    ARROW_LEFT
    ...    ARROW_LEFT
    ...    B
    ...    ARROW_RIGHT
    Sleep    2
    Press Keys    //*[@id="campo-com-valor"]    HOME

Gerar substring
    ${start}    Get Substring    //*[@id="campo-com-valor"]    id="
    Log To Console    ${start}
    ${id}    Get Substring    //*[@id="campo-com-valor"]    ${start}
    Log To Console    ${id}

Clique por id
    [Arguments]    ${elemento}
    Get Index From List    list_    value
    ${id}    Get Substring    ${elemento}    start

E imprimo a tela
    Run Keyword And Ignore Error
    ...    Execute Javascript
    ...    document.evaluate(".//button[span[contains(.,'Imprimir contrato')]]", document.body, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();

    Switch Window    MAIN

    Execute Javascript    alert('aa')
    Log To Console    passsou pra nova

    # Execute Javascript    window.focus()
    Press Keys    None    TAB+SPACE

Entao cancelo a impressao
    Click Button    Close

Escrever no arquivo
    ${Text}    Catenate    SEPARATOR=    Text1    \n    Text2    \n
    ${Value}    set variable    Text4
    createFile    ${EXECDIR}/File.txt    ${Text}
    Append To File    ${EXECDIR}/File.txt    ${Value}

Entao os status estarao na lista
    Click Element    //label[contains(@id,'path_status_label')]
    Mouse Over    (//*[@id="path_status_panel"]/div/ul/li)[2]
    @{idELEMENT}    Get WebElements    //*[@id="path_status_panel"]/div/ul/li
    @{ELEMENT}    Create List    primeiroItem

    FOR    ${element}    IN    @{idELEMENT}
        ${text}    Get Text    ${element}
        Append To List    ${ELEMENT}    ${text}
    END

    Should Contain Match    ${ELEMENT}    Em andamento

    Should Contain Match    ${ELEMENT}    Avaliado
    Should Contain Match    ${ELEMENT}    Em transicao
    Should Contain Match    ${ELEMENT}    Aguardando evidencias
    Should Contain Match    ${ELEMENT}    Finalizado
    Should Contain Match    ${ELEMENT}    Cancelado
    Should Contain Match    ${ELEMENT}    Apresentacao pendente
    Should Contain Match    ${ELEMENT}    Iniciado

Quando encontro a caixa marcada, eu clico
    ${check_opcoes}    Get WebElements    //input[contains(@type,'checkbox')]
    FOR    ${opcao}    IN    @{check_opcoes}
        ${indice}    Get Index From List    ${check_opcoes}    ${opcao}
        Log To Console    \nindice: ${indice}
        Log To Console    Value: ${opcao.get_attribute("value")}
        Log To Console    Checked: ${opcao.get_attribute("checked")}
        Log To Console    Disabled: ${opcao.get_attribute("disabled")}
        Log To Console    Selecionado: ${opcao.is_selected()}
        Log To Console    texto: ${opcao.text}
        Log To Console    innerHtml: ${opcao.get_attribute("innerHTML")}
    END

Quando eu altero alguma linha
    Press Keys

Quando eu limpo o campo
    Sleep    1
    Clear Element Text    //*[@id="campo-com-valor"]
    Sleep    1
    Input Text    //*[@id="campo-com-valor"]    texto exemplo
    Sleep    1
    Press Keys    None    CTRL+A
    Tirar print
    Sleep    1
    Press Keys    None    DELETE

Quando copio o valor e colo tirando espacos
    Sleep    1
    ${NOME}    Get WebElement    //*[@id="campo-com-valor"]
    Sleep    1
    Log To Console
    ...    nome sem espaco: ${NOME.get_attribute("value").strip()} nome com espaco: ${NOME.get_attribute("value")}
    Input Text    //*[@id="campo-com-valor"]    ${NOME.get_attribute("value").strip()}

Quando leio um payload posso manipular seus valores
    ${texto_payload}    Get Text    //*[@id="payload"]
    ${conteudo_json}    Convert String To Json    ${texto_payload}
    FOR    ${item}    IN    @{conteudo_json['paciente']}
        ${jsonNome}    Get Value From Json    ${item}    $.dados_pessoais.nome
        ${jsonIdade}    Get Value From Json    ${item}    $.dados_pessoais.idade
        ${jsonDataConsulta}    Get Value From Json    ${item}    $.dados_clinicos.data_consulta
        ${jsonMedico}    Get Value From Json    ${item}    $.dados_clinicos.medico
        ${jsonReceituario}    Get Value From Json    ${item}    $.dados_clinicos.receituario

        Log To Console
        ...    \nIndice: ${item}\nPaciente: ${jsonNome}[0] \nIdade: ${jsonIdade}[0]\nData da consulta: ${jsonDataConsulta}[0]
        Log To Console    Médico: ${jsonMedico}[0]\nReceituario: ${jsonReceituario}[0]
    END

Quando leio um docx
    # Pegar diretorio do usuario
    ${user_home}    Get Environment Variable    UserProfile
    ${diretorio}    Set Variable    ${user_home}\\Downloads\\
    Log To Console    \nDiretorio de download: ${diretorio}

    # pegar lista de arquivos no diretorio
    @{arquivos}    List Files In Directory    ${diretorio}    *.docx

    # usar o primeiro arquivo da lista para inicializar a variavel
    ${arquivoMaisRecente}    Get From List    ${arquivos}    0
    Log To Console    Primeiro docx da lista: ${arquivoMaisRecente}
    # guardar caminho do arquivo completo para pegar a data de modificacao
    ${arquivoRecenteComPath}    Catenate    SEPARATOR=    ${diretorio}    ${arquivoMaisRecente}

    # pegar data de alteracao do primeiro arquivo
    ${inicialAlteradoEm}    Get Modified Time    ${arquivoRecenteComPath}    epoch

    ${primeiroArquivo}    Convert Date    ${inicialAlteradoEm}    result_format=%d.%m.%Y %H:%M
    Log To Console    Data de alteracao do primeiro docx: ${primeiroArquivo}

    # verificar se algum arquivo e mais recente que o primeiro
    FOR    ${arquivo}    IN    @{arquivos}
        # Log To Console    Arquivo: ${arquivo}
        ${arquivoComPath}    Catenate    SEPARATOR=    ${diretorio}    ${arquivo}
        ${alteradoEm}    Get Modified Time    ${arquivoComPath}    epoch
        # Log To Console    Alterado em: ${alteradoEm}
        ${arquivoMaisRecente}    Set Variable If
        ...    ${alteradoEm} > ${inicialAlteradoEm}
        ...    ${arquivo}
        ...    ${arquivoMaisRecente}
        ${inicialAlteradoEm}    Set Variable If
        ...    ${alteradoEm} > ${inicialAlteradoEm}
        ...    ${alteradoEm}
        ...    ${inicialAlteradoEm}
    END
    # armazenar nome e caminho do xls mais recente na pasta
    ${docx_baixado}    Catenate    SEPARATOR=    ${diretorio}    ${arquivoMaisRecente}

    # Log To Console    Ultimo Arquivo Alterado: ${ultimoArquivoAlterado}
    Log To Console    Arquivo mais recente: ${arquivoMaisRecente}
    ${inicialAlteradoEm}    Convert Date    ${inicialAlteradoEm}    result_format=%d.%m.%Y %H:%M
    Log To Console    Data ultima alteracao: ${inicialAlteradoEm}

    # devido a extensao do arquivo baixado ser xls, nao e possivel utilizar a library excel
    # assim a leitura da planilha e feita pela rotina em python no arquivo geral.py
    ${texto_docx}    Ler Docx    ${docx_baixado}

    ${resultados}    Get Regexp Matches    ${texto_docx}    RG:(.*?)[\n\r]    1

    ${quantidade_resultados}    Get Length    ${resultados}

    Log To Console    primeira ocorrencia: ${resultados}[0]
    Log To Console    todas ocorrencias: ${resultados}
    Log To Console    quantidade de resultados: ${quantidade_resultados}

    Should Match Regexp    ${texto_docx}    RG:(.*?)[\n\r]

Quando leio um xls
    # Pegar diretorio do usuario
    ${user_home}    Get Environment Variable    UserProfile
    ${diretorio}    Set Variable    ${user_home}\\Downloads\\
    Log To Console    \nDiretorio de download: ${diretorio}

    # pegar lista de arquivos no diretorio
    @{arquivos}    List Files In Directory    ${diretorio}    *.xls

    # usar o primeiro arquivo da lista para inicializar a variavel
    ${arquivoMaisRecente}    Get From List    ${arquivos}    0
    Log To Console    Primeiro xls da lista: ${arquivoMaisRecente}
    # guardar caminho do arquivo completo para pegar a data de modificacao
    ${arquivoRecenteComPath}    Catenate    SEPARATOR=    ${diretorio}    ${arquivoMaisRecente}

    # pegar data de alteracao do primeiro arquivo
    ${inicialAlteradoEm}    Get Modified Time    ${arquivoRecenteComPath}    epoch

    ${primeiroArquivo}    Convert Date    ${inicialAlteradoEm}    result_format=%d.%m.%Y %H:%M
    Log To Console    Data de alteracao do primeiro xls: ${primeiroArquivo}

    # verificar se algum arquivo e mais recente que o primeiro
    FOR    ${arquivo}    IN    @{arquivos}
        # Log To Console    Arquivo: ${arquivo}
        ${arquivoComPath}    Catenate    SEPARATOR=    ${diretorio}    ${arquivo}
        ${alteradoEm}    Get Modified Time    ${arquivoComPath}    epoch
        # Log To Console    Alterado em: ${alteradoEm}
        ${arquivoMaisRecente}    Set Variable If
        ...    ${alteradoEm} > ${inicialAlteradoEm}
        ...    ${arquivo}
        ...    ${arquivoMaisRecente}
        ${inicialAlteradoEm}    Set Variable If
        ...    ${alteradoEm} > ${inicialAlteradoEm}
        ...    ${alteradoEm}
        ...    ${inicialAlteradoEm}
    END
    # armazenar nome e caminho do xls mais recente na pasta
    ${xls_baixado}    Catenate    SEPARATOR=    ${diretorio}    ${arquivoMaisRecente}

    # Log To Console    Ultimo Arquivo Alterado: ${ultimoArquivoAlterado}
    Log To Console    Arquivo mais recente: ${arquivoMaisRecente}
    ${inicialAlteradoEm}    Convert Date    ${inicialAlteradoEm}    result_format=%d.%m.%Y %H:%M
    Log To Console    Data ultima alteracao: ${inicialAlteradoEm}

    # devido a extensao do arquivo baixado ser xls, nao e possivel utilizar a library excel
    # assim a leitura da planilha e feita pela rotina em python no arquivo geral.py
    ${qtde_linhas_no_xls}    Ler Qtde Linhas Na Planilha    ${xls_baixado}    Sheet0

    Log To Console    quantidade de linhas no xls: ${qtde_linhas_no_xls}

    Should Be True    ${qtde_linhas_no_xls} >= 3

Create order
    ${item}=    Create Dictionary
        ...    name=Produto XPTO
        ...    price=50.20
        ...    quantity=1
    ${items}=    Create List    ${item}

    &{body}    Create Dictionary    
    Set To Dictionary    ${body}    item     ${items}
    ${stri}    Convert To String    ${body}
    ${stri}     Replace String    ${stri}    '    "
    Log To Console    string: ${stri}


    # ${json_string}      Convert String To Json    ${stri}
    
    # Log To Console    ${items}
    # Log To Console    ${body}
    # Log To Console    ${json_string}
