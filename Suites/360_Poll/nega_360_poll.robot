*** Settings ***
Documentation    Tries to create a 360 poll without a name
Library    Browser
Library    ScreenCapLibrary
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser

Test Tags    360_poll    negative


*** Test Cases ***
Create 360 Poll With No Name
    [Documentation]    Tries to create a 360 poll without a name
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Sleep    15
    Create A New 360 Feedback Poll With No Name
    Sleep    5