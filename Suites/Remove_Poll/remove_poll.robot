*** Settings ***
Documentation       Prerequisite: Test needs to have a specified poll name, which is available in dashboard. 
...    Then it needs to be added as a poll name as an argument. Deletes specific poll by name
Resource            ../../Resource/keywords.resource

Test Setup           Open And Login VibeCatch
Test Teardown        Close Browser


Test Tags           delete    not_independent


*** Test Cases ***
Remove Specific Poll By Name
    [Documentation]    Add specific poll name as an argument. Test case removes specific poll by name.
    Remove Single Poll By Name    Custom Poll bywdo    DESTROY    120s