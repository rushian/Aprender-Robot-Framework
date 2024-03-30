*** Settings ***
Documentation    Suite de Testes Automatizados para login no SauceLab

Resource    ../../Pages/Site03_OrangeHRM/Steps02_Admin.robot
Resource    Suit01_Login.robot

#Test Teardown    E o navegador sera fechado

*** Test Cases ***
CT01 Filtrar usuario 
    Dado que realizo o login no site
    Quando eu clicar em Admin
    E selecionar um papel do usuario