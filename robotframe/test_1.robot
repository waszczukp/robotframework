*** Settings ***
Library   funcs.py
Library   SSHLibrary
Library   Impansible
Library   Collections
Library   SeleniumLibrary

*** Variables ***
${SERVER}    localhost:7272
${BROWSER}    Firefox
${VALID_USERNAME}    testerwsb_t1
${VALID_PASSWORD}    adam1234
${loginInput}   id:login
${passwordInput}   id:password
${buttonLogin}   id:btnSubmit
${odebrane}   odebrane

${MY_STRING}   My very first string
${REMOTE_HOST}    localhost
${REMOTE_USERNAME}    vdi-student
${REMOTE_PASSWORD}    Pa$$w0rd
${ansible_become_password}    vdi-student
${ansible_user}    Pa$$w0rd

*** Test Cases ***
Test No One Test Space
    log to console   Test print

Test No Two Test Space
    log to console   ${MY_STRING}

Test No Three Test Space
    Show in console   My own string

Test No Four Test Space
    ${assert}   fun   1   2
    should be equal   ${assert}   1 ma 2

Test No Four Open Remote And Login
    [Tags]   login
    Connect to host
    Pass login and password
    Execute Command and assert correct execution
    Disconnect from host

Test No Five Check Ping
    [Tags]   ping
    Connect to host
    Pass login and password
    Execute Command and assert correct execution
    Check Connection
    Disconnect from host

Test No Six Download Data
    [Tags]   data
    Getting Data

Test No Seven Login To Mail Account
    [Tags]   loginWp
    Open new browser
    Open Login Page
    Pass login
    Pass password
    Click log in
    Check if logged in
    Close opened browser

*** Keywords ***
Show in console
    [Arguments]   ${text}
    log to console   ${text}

Connect to host
    Open Connection   ${REMOTE_HOST}

Pass login and password
    Login   ${REMOTE_USERNAME}   ${REMOTE_PASSWORD}

Execute Command and assert correct execution
    ${output} =    Execute Command   uname -a
    Should Contain   ${output}   GNU/Linux

Check Connection
    ${output8} =    Execute Command   ping -c1 8.8.8.8
    Should Not Contain   ${output8}   100%

Disconnect from host
    Close Connection

Getting Data
    ${x} =   Setup   localhost
    #log   ${output}   formatter=repr
    ${y} =   get from dictionary   ${x}   ansible-facts
    ${result} =   get from dictionary   ${y}   ansible-distribution
    Should Be Equal   ${result}   Ubuntu

Open new browser
    Open Browser   about:blank   ${BROWSER}

Open Login Page
    Go to   https://profil.wp.pl/login.html?zaloguj=poczta

Pass login
    Input Text   ${loginInput}   ${VALID_USERNAME}

Pass password
    Input Text   ${passwordInput}   ${VALID_PASSWORD}

Click log in
    Click element   ${buttonLogin}

Check if logged in
    Page Should Contain    {odebrane}

Close opened browser
    Close Browser
