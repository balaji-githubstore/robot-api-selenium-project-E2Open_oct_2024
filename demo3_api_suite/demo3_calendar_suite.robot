*** Settings ***
Library     RequestsLibrary
Library    OperatingSystem

Suite Setup     Create Session    alias=calapi    url=https://www.googleapis.com/calendar/v3
Suite Teardown      Delete All Sessions

*** Test Cases ***
TC1 Get Calendar List
    &{headers}     Create Dictionary       Authorization=Bearer LVihAgYzAgNSbevTypISsAbuDOzw38l_K1ptFupTwDzbAJ7V_26Man6BAORotKbMVQag4vKlm5AZO89-OULQUEP_aCgYKAU4SARMSFQHGX2Mi3yM6Jsd78wpkr77CQXotqA0175

    ${response}     GET On Session      alias=calapi    url=users/me/calendarList
    ...     headers=${headers}      expected_status=any
    Status Should Be    200
    Log    ${response.json()}

TC2 Get Calendar By Id
    Set Local Variable    ${calendar_id}    8df68a45d39613a3fdabf6dd870ea5991fe5b52bf67eb9344d
    &{headers}     Create Dictionary       Authorization=Bearer ya29.a0AeDClZDM-8Gtw8Ke0QdczdMnCkQ9d5JVZkNEgJnQM7vHtjdaypAbzo1qrXdM5S9CffBBwIkiH38P--7FLVihAgYzAgNSbevTypISsAbuDOzw38l_K1ptFupTwDzbAJ7V_26Man6BAORotKbMVQag4vKlm5AZO89-OULQUEP_aCgYKAU4SARMSFQHGX2Mi3yM6Jsd78wpkr77CQXotqA0175
    ${response}     GET On Session      alias=calapi    url=calendars/${calendar_id}    headers=${headers}      expected_status=any
    Status Should Be    200
    Log    ${response.json()}[id]
    Should Be Equal As Strings    ${response.json()}[id]    ${calendar_id}

TC3 Create Calendar From JSON file
    ${json_str}     Get Binary File    ${EXECDIR}${/}files${/}new_calendar.json
    &{headers}     Create Dictionary       Content-Type=application/json
    ...     Authorization=Bearer ya29.a0AeDClZDM-8Gtw8Ke0QdczdMnCkQ9d5JVZkNEgJnQM7vHtjdayNSbevTypISsAbuDOzw38l_K1ptFupTwDzbAJ7V_26Man6BAORotKbMVQag4vKlm5AZO89-OULQUEP_aCgYKAU4SARMSFQHGX2Mi3yM6Jsd78wpkr77CQXotqA0175

    ${response}    POST On Session     alias=calapi    url=calendars       data=${json_str}    headers=${headers}      expected_status=any
    Status Should Be    200
    Log    ${response.json()}

TC4 Create Calendar From Local Dictionary
    &{body}     Create Dictionary   summary=Local Oct 10 E2Open     description=Session
    Log To Console    ${body}[summary]
    &{headers}     Create Dictionary       Content-Type=application/json
    ...     Authorization=Bearer ya29.a0AeDClZDM-8Gtw8Ke0QdczdMnCkQ9d5JVZkNEgJnQM7vHtjdaypAbzo1qrXdM5S9CffypISsAbuDOzw38l_K1ptFupTwDzbAJ7V_26Man6BAORotKbMVQag4vKlm5AZO89-OULQUEP_aCgYKAU4SARMSFQHGX2Mi3yM6Jsd78wpkr77CQXotqA0175

    ${response}    POST On Session     alias=calapi    url=calendars       json=${body}    headers=${headers}      expected_status=any
    Status Should Be    200
    Log    ${response.json()}

#update exiting calendar description using patch


TC5 Delete Request
    Set Local Variable    ${calendar_id}    18b231ea2b740aa3e680337fb024c988d4e89dd4db9e4ee8c6@group.calendar.google.com
    &{headers}     Create Dictionary       Authorization=Bearer ya29.a0AeDXxV1GlOtkJKHG-QlxxEHVVYyEvoJpOjgaKivbSkOJIPtXun5C2nvn2LbIKK_8p6270hHOE9WhlLrre4hZD0petErVLaUvJRG34XFJKiM7WRif4L8rhGLLnmIuVZEjzVkP4deqBBZ1ic2Q9AAJsaCgYKAQASARMSFQHGX2MiIlgLnUFv1nYK2p_JAWFlcw0175
    Create Session    alias=calapi1    url=https://www.googleapis.com/calendar/v3       headers=${headers}
    ${response}     Delete On Session      alias=calapi1    url=calendars/${calendar_id}     expected_status=any
    Status Should Be    204