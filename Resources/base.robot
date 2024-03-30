*** Settings ***
Documentation    Arquivo base com palavras chaves comuns a todos os casos
...    Aqui também ficam as importações das bibliotecas comuns, em ordem alfabetica

Library             SeleniumLibrary
Library             BuiltIn
Library             Collections
Library             DatabaseLibrary
Library             DateTime
Library             JSONLibrary
Library             OperatingSystem
Library             RequestsLibrary
Library             String
Library             geral.py

*** Variables ***
${PATH_DO_CHROMEDRIVER}    E:\\qa\\venv\\Scripts\\chromedriver.exe
${navegador}    chrome
*** Keywords ***
Abrir browser
    [Documentation]    Abre o navegador escolhido com a url fornecida
    [Arguments]    ${url}    ${navegador}
    IF    '${navegador}' == 'chrome'
        Open Browser    ${url}    ${navegador}     options=add_experimental_option("detach",True);add_argument("--disable-extensions-except");add_argument("--disable-web-security");add_argument("--ignore-certificate-errors");add_argument("--allow-insecure-localhost");add_argument("--allow-cross-origin-auth-prompt");add_argument('--log-level=3')     executable_path=${PATH_DO_CHROMEDRIVER}
         #Open Browser    ${url}    ${navegador}    options=add_argument("--headless=chrome");add_experimental_option("detach",True);add_argument("--disable-extensions-except");add_argument("--disable-web-security");add_argument("--ignore-certificate-errors");add_argument("--allow-insecure-localhost");add_argument("--allow-cross-origin-auth-prompt");add_argument('--log-level=3')    executable_path=${PATH_DO_CHROMEDRIVER}
    END
    IF    '${navegador}' == 'firefox'
        Open Browser
        ...    file:${EXECDIR}/Resources/teste.html
        ...    ${navegador}
        ...    options=add_argument("--disable-extensions-except");add_argument("--disable-web-security");add_argument("--ignore-certificate-errors");add_argument("--allow-insecure-localhost");add_argument("--allow-cross-origin-auth-prompt");add_argument('--log-level=3')
    END
    
    Maximize Browser Window
    Log To Console    \nNavegador aberto: ${navegador} com a url: ${url}

Abrir arquivo html [${path}]
    IF    '${navegador}' == 'chrome'
        Open Browser
        ...    file:${path}
        ...    ${navegador}
        ...    options=add_experimental_option("detach",True);add_argument("--disable-extensions-except");add_argument("--disable-web-security");add_argument("--ignore-certificate-errors");add_argument("--allow-insecure-localhost");add_argument("--allow-cross-origin-auth-prompt");add_argument('--log-level=3')
        ...    executable_path=${PATH_DO_CHROMEDRIVER}

        # Open Browser    file:${EXECDIR}/TestData/teste.html    ${navegador}
        # ...    options=add_argument("--headless=chrome");add_argument("--disable-extensions-except");add_argument("--disable-web-security");add_argument("--ignore-certificate-errors");add_argument("--allow-insecure-localhost");add_argument("--allow-cross-origin-auth-prompt");add_argument('--log-level=3')    executable_path=${PATH_DO_CHROMEDRIVER}
    END
    IF    '${navegador}' == 'firefox'
        Open Browser
        ...    file:${path}
        ...    ${navegador}
        ...    options=add_argument("--disable-extensions-except");add_argument("--disable-web-security");add_argument("--ignore-certificate-errors");add_argument("--allow-insecure-localhost");add_argument("--allow-cross-origin-auth-prompt");add_argument('--log-level=3')
    END
    Maximize Browser Window
Ler Arquivo Json
    [Arguments]    ${LocalArquivoJson}
    ${ArquivoJson}    Load Json From File    ${LocalArquivoJson}    UTF-8
    Log To Console    \nArquivo utilizado: ${LocalArquivoJson}
    RETURN    ${ArquivoJson}
Ler Arquivo Json [${localDoArquivo}] 
    ${ArquivoJson}    Load Json From File    ${localDoArquivo}    UTF-8
    Log To Console    \nArquivo utilizado: ${localDoArquivo}
    RETURN    ${ArquivoJson}
	
Printar tela inteira
    ${data_atual}    Get Current Date    result_format=%d-%m-%Y
    Set Suite Variable    ${titulo}    ${TEST NAME}
    Create Directory    Evidencias\\${data_atual}\\${titulo}
    ${diretorio}    Set Variable    Evidencias\\\\${data_atual}\\\\${titulo}\\\\
    Set Screenshot Directory    ${diretorio}
    ${hora atual}    Get Current Date    result_format=%H-%M-%S-%f
    ${nome_arquivo}    Catenate    SEPARATOR=    scrshot-    ${hora atual}    .png
    # Log To Console    \nDiretorio: ${diretorio}\nArquivo: ${nome_arquivo}
    ${ResultadoPrint}    Captura Tela    ${diretorio}    ${nome_arquivo}
    Log To Console    ${ResultadoPrint}

Tirar print
    ${data_atual}    Get Current Date    result_format=%d-%m-%Y
    Set Suite Variable    ${titulo}    ${TEST NAME}

    #### TRECHO PARA ADICIONAR A SEGUNDA TAG DO CASO DE TESTE NO PATH DO DIRETORIO DE EVIDENCIAS
    ${tamanho_lista_tags}    Get Length    ${TEST TAGS}
    ${tags}    Set Variable    ${TEST TAGS}
    Set Global Variable    ${tags}
    Set Global Variable    ${tamanho_lista_tags}

    IF    ${tamanho_lista_tags} >= 2
        Log To Console    Suite: ${TEST TAGS[1]}
        Create Directory    Evidencias\\${data_atual}\\${TEST TAGS[1]}\\${titulo}
        Set Screenshot Directory    Evidencias\\${data_atual}\\${TEST TAGS[1]}\\${titulo}
    ELSE
        #### Caso nao esteja definida a tag com nome da suite na segunda posicao, ele nao cria a pasta da funcionalidade
        Create Directory    Evidencias\\${data_atual}\\${titulo}
        Set Screenshot Directory    Evidencias\\${data_atual}\\${titulo}
    END
Randomizar valor
	[Documentation]    Passe o valor minimo e maximo, a rotina vai sortear um valor no intervalo
	[Arguments]     ${minimo}    ${maximo}
	${opcao_de_renegociacao}      Randomize Value       ${minimo}        ${maximo}
  RETURN    ${opcao_de_renegociacao}

E o navegador sera fechado
    Log To Console    Encerrando navegador 
    Close Browser