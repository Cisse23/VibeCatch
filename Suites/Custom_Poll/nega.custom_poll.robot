*** Settings ***
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser


*** Test Cases ***
Create Custom Poll With No Name
    [Documentation]    Tries to create a custom poll without a name
    [Tags]    invalid    custom    poll    negative
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Sleep    15
    Create A New Custom Poll With No Name