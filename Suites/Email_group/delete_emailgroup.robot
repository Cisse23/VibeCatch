*** Settings ***
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser
Test Tags    common


*** Test Cases ***
Delete Latest Email Group
    [Documentation]    Creates a new email group and deletes it
    [Tags]    delete    emailgroup
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Create A New Email Group
    Delete Email Group
