*** Settings ***
Library   funcs.py
Library   SSHLibrary
Library   Impansible
Library   Collections

*** Variables ***
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
    ${output} =   Setup   localhost
    #log   ${output}   formatter=repr
    ${y} =   get from dictionary   ${x}   ansible-facts
    ${result} =   get from dictionary   ${y}   ansible-distribution
    Should Be Equal   ${result}   Ubuntu
