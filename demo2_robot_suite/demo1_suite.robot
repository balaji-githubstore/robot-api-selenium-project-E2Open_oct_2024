*** Settings ***
Library     DateTime

*** Test Cases ***
TC1
    Log To Console      message=hello world
    Log To Console    bala

TC2
    ${num1}    Set Variable    10.2
    ${num2}    Set Variable    20
    ${res}      Evaluate    ${num1}+${num2}
    Log To Console    ${res}
    Log    ${res}
    Should Be Equal As Numbers    ${res}    30

TC3
    ${current_date}     Get Current Date
    Log To Console    ${current_date}


