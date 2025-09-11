*** Settings ***
Documentation    Tries to create a custom poll without a name
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser

Test Tags    custom_poll    negative


*** Test Cases ***
Create Custom Poll With No Name
    [Documentation]    Tries to create a custom poll without a name
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Sleep    15
    Create A New Custom Poll With No Name