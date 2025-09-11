*** Settings ***
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser

Test Tags    email    create


*** Test Cases ***
Create A New Email Group
    [Documentation]    Creates a new email group
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Create A New Email Group
