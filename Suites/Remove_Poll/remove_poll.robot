*** Settings ***
Documentation       Deletes specific poll by name
Resource            ../../Resource/keywords.resource

Test Setup           Open And Login VibeCatch
Test Teardown        Close Browser
Suite Setup          Start Video Recording    name=delete
Suite Teardown       Stop Video Recording

Test Tags           remove    smoke


*** Test Cases ***
Remove Specific Poll By Name
    [Documentation]    Test case removes specific poll by name.
    Remove Single Poll By Name    Custom Poll bywdo    DESTROY    120s