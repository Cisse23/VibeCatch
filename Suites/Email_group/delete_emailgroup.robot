*** Settings ***
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser

Test Tags    email    delete


*** Test Cases ***
Delete Latest Email Group
    [Documentation]    Creates a new email group and deletes it
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Create A New Email Group
    Delete Email Group
