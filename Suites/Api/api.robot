*** Settings ***
Documentation       Test suite for verifying the VibeCatch API endpoints related to feedback.
...                 Covers response structure validation, filtering feedback by question IDs,
...                 and verifying metadata such as submission counts and total questions.
...                 Uses custom Python library ApiRequests.py for request handling.

Library             Collections
Library             String
Library             ../../libs/ApiRequests.py

Test Tags           api


*** Variables ***
# See api.test-plan.md for instructions on how to create api_key
${API_KEY}      a3bafe24067b3c2f3487


*** Test Cases ***
Verify QWL Poll Structure
    [Documentation]    Verifies that a QWL poll API response contains the required
    ...    top-level keys: "meta", "feedback", and "qwl".
    ...    Also logs the total number of form submissions.
    ${response}    Send Request Params    api_key=${API_KEY}
    Pretty Print JSON Response    ${response}
    Dictionary Should Contain Key    dictionary=${response}    key=meta
    Dictionary Should Contain Key    dictionary=${response}    key=feedback
    Dictionary Should Contain Key    dictionary=${response}    key=qwl
    Log Submission Count    ${response}

Test Filtering Questions With One Question
    [Documentation]    Verifies that the API correctly filters feedback when a single
    ...    question ID is provided. Ensures only feedback for that
    ...    specific question is returned.
    ${response}    Send Request Params    api_key=${API_KEY}    questions=688c7454a787c096fdf0719f
    Pretty Print JSON Response    ${response}
    Verify Feedback Matches Expected Questions    ${response}    688c7454a787c096fdf0719f

Test Filtering Questions With Multiple Questions
    [Documentation]    Verifies that the API correctly filters feedback when multiple
    ...    question IDs are provided. Ensures the response contains only
    ...    feedback for the specified questions, regardless of order.
    ${response}    Send Request Params
    ...    api_key=${API_KEY}
    ...    questions=688c7454a787c096fdf07197,688c7454a787c096fdf0719c,688c7454a787c096fdf07194
    Verify Feedback Matches Expected Questions
    ...    ${response}
    ...    688c7454a787c096fdf07197,688c7454a787c096fdf0719c,688c7454a787c096fdf07194


*** Keywords ***
Verify Total Amount Of Questions
    [Documentation]    Checks that the API response contains the expected number of questions.
    ...    Compares the "total" value in the response metadata against the given amount.
    [Arguments]    ${response}    ${expected_amount}
    ${meta}    Get From Dictionary    ${response}    meta
    ${total_amount}    Get From Dictionary    ${meta}    total
    Should Be Equal As Integers    ${total_amount}    ${expected_amount}

Log Submission Count
    [Documentation]    Logs how many times the feedback form has been submitted,
    ...    as reported in the API response metadata.
    [Arguments]    ${response}
    ${meta}    Get From Dictionary    ${response}    meta
    ${total}    Get From Dictionary    ${meta}    totalFormSubmissionCount
    Log    Form submitted times: ${total}

Verify Feedback Matches Expected Questions
    [Documentation]    Ensures the feedback response contains exactly the given set of question IDs.
    ...    Ignores order and removes duplicates before comparison.
    [Arguments]    ${response}    ${expected_questions}
    @{expected_questions_list}    Split String    ${expected_questions}    ,
    ${feedback_list}    Get From Dictionary    ${response}    feedback
    ${found_questions}    Evaluate    [item["question"] for item in $feedback_list]
    @{unique_found}    Remove Duplicates    ${found_questions}
    Sort List    ${unique_found}
    Sort List    ${expected_questions_list}
    Lists Should Be Equal    ${unique_found}    ${expected_questions_list}

Get Feedback Count
    [Documentation]    Returns the total number of feedback entries included in the API response.
    [Arguments]    ${response}
    ${feedback_list}    Get From Dictionary    ${response}    feedback
    ${count}    Get Length    ${feedback_list}
    RETURN    ${count}

Pretty Print JSON Response
    [Documentation]    Logs the API response as formatted, indented JSON for readability.
    ...    Uses <pre> tags to preserve formatting in Robot Framework's log.html.
    [Arguments]    ${response}
    ${pretty}    Pretty Print Json    ${response}
    Log    <pre>${pretty}</pre>    html=True
