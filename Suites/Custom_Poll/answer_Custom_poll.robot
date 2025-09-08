*** Settings ***
Documentation       Tests fill custom poll with selected answers.
Resource            ../../Resource/keywords.resource

Test Setup          Open And Login VibeCatch
Test Teardown       Close Browser
Test Template       Answer Custom Poll

Test Tags           poll    smoke


*** Test Cases ***
Fill Custom Poll Case 1    [Documentation]    Answer custom poll with random answer from pool.
    Custom Poll    ALL        ${NONE}

Fill Custom Poll Case 2    [Documentation]    Answer custom poll with random answer with POSITIVE poll answers.
    Custom Poll    POSITIVE    ${NONE}

Fill Custom Poll Case 3    [Documentation]    Answer custom poll with random answer with POOR answers only.
    Custom Poll    NEGATIVE    POOR_ICON