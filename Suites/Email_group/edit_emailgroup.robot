*** Settings ***
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser

Test Tags    email    edit


*** Test Cases ***
Rename Latest Email Group
    [Documentation]    Creates a new email group and edits its name
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Create A New Email Group
    Edit Email Group Name
