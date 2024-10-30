*** Settings ***
Library     RequestsLibrary
Library    SeleniumLibrary
Library    String

*** Variables ***
${CLIENT_ID}        xxxxx
${CLIENT_SECRET}    xxxx
${SCOPE}        repo
${REDIRECT_URI}         https://oauth.pstmn.io/v1/callback

${GIT_USERNAME}     xxxxx
${GIT_PASSWORD}     xxxx

*** Keywords ***
Get Access Token
    Create Session    alias=git_oauth    url=https://github.com/login/oauth

    &{query_params}     Create Dictionary       client_id=${CLIENT_ID}      scope=${SCOPE}
    ${response}     GET On Session      alias=git_oauth     url=authorize   params=${query_params}
    Log    ${response.url}

    #can make headlesschrome
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=${response.url}
    Input Text    id:login_field    ${GIT_USERNAME}
    Input Password    id:password    ${GIT_PASSWORD}
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
   Return From Keyword      ${response.json()}[access_token]