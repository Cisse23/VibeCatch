*** Settings ***
Library    Browser
Resource    ../Resource/keywords.resource
Resource    ../Resource/common_var.resource
Suite Setup    New Context
Suite Teardown    Close Browser
Test Tags    common


*** Test Cases ***
Create A New Email Group
    [Documentation]    Creates a new email group
    [Tags]    create    emailgroup
    Open VibeCatch
    Login
    Sleep    15
    Create A New Email Group
    