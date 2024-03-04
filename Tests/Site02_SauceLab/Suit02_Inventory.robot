*** Settings ***
Documentation    Suite de Testes Automatizados para  para realizar compra no Saucelab

Resource    ../../Pages/Site02_SauceLab/Steps02_Inventory.robot


*** Test Cases ***
CT01 Compra de 3 produtos com sucesso
    [Documentation]     Caso de Teste 374 
    [Tags]    Positivo    CompraProduto     
    Dado que estou logado
    Quando escolher 3 itens da lista aleatoriamente
    E clicar no Carrinho
    E clicar em Checkout
    E preencher minhas informacoes
    E finalizar a Compra
    Entao e exibida a mesangem "THANK YOU FOR YOUR ORDER"
    E o navegador sera fechado