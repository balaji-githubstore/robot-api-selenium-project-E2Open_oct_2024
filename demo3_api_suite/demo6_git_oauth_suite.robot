*** Settings ***
Library     RequestsLibrary
Library    SeleniumLibrary

*** Variables ***
${CLIENT_ID}        xxxxxxxxxxxxxxxxxx
${CLIENT_SECRET}    xxxxxxxxxxxxxxxxxxxxxxxxxx
${SCOPE}        repo
${REDIRECT_URI}         https://oauth.pstmn.io/v1/callback

*** Test Cases ***
TC1 Get Auth Code
    Create Session    alias=git_oauth    url=https://github.com/login/oauth
    ${response}     GET On Session      alias=git_oauth     url=authorize?client_id=${CLIENT_ID}&scope=${SCOPE}&redirect_uri=${REDIRECT_URI}
#    Log    ${response.json()}

TC2 Get Auth Code
    Create Session    alias=git_oauth    url=https://github.com/login/oauth
    &{query_params}     Create Dictionary       client_id=${CLIENT_ID}      scope=${SCOPE}
    ${response}     GET On Session      alias=git_oauth     url=authorize   params=${query_params}
    Log    ${response.url}

TC3 Get Auth Code
    Create Session    alias=git_oauth    url=https://github.com/login/oauth
    &{query_params}     Create Dictionary       client_id=${CLIENT_ID}      scope=${SCOPE}
    ${response}     GET On Session      alias=git_oauth     url=authorize   params=${query_params}
    Log    ${response.url}

#    Open Browser   browser=chrome
#    Go To    url=${response.url}
#    Sleep    15s
#    ${current_url}     Get Location
#    Log    ${current_url}
#    Sleep    5s

    #will start at 2:10 PM
