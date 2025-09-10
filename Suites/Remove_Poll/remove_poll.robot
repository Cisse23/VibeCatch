*** Settings ***
Documentation       Deletes specific poll by name
Resource            ../../Resource/keywords.resource

Test Setup          Open And Login VibeCatch
Test Teardown       Close Browser

Test Tags           remove


*** Test Cases ***
Remove Specific Poll By Name
    [Documentation]    Test case removes specific poll by name.
    Remove Single Poll By Name    360 Poll 97264060    DESTROY    120s