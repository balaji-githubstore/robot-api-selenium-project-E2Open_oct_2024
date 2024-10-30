*** Settings ***
Library     RequestsLibrary
Library    SeleniumLibrary
Library    String

*** Variables ***
${CLIENT_ID}        xxxxxxxxxxxxxxxx
${CLIENT_SECRET}    xxxxxxxxxxxxxxxx
${SCOPE}        repo
#${REDIRECT_URI}         https://oauth.pstmn.io/v1/callback

*** Test Cases ***
TC3 Get Auth Code
    Create Session    alias=git_oauth    url=https://github.com/login/oauth

    &{query_params}     Create Dictionary       client_id=${CLIENT_ID}      scope=${SCOPE}
    ${response}     GET On Session      alias=git_oauth     url=authorize   params=${query_params}
    Log    ${response.url}
    
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=${response.url}
    Input Text    id:login_field    balaj
#    Input Password    id:password    xxxxxxx
    Sleep    8s
    Click Element    xpath=//input[@value='Sign in']
    Wait Until Location Contains    code
    ${current_url}      Get Location 
    Log    ${current_url}
    ${output}    Fetch From Right    ${current_url}      code=
    Log    ${output}


   &{payload}   Create Dictionary   client_id=${CLIENT_ID}      client_secret=${CLIENT_SECRET}      code=${output}
   &{headers}   Create Dictionary   Accept=application/json
   ${response}     POST On Session  alias=git_oauth     url=access_token    data=${payload}     headers=${headers}
   Log    ${response.json()}
   Log    ${response.json()}[access_token]
