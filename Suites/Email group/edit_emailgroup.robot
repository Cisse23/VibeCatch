*** Settings ***
Library    Browser
Resource    ../Resources/keywords.resource
Resource    ../Resources/variables.resource
Suite Setup    New Context
Suite Teardown    Close Browser
Test Tags    common


*** Test Cases ***
Rename Latest Email Group
    [Documentation]    Creates a new email group and edits its name
    [Tags]    emailgroup
    Open VibeCatch
    Login
    Sleep    15
    Create A New Email Group
    Sleep    5
    Edit Email Group Name
    