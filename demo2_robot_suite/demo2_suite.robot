*** Settings ***
Library    Collections
Library    String

Suite Setup     Log To Console    Suite Setup!!
Test Setup      Log To Console    Test Setup!!
Test Teardown   Log To Console    Test Teardown!!
Suite Teardown      Log To Console    Suite Teardown!!


*** Variables ***
${BROWSER_NAME}     chrome
@{COLORS}   red     green   yellow   orange
&{EMP_DETAIL}       id=101      name=John      salary=8734.9


*** Test Cases ***
TC1
    Log To Console    ${BROWSER_NAME}

    Log To Console    ${COLORS}
    Log To Console    ${COLORS}[3]

    Log To Console    ${EMP_DETAIL}
    Log To Console    ${EMP_DETAIL}[salary]

TC2
    @{fruits}     Create List     mango   orange  grapes
    Log To Console    ${fruits}
    #append kiwi to the list
    Append To List  ${fruits}   kiwi
    Log To Console    ${fruits}
    #insert apple at index 1
    Insert Into List    ${fruits}    1    apple
    #remove mango from the list
    Remove Values From List    ${fruits}    mango
    #print the final list
    Log   ${fruits}
    ${list_count}   Get Length    ${fruits}
    Log    ${list_count}

    FOR    ${fruit}    IN    @{fruits}
        Log    ${fruit}

    END

TC3
    ${sal1}     Set Variable    $120,000
    ${sal2}     Set Variable    $120,000,000
    ${sal1}     Remove String   ${sal1}     $     ,
    ${sal2}     Remove String   ${sal2}     $     ,
    ${res}      Evaluate    ${sal1}+${sal2}
    Log To Console    ${res}
    
TC4
    Log To Console    C:\\Mine\\Company\\E2open 28 Oct 2024\\AutomationProject\\files\\add_pet.json
    Log To Console    ${EXECDIR}
    Log To Console    ${CURDIR}
    Log To Console    ${TEMPDIR}
    Log To Console    ${OUTPUT_DIR}
    Log To Console    ${TEST_NAME}
    Log To Console    ${SUITE_NAME}
    Log To Console    hello${SPACE}${SPACE}${SPACE}world
    Log To Console    ${EXECDIR}\\files\\add_pet.json
    Log To Console    ${EXECDIR}${/}files${/}add_pet.json