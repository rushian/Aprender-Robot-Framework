*** Settings ***
Library        SeleniumLibrary
*** Variables ***

*** Keywords ***
Abrir browser
    [Arguments]    ${url}    ${browser} 
	Open Browser    ${url}    ${browser}
	Maximize Browser Window
	Log To Console    \nNavegador aberto: ${browser} com a url: ${url}