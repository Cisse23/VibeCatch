*** Settings ***
Library    Browser
Resource    ../Resources/keywords.resource
Resource    ../Resources/variables.resource
Suite Setup    New Context
Suite Teardown    Close Browser
Test Tags    common


*** Test Cases ***
Add Email Address To Email Group
    [Documentation]    Creates a new email group and adds an email address to it
    [Tags]    add    email    emailgroup
    Open VibeCatch
    Login
    Sleep    15
    Create A New Email Group
    Sleep    5
    Add Email Address
    