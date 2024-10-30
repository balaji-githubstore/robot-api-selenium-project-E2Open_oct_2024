*** Settings ***

*** Keywords ***
Add Two Numbers
    [Arguments]     ${num1}     ${num2}
    ${res}      Evaluate    ${num1}+${num2}
#    Return From Keyword     ${res}
    [Return]    ${res}

Multiply Two Numbers
    [Arguments]     ${num1}     ${num2}
    ${res}      Evaluate    ${num1}*${num2}
    Return From Keyword     ${res}

*** Test Cases ***
TC1
    ${output}   Add Two Numbers    2    2
    Log To Console    ${output}

    ${output}   Multiply Two Numbers    2    2
    Log To Console    ${output}