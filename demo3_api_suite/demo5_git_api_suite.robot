*** Settings ***
Library     RequestsLibrary

Test Setup     Create Git Session
Test Teardown      Delete All Sessions

*** Variables ***
${BASE_URL}     https://api.github.com

*** Keywords ***
Create Git Session
    Create Session    alias=github1    url=${BASE_URL}

Create Git Session With Basic Auth
    @{cred}     Create List     balaji      csdfdsffdf
    Create Session    alias=github2    url=${BASE_URL}      auth=${cred}

Create Git Session With Bearer Token
    &{headers}   Create Dictionary   Accept=application/vnd.github+json      Authorization=Bearer csdfdsffdf
    Create Session    alias=github3    url=${BASE_URL}      headers=${headers}

*** Test Cases ***
TC1 List Public Repos
    ${response}     GET On Session      alias=github1       url=repositories    expected_status=any
    Status Should Be    200
    Log    ${response.json()}

    FOR    ${item}    IN    @{response.json()}
        Log    ${item}[name]
    END

#override the test setup and teardown declared in setting level
TC2
    [Setup]     None
    Log To Console    hello
    [Teardown]  None

#TC4 List User Repo Local Session
#    [Setup]     None
#    @{cred}     Create List     balaji-githubstore      csdfdsffdf
#    Create Session    alias=github3    url=${BASE_URL}      auth=${cred}
#
#    ${response}     GET On Session      alias=github3      url=user/repos    expected_status=any
#    Status Should Be    200
#    Log    ${response.json()}
#    [Teardown]  None

TC3 List User Repo Basic Auth
    [Setup]     Create Git Session With Basic Auth
    ${response}     GET On Session      alias=github2       url=user/repos    expected_status=any
    Status Should Be    200
    Log    ${response.json()}

TC4 List User Repo Bearer Token
    [Setup]     Create Git Session With Bearer Token
    ${response}     GET On Session      alias=github3       url=user/repos    expected_status=any
    Status Should Be    200
    Log    ${response.json()}
