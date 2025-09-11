*** Settings ***
Documentation       Test suite for verifying 360 Feedback poll functionality in the web application.
...                 Covers opening an existing poll, answering all questions, and submitting feedback.
...                 Ensures that submission is properly recorded and reflected in the evaluation report.
...                 Uses common resources and poll-specific keywords for page interactions and form handling.

Resource            ../../Resource/common_var.resource
Resource            ../../Resource/keywords.resource

Test Setup          Open And Login VibeCatch
Test Teardown       Close Page

Test Tags           360_poll    answer


*** Test Cases ***
Open 360 Feedback Poll
    [Documentation]    Verifies that a user can open an existing 360 Feedback poll and navigate to its evaluation form.
    [Tags]    smoke

    Create New 360 Feedback Poll With Default Settings    Testing 360 Feedback Poll

    # Open Poll Form in new tab
    Click    ${POLL_FORM_LINK}

    ${main_page}    Wait Until Keyword Succeeds    10x    3s    Switch Page    NEW
    # Wait For Heavy Page Elements To Load    ${TIMEOUT_BIG}
    Wait For Elements State    ${EVALUATOR_NAME_FIELD}    visible    timeout=30

    # Close Poll Form tab and return to main tab
    ${poll_form_tab}    Switch Page    ${main_page}
    Close Page    ${poll_form_tab}
    Click    ${SETTINGS_LINK}
    Delete Poll

Answer 360 Feedback Poll
    [Documentation]    Verifies that a user can answer all questions
    ...    in a 360 Feedback poll and submit the evaluation successfully.
    [Tags]    e2e
    VAR    ${test_evaluator_name}    Test Robot
    Create New 360 Feedback Poll With Default Settings    Test-poll
    Open Poll Form
    Enter Evaluator Name    ${test_evaluator_name}
    Answer 360 Feedback Questions
