*** Settings ***
Library     RequestsLibrary
Library    OperatingSystem

Suite Setup     Create Session    alias=petstore    url=https://petstore.swagger.io/v2/
Suite Teardown      Delete All Sessions

*** Test Cases ***
TC1 Find Pet By Valid Id
    #by default the http response should be 200
    ${response}     GET On Session      alias=petstore      url=pet/2
    Should Be Equal As Integers    ${response.json()}[id]    2

TC2 Find Pet By Invalid Id
    ${response}     GET On Session      alias=petstore      url=pet/20000       expected_status=any 
    Status Should Be    404
    #verify the message - Pet not found
    Should Be Equal As Strings    ${response.json()}[message]    Pet not found

TC3 Find Pet By Status
    ${response}     GET On Session   alias=petstore     url=pet/findByStatus?status=sold
    Log     ${response.json()}
    #log the first pet status from the list
    Log    ${response.json()}[0][status]

TC4 Find Pet By Status
    ${response}     GET On Session   alias=petstore     url=pet/findByStatus?status=sold
    
    ${list_count}   Get Length    ${response.json()}
    Log    ${list_count}

    FOR    ${i}    IN RANGE    0    ${list_count}
        Log    ${response.json()}[${i}][status]
        Should Be Equal As Strings    ${response.json()}[${i}][status]    sold
    END

TC5 Add Valid Pet
   ${json}   Get Binary File     ${EXECDIR}${/}files${/}add_pet.json
   &{headers}  Create Dictionary    Content-Type=application/json       Connection=keep-alive

   ${response}   POST On Session     alias=petstore      url=pet     headers=${headers}      
   ...      data=${json}       expected_status=any
   Status Should Be    200
   Log    ${response.json()}
   Should Be Equal As Integers    ${response.json()}[id]    789

TC6 Update Valid Pet
   ${json}   Get Binary File     ${EXECDIR}${/}files${/}update_pet.json
   &{headers}  Create Dictionary    Content-Type=application/json       Connection=keep-alive

   ${response}   PUT On Session     alias=petstore      url=pet     headers=${headers}
   ...      data=${json}       expected_status=any
   Status Should Be    200
   Log    ${response.json()}
   Should Be Equal As Strings   ${response.json()}[name]    xxx-789


TC6 Upload Valid Pet Image
    &{pay_load1}     Create Dictionary   additionalMetadata=image/jpg

    ${file_jpg1}   Get Binary File     ${EXECDIR}${/}files${/}demo.jpg

    @{inner_list1}   Create List     file       ${file_jpg1}
    @{final_list1}   Create List     ${inner_list1}

    ${response}    POST On Session     alias=petstore    url=/pet/789/uploadImage     data=${pay_load1}
    ...     files=${final_list1}     expected_status=any
    Status Should Be    200
#    Log    ${response.json()}

