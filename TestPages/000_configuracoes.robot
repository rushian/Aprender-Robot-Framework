*** Settings ***
Library        SeleniumLibrary
*** Variables ***
${url}    http://www.google.com
${browser}    chrome
*** Keywords ***
Abrir browser
	Open Browser    ${url}    ${browser}   
	Maximize Browser Window

Digitar termo [${termo}]
    Input Text    //*[@name='q']    ${termo}
	
Apertar tab
    Press Keys    NONE    TAB
    Log to console    First tab
    BuiltIn.Sleep    2
   