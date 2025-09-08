*** Settings ***
Library    Browser
Resource    ../../Resource/keywords.resource
Suite Setup    New Context
Suite Teardown    Close Browser


*** Test Cases ***
Create QWL Poll With No Name
    [Documentation]    Tries to create a QWL poll without a name
    [Tags]    invalid    qwl    poll    negative
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Sleep    15
    Create A New QWL Poll With No Name