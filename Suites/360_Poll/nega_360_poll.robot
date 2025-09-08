*** Settings ***
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser


*** Test Cases ***
Create 360 Poll With No Name
    [Documentation]    Tries to create a 360 poll without a name
    [Tags]    invalid    360    poll    negative
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Sleep    15
    Create A New 360 Feedback Poll With No Name