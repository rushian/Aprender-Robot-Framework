*** Settings ***
Library        DateTime
Library        OperatingSystem
Library        SeleniumLibrary
Library 		../Resources/geral.py


*** Keywords ***
Abrir browser
	[Documentation]		Abre o navegador escolhido com a url fornecida
    [Arguments]    ${url}    ${browser} 	
	Open Browser    ${url}    ${browser}
	Maximize Browser Window
	Log To Console    \nNavegador aberto: ${browser} com a url: ${url}

Printar tela inteira
	${data_atual}=          Get Current Date           result_format=%d-%m-%Y    
	Set Suite Variable      ${titulo}          ${TEST NAME}    
	Create Directory        Evidencias\\${data_atual}\\${titulo}    
	${diretorio}            Set Variable        ${EXECDIR}\\Evidencias\\${data_atual}\\${titulo}\\       
	${nome_arquivo}=        Get Current Date             result_format=%H-%M-%S-%f
	Log To Console    Arquivo: ${nome_arquivo} Diretorio: ${diretorio}
	${ResultadoPrint}=      Captura Tela    	${diretorio}    robot-scrshot-${nome_arquivo}.png    
	Log To Console          ${ResultadoPrint}

Randomizar valor
	[Documentation]    Passe o valor minimo e maximo, a rotina vai sortear um valor no intervalo
	[Arguments]     ${minimo}    ${maximo}
	${opcao_de_renegociacao}=      Randomize Value       ${minimo}        ${maximo}
    [Return]        ${opcao_de_renegociacao}

