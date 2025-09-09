*** Settings ***
Library    Browser
Resource   ../../Resource/keywords.resource
Resource   ../../Resource/common_var.resource
Variables  ../../Resource/locators.py
Library    ../../libs/Randomizer.py
Suite Setup    New Context
Suite Teardown    Close Browser
Test Tags    common



*** Test Cases ***
Create A New Custom Poll With A Question
    Open VibeCatch
    Login To Vibecatch
    Sleep    10
    ${poll_name}=    Create A New Custom Poll
    Sleep    10
    Edit Custom Poll Name
    Sleep    10
    Delete Custom Poll    ${poll_name}
    Sleep    5


