*** Settings ***
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser
Test Tags    common


*** Test Cases ***
Add Email Address To Email Group
    [Documentation]    Creates a new email group and adds an email address to it
    [Tags]    add    email    emailgroup
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Create A New Email Group
    Add Email Address
