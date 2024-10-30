*** Settings ***
Library     RequestsLibrary

*** Test Cases ***
TC1 Find Pet By Valid Id
    Create Session    alias=petstore    url=https://petstore.swagger.io/v2/
    ${response}     GET On Session      alias=petstore      url=pet/2
    Log    ${response}
    Log    ${response.status_code}
    Log    ${response.text}
    Log    ${response.json()}
    Log    ${response.headers}

    Log    ${response.json()}[id]

    Status Should Be    200
    Should Contain    ${response.text}    "id":2
    Should Be Equal As Integers    ${response.json()}[id]    2
    #assert the name - Noya
    Should Be Equal As Strings    ${response.json()}[name]    Noya
    #assert the name under category - Pincher
    Should Be Equal As Strings    ${response.json()}[category][name]    Pincher
    Delete All Sessions