*** Settings ***
Documentation    Tries to create a QWL poll without a name
Library          Browser
Resource         ../../Resource/keywords.resource
Suite Setup      New Context
Suite Teardown    Close Browser

Test Tags       qwl_poll    negative 

*** Test Cases ***
Create QWL Poll With No Name
    [Documentation]    Tries to create a QWL poll without a name
    Open VibeCatch
    Login    ${USERNAME}    ${PASSWORD}
    Sleep    15
    Create A New QWL Poll With No Name