*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
TC1
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=https://www.facebook.com/
    Input Text    id=email123    hello1343434@gmail.com
    Input Password    id=pass    welcome234
    Click Element    name=login

TC2
    Open Browser    browser=headlesschrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=https://www.facebook.com/
    #click on create new account
    Click Element    link=Create new account
    #enter firstname as john
    Input Text    name=firstname    john
    #enter lastname as wick
    Input Text    name=lastname    wick
    #Click on custom radio button
    Click Element   xpath=//input[@value='-1']
    #14 Apr 2000
    Select From List By Label    id=day     14
    Select From List By Label    id=month   Apr
    Select From List By Label    id=year    2000
    Capture Page Screenshot
    Log Source
    [Teardown]      Close Browser