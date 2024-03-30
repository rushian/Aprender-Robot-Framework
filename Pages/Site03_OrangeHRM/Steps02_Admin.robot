*** Settings ***
Documentation    Palavras chaves para o site https://www.saucedemo.com/
...     Pagina do Login
Resource    ../../Resources/base.robot
Resource    Steps01_Login.robot

*** Variables ***
# valores padrao


*** Keywords ***
# =============== CT 235 ===============
Quando eu clicar em Admin
    Click Element    //*[@id="app"]/div[1]/div[1]/aside/nav/div[2]/ul/li[1]/a/span


 E selecionar um papel do usuario
     Wait Until Element Is Visible    //*[@id="app"]/div[1]/div[1]/header/div[1]/div[1]/span/h6[2]    6
    Click Element    //*[@id="app"]/div[1]/div[2]/div[2]/div/div[1]/div[2]/form/div[1]/div/div[2]/div/div[2]/div/div/div[2]
    Sleep    2
    Click Element    //div[@role='listbox']//span[text()='Admin']