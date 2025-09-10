*** Settings ***
Library    Browser
Library    ScreenCapLibrary
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser
Test Setup    Start Video Recording    name=negative-create-360
Test Teardown    Stop Video Recording


*** Test Cases ***
Create 360 Poll With No Name
    [Documentation]    Tries to create a 360 poll without a name
    [Tags]    invalid    360    poll    negative
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Sleep    15
    Create A New 360 Feedback Poll With No Name
    Sleep    5