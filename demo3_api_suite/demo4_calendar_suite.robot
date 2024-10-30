*** Settings ***
Library     RequestsLibrary
Library    OperatingSystem

Suite Setup     Create Session With Authorization
Suite Teardown      Delete All Sessions

*** Keywords ***
Create Session With Authorization
    &{headers}     Create Dictionary       Authorization=Bearer ya29.a0AeDClZBYNw9vLrR6TPChc2XxV1GlOtkJKHG-QlxxEHVVYyEvoJpOjgaKivbSkOJIPtXun5C2nvn2LbIKK_8p6270hHOE9WhlLrre4hZD0petErVLaUvJRG34XFJKiM7WRif4L8rhGLLnmIuVZEjzVkP4deqBBZ1ic2Q9AAJsaCgYKAQASARMSFQHGX2MiIlgLnUFv1nYK2p_JAWFlcw0175
    Create Session    alias=calapi1    url=https://www.googleapis.com/calendar/v3       headers=${headers}


*** Test Cases ***
TC6 Delete Request
#    Create Session With Authorization
    Set Local Variable    ${calendar_id}    18b231eae7f8a1c12183a32b740aa3e680337fb024c988d4e89dd4db9e4ee8c6@group.calendar.google.com
    ${response}     Delete On Session      alias=calapi1    url=calendars/${calendar_id}     expected_status=any
    Status Should Be    204
#    Delete All Sessions

TC7 Delete Invalid Id
    Set Local Variable    ${calendar_id}    18b231eae7f8a1c12183a32b740aa3e680337fb024c988d4e89dd4db9e4ee8c6@group.calendar.google.com
    ${response}     Delete On Session      alias=calapi1    url=calendars/${calendar_id}     expected_status=any
    Status Should Be    404