*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
TC1
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=https://www.db4free.net
    Click Element    xpath=//b[contains(text(),'phpMyAdmin')]
    #switch to 2nd tab
    Switch Window   phpMyAdmin
    Input Text    id=input_username    bala
    Sleep    2s
    Close Window
    #switch to 1st tab
    Switch Window   db4free.net - MySQL Database for free
    Close Browser

TC2
    Open Browser    browser=chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    20s
    Go To    url=https://netbanking.hdfcbank.com/netbanking/IpinResetUsingOTP.htm
    Click Element    xpath=//img[@alt='Go']
    ${actual_alert_text}    Handle Alert    action=ACCEPT      timeout=30s
    Should Be Equal As Strings    ${actual_alert_text}    Customer ID${SPACE}${SPACE}cannot be left blank.