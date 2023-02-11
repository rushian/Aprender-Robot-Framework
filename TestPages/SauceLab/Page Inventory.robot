    #escolher ate 5 itens da lista aleatoriamente    
FOR    ${counter}    IN RANGE    1    ${limite_li}        
...    ${item}    Randomizar valor    1    ${contador}               
...    ${path_espec}    Catenate     SEPARATOR=     ${especializacao}     [     ${item}     ]        
...    Log To Console    ${path_espec}        
...    Click Element    ${path_espec}     CTRL    
END