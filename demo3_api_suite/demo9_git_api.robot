*** Settings ***
Library     RequestsLibrary
Library    OperatingSystem

Resource    demo8_keywords.resource

*** Variables ***
${BASE_URL}     https://api.github.com

*** Keywords ***
Create Git Session With Oauth Token
    ${access_token}     Get Access Token
    &{headers}   Create Dictionary   Accept=application/vnd.github+json      Authorization=Bearer ${access_token}
    Create Session    alias=github3    url=${BASE_URL}      headers=${headers}

*** Test Cases ***
TC4 List User Repo Bearer Token
    [Setup]     Create Git Session With Oauth Token
    ${response}     GET On Session      alias=github3       url=user/repos    expected_status=any
    Status Should Be    200
    Log    ${response.json()}

TC5
    ${pem}      Get Binary File     ${EXECDIR}${/}temp.pem
    @{cert}     Create List     client certificate      ${pem}
    Create Client Cert Session    alias=gitcert    url=https://api.github.com   client_certs=${cert}