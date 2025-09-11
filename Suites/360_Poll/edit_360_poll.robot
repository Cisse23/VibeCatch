*** Settings ***
Documentation       Test suite for verifying poll editing features in VibeCatch.
...                 Covers opening poll settings and deleting polls.
...                 Uses shared setup steps to log in and handle popups before execution.

Resource            ../../Resource/keywords.resource

Test Setup          Open And Login VibeCatch

Test Tags           feedback_poll


*** Test Cases ***
User Can Open Poll Settings
    [Documentation]    Clicks on the first 'Change poll's settings' button on the Dashboard.
    ...    Then the 'Add Questions' button should be visible. Then navigates back to Dashboard.
    ...    Assumes atleat 1 poll exists in the system.
    [Tags]    smoke
    @{edit_buttons}    Get Elements    ${POLL_SETTINGS_BUTTON}
    Click    ${edit_buttons}[0]
    Wait For Elements State    selector=${ADD_QUESTIONS_BUTTON}    state=visible    timeout=60
    Click    ${LOGO_NAVBAR}
    Wait For Elements State    ${POLLS_TABLE_ROW}    visible    timeout=120

User Can Delete Poll With Name
    [Documentation]    Creates a new poll, then clicks the logo in the navbar
    ...    to move to the Dashboard and Deletes the the first poll with the same same.
    VAR    ${new_poll_name}    Delete This Poll
    Create New 360 Feedback Poll With Default Settings    ${new_poll_name}
    Navigate To Dashboard
    @{polls}    Find Polls By Name    ${new_poll_name}
    ${count_polls_before}    Evaluate    len(@{polls})
    Open Poll Settings    ${polls}[0]
    Delete Poll
    Verify Poll Was Deleted    ${new_poll_name}    ${count_polls_before}

Delete Questions From Poll
    [Documentation]    Creates a new poll with default questions, then opens the poll
    ...    and deletes questions until there a 5 questions left.
    VAR    ${new_poll_name}    Shorter Feedback Poll
    Create New 360 Feedback Poll With Default Settings    ${new_poll_name}
    Delete Questions Until    15
    Verify Amount Of Questions    15
    Click    ${SAVE_BUTTON}
    Wait For Elements State    ${POLLS_TABLE_ROW}    visible    timeout=60
    Delete All Polls With Name    ${new_poll_name}


*** Keywords ***
Navigate To Dashboard
    [Documentation]    Clicks the Vibecatch logo in the navbar and waits for the
    ...    Dashboard to load.
    Click    ${LOGO_NAVBAR}
    Wait For Elements State    ${POLLS_TABLE_ROW}    visible    timeout=120

Delete Questions Until
    [Documentation]    Assumes Poll Settings Page is open. Deletes questions from poll
    ...    until specified number of questions is left
    [Arguments]    ${questions_left}
    WHILE    ${TRUE}
        @{questions_delete_button}    Get Elements    //a[@mattooltip="Remove question"]
        ${count}    Get Length    ${questions_delete_button}
        IF    ${count} <= ${questions_left}    BREAK
        Click    ${questions_delete_button[0]}
        Sleep    0.5
        # Click the last visible dialog’s OK button
        # There can be other modals that are not visible with "OK" buttons
        Click    (//mat-dialog-container[contains(@class,"mat-mdc-dialog-container")]//button[normalize-space(.)="OK"])[last()]
        Sleep    0.5
    END

Verify Amount Of Questions
    [Documentation]    Verifies that the "Poll questions (X)" text contains the expected number.
    [Arguments]        ${expected_amount}
    Wait For Elements State    text=Poll questions (${expected_amount})

Delete All Polls With Name
    [Documentation]    Finds all polls with given name and deletes them one at
    ...    a time until all have been deleted. Assumes Dashboard to be open.
    [Arguments]    ${poll_name}
    WHILE    True
        Wait For Elements State    ${POLLS_TABLE_ROW}    visible    timeout=60
        @{polls}    Find Polls By Name    ${poll_name}
        ${polls_count}    Evaluate    len(@{polls})
        Log To Console    \nPolls to delete: ${polls_count}
        IF    ${polls_count} == 0    BREAK
        Open Poll Settings    ${polls}[0]
        Delete Poll
    END