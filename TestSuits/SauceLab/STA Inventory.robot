*** Settings ***
Documentation    Suite de Testes Automatizados para Pesquisar no google
Resource     ../../Resources/base.robot

*** Test Cases ***
Compra produtos
    [Documentation]     Caso de Teste 374 
    ...    ID: 1 Tipo do CT: Positivo 
    Dado que estou logado
    Quando escolher 3 itens da lista aleatoriamente
    E clicar no Carrinho
    E clicar em Checkout
    E preencher minhas informacoes
    E finalizar a Compra
    Entao e exibida a mesangem "THANK YOU FOR YOUR ORDER"