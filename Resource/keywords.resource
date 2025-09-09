*** Settings ***
Documentation   Keywords resource file for Suites
Library         String
Library         Browser    enable_presenter_mode=true
Library         ../libs/CustomLibrary.py
Variables       locators.py
Variables       env_vars.py
Resource        common_var.resource
Library         ../libs/Randomizer.py


*** Keywords ***
Open VibeCatch
    [Documentation]    Open website with given url
    [Arguments]    ${browser}=chromium    ${headless}=${HEADLESS}
    New Browser    browser=${browser}    headless=${headless}
    New Page    ${URL}

Login
    [Documentation]    Login to website
    [Arguments]    ${username}    ${password}
    Wait For Elements State    ${LOGIN_BUTTON}    timeout=10
    Click    ${LOGIN_BUTTON}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Text    ${PASSWORD_FIELD}    ${password}
    Click    ${LOGIN_BUTTON2}

Logout
    [Documentation]    Logout to website when you have logged in and verifies logout
    Click    ${LOG_OUT_ELEMENT}
    Wait For Elements State    ${LOGIN_BUTTON}    timeout=10

Close Browser And Logout
    [Documentation]    Logout to website and close browser
    Logout
    Close Browser

Open And Login VibeCatch
    [Documentation]    Open website with given url and logins
    Open VibeCatch
    Login    ${username}    ${password}

Login And Return Status
    [Documentation]    Login to website and return status if login was successful or fail if given status found
    [Arguments]    ${username}    ${password}
    Login    ${username}    ${password}
    TRY
        Wait For Elements State    ${LOG_OUT_ELEMENT}    timeout=10
        VAR    ${status}=    ${TRUE}
    EXCEPT    TimeoutError*    type=GLOB
        VAR    ${status}=    ${FALSE}
    END
    RETURN    ${status}

Login Test
    [Documentation]    Compares given status to expected result indicates if login failed or successful
    [Arguments]    ${username}    ${password}    ${expected_result}
    ${status}=    Login And Return Status    ${username}    ${password}
    Should Be Equal    ${status}    ${expected_result}

Create A New Email Group
    [Documentation]    Creates a new email group
    Click    ${ALL_USERS_PAGE}
    Click    ${EMAIL_GROUPS_BUTTON}
    Click    ${ADD_NEW_EMAIL_GROUP}
    Type Text    ${NEW_EMAIL_GROUP_NAME_FIELD}    ${email_group_name}
    Click    ${NEW_EMAIL_GROUP_OK}
    Sleep    15
    # Sleep, jotta toiminnot ehtivät mennä läpi
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=30

Edit Email Group Name
    [Documentation]    Changes the name of the last created email group
    Click    ${RENAME_EMAIL_GROUP}
    Wait For Elements State    ${RENAME_EMAIL_GROUP_FIELD}    visible
    Click    ${RENAME_EMAIL_GROUP_FIELD}
    Focus       ${RENAME_EMAIL_GROUP_FIELD}
    Fill Text    ${RENAME_EMAIL_GROUP_FIELD}    ${new_email_group_name}
    Click    ${RENAME_EMAIL_GROUP_OK}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=30

Delete Email Group
    [Documentation]    Deletes the last created email group
    Click    ${REMOVE_EMAILGROUP_BUTTON}
    Click    ${REMOVE_EMAIL_GROUP_OK}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=30

Add Email Address
    [Documentation]    Adds a randomly generated email address to the latest email group
    ${email}=    Generate Random Email
    Click    ${LAST_EMAIL_GROUP}
    Wait For Elements State    ${ADD_EMAILS_BUTTON}    visible    timeout=30
    Click   ${ADD_EMAILS_BUTTON}
    Type Text    ${EMAIL_FIELD}    ${email}
    Click    ${EMAIL_ADD_BUTTON}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=30

Create QWL Poll
    [Documentation]    Generates new Default QWL Poll with random name automatically and saves it.
    [Arguments]    ${project_prefix}=QWL Poll
    ...    ${rand_len}=5
    ...    ${charset}=[LOWER]
    ...    ${type}=complete
    ...    ${organization_type}=traditional
    ...    ${hide_vector_graphs}=${TRUE}
    ...    ${number_of_questions}=All
    # Build a unique poll name
    ${suffix}=    Generate Random String    ${rand_len}    ${charset}
    ${poll_name}=    Set Variable    ${project_prefix} ${suffix}
    Wait For Elements State    ${ADD_NEW_PROJECT}    timeout=15
    Click    ${ADD_NEW_PROJECT}
    Type Text    ${ADD_PROJECT_NAME}    ${poll_name}
    Click    ${CREATE_QWL_POLL_BUTTON}
    Select Options By    ${QWL_TYPE_OPTIONS}    value    ${type}
    Select Options By    ${ORGANIZATION_TYPE_OPTIONS}    label    ${organization_type}
    IF    ${hide_vector_graphs}
        Check Checkbox    ${HIDE_VECTOR_GRAPHS_CHECKBOX}
    ELSE
        Uncheck Checkbox    ${HIDE_VECTOR_GRAPHS_CHECKBOX}
    END
    Click    //button[contains(text(),"${number_of_questions}")]
    Click    //a[@id="save" and contains(text(), "Save changes")]
    RETURN    ${poll_name}

Verify Poll Created
    [Documentation]    Verify that poll is created
    [Arguments]    ${pollname}
    Go To    ${URL}
    Sleep    10
    Wait For Elements State    //a[normalize-space()="${pollname}"]    visible    timeout=120s

Create And Verify QWL Poll
    [Documentation]    Create and verify that poll is created
    [Arguments]    ${project_prefix}=QWL Poll
    ...    ${rand_len}=5
    ...    ${charset}=[LOWER]
    ...    ${type}=complete
    ...    ${organization_type}=traditional
    ...    ${hide_vector_graphs}=${TRUE}
    ...    ${number_of_questions}=All
    ${pollname}=    Create QWL Poll    ${project_prefix}    ${rand_len}    ${charset}
    Verify Poll Created    ${pollname}

Create Custom Poll
    [Documentation]    Creates a new Custom Poll with a generated name and a list of questions.
    ...    Returns the full poll name so tests can assert on it.
    [Arguments]    ${project_prefix}=Custom Poll    ${rand_len}=5    ${charset}=[LOWER]    @{questions}
    # Build a unique poll name
    ${suffix}=    Generate Random String    ${rand_len}    ${charset}
    ${poll_name}=    Set Variable    ${project_prefix} ${suffix}

    # Create project/poll
    Wait For Elements State    ${ADD_NEW_PROJECT}    visible    timeout=15
    Click    ${ADD_NEW_PROJECT}
    Wait For Elements State    ${ADD_PROJECT_NAME}    visible    10s
    Type Text    ${ADD_PROJECT_NAME}    ${poll_name}
    Wait For Elements State    ${CREATE_CUSTOM_POLL_BUTTON}    enabled    10s
    Click    ${CREATE_CUSTOM_POLL_BUTTON}
    # Add questions
    Wait For Elements State    ${ADD_QUESTIONS_BUTTON}    visible    10s
    Click    ${ADD_QUESTIONS_BUTTON}
    FOR    ${q}    IN    @{questions}
        Wait For Elements State    ${TYPE_QUESTIONS_FIELD}    visible    5s
        Type Text    ${TYPE_QUESTIONS_FIELD}    ${q}    clear=False
    END
    Wait For Elements State    ${ADD_QUESTIONS_BUTTON2}    enabled    10s
    Click    ${ADD_QUESTIONS_BUTTON2}
    RETURN    ${poll_name}

Create And Verify Custom Poll
    [Documentation]    Verify that custom poll is created
    [Arguments]    ${project_prefix}    ${rand_len}    ${charset}    @{questions}
    ${pollname}=    Create Custom Poll    ${project_prefix}    ${rand_len}    ${charset}    @{questions}
    Verify Poll Created    ${pollname}

Create 360 Poll
    [Documentation]    Generates new 360 Poll with random name automatically and adds one random question.
    [Arguments]    ${project_prefix}=360 Poll
    ...    ${rand_len}=5
    ...    ${charset}=[LOWER]
    ...    ${question_index}=RANDOM
    ...    ${min_index}=3
    ...    ${max_allowed}=12
    ${suffix}=    Generate Random String    ${rand_len}    ${charset}
    ${poll_name}=    Set Variable    ${project_prefix} ${suffix}
    Wait For Elements State    ${ADD_NEW_PROJECT}    visible    timeout=20s
    Click    ${ADD_NEW_PROJECT}
    Type Text    ${ADD_PROJECT_NAME}    ${poll_name}
    Click    ${CREATE_360_POLL_BUTTON}
    Wait For Elements State    ${ADD_QUESTION_BUTTON}    visible    timeout=20s
    VAR    ${status}=    ${False}
    WHILE    not ${status}    limit=5
        Click    ${ADD_QUESTION_BUTTON}
        ${status}=    Run Keyword And Return Status
        ...    Wait For Elements State
        ...    ${SELECT_NEW_QUESTION}
        ...    visible
        ...    timeout=3
    END
    Wait For Elements State    ${SELECT_NEW_QUESTION}    visible    timeout=30s
    Click    ${SELECT_NEW_QUESTION}
    IF    '${question_index}' == 'RANDOM' or '${question_index}' == '${EMPTY}'
        ${random_index}=    Get Random Index Answer
    ELSE
        ${random_index}=    Set Variable    ${question_index}
    END
    Select Options By    ${SELECT_NEW_QUESTION}    index    ${random_index}
    Click    ${CLICK_FIRST_CHOICE}
    Click    ${ADD_SELECTED_QUESTION}
    RETURN    ${poll_name}

Create And Verify 360 Poll
    [Documentation]    Generates new 360 Poll with random name automatically, adds one random question and verifies it.
    [Arguments]    ${project_prefix}
    ...    ${rand_len}
    ...    ${charset}
    ...    ${question_index}
    ...    ${min_index}
    ...    ${max_allowed}
    ${pollname}=    Create 360 Poll    ${project_prefix}    ${rand_len}    ${charset}
    Verify Poll Created    ${pollname}

Fill QWL Poll
    [Documentation]    Fill QWL Poll with random or selected answers from a chosen pool.
    [Arguments]    ${name_poll}=QWL Poll    ${pool}=ALL    ${seed}=${NONE}    ${fixed_answer}=${NONE}
    Wait For Elements State
    ...    //div[contains(@class,"row") and contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][contains(normalize-space(.),"${name_poll}")] ][1]//a[@mattooltip="View poll form"]
    ...    visible
    ...    10s
    Click
    ...    //div[contains(@class,"row") and contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][contains(normalize-space(.),"${name_poll}")] ][1]//a[@mattooltip="View poll form"]
    Sleep    20    # doesn't work without sleep
    Switch Page    NEW
    Wait For Elements State    ${NEXT_BUTTON_FEEDBACK}    visible    20s
    Click    ${NEXT_BUTTON_FEEDBACK}
    ${visible_elements}=    Get Element Count    ${NEXT_PAGE_BUTTON_QWL_POLL}
    WHILE    ${True}
        ${visible_elements}=    Get Element Count    ${NEXT_PAGE_BUTTON_QWL_POLL}
        IF    '${fixed_answer}' != '${NONE}'
            ${random_locator}=    Set Variable    ${fixed_answer}
        ELSE
            ${random_locator}=    Get Random Xpath Answer    ${pool}    ${seed}
        END
        Click    ${${random_locator}}
        IF    ${visible_elements} >= 1
            Click    ${NEXT_PAGE_BUTTON_QWL_POLL}
        ELSE
            BREAK
        END
    END
    Click    ${SEND_FEEDBACK_BUTTON}
    Wait For Elements State    ${THANK_YOU_FEEDBACK_MESSAGE}    timeout=10

Answer QWL Poll
    [Documentation]    Answers QWL Poll's questions with random or seeded answers from chosen pool.
    [Arguments]    ${name_poll}= QWL Poll    ${pool}=ALL    ${seed}=${NONE}    ${fixed_answer}=${NONE}
    Wait For Elements State    ${LOG_OUT_ELEMENT}    timeout=10
    Sleep    10    # doesn't work without
    Fill QWL Poll

Answer Custom Poll
    [Documentation]    Answer custom poll with random or selected answers from POSITIVE or NEGATIVE pool.
    [Arguments]    ${poll_name}=Custom Poll    ${pool}=ALL    ${fixed_answer}=${NONE}
    Wait For Elements State
    ...    //div[contains(@class,"row") and contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][contains(normalize-space(.),"${poll_name}")] ][1]//a[@mattooltip="View poll form"]
    ...    visible
    ...    20s
    Click
    ...    //div[contains(@class,"row") and contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][contains(normalize-space(.),"${poll_name}")] ][1]//a[@mattooltip="View poll form"]
    Sleep    5
    Switch Page    NEW
    Wait For Elements State    ${NEXT_BUTTON_FEEDBACK}    visible    20s
    Click    ${NEXT_BUTTON_FEEDBACK}
    WHILE    True
        ${visible_elements}=    Get Element Count    ${NEXT_PAGE_BUTTON_QWL_POLL}
        IF    '${fixed_answer}' != '${NONE}'
            VAR      ${random_locator}    ${fixed_answer}
        ELSE
            ${random_locator}=    Get Random Custom Poll Answer    ${pool}
        END
        Click    ${${random_locator}}
        IF    ${visible_elements} >= 1
            Click    ${NEXT_PAGE_BUTTON_QWL_POLL}
        ELSE
            BREAK
        END
    END
    Click    ${SEND_FEEDBACK_BUTTON}
    Wait For Elements State    ${THANK_YOU_FEEDBACK_MESSAGE}

Create A New QWL Poll With No Name
    [Documentation]    Fails to create a QWL poll because it's missing a name
    Click    ${ADD_NEW_PROJECT}
    Click    ${CREATE_QWL_POLL_BUTTON}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

Create A New Custom Poll With No Name
    [Documentation]    Fails to create a custom poll because it's missing a name
    Click    ${ADD_NEW_PROJECT}
    Click    ${CREATE_CUSTOM_POLL_BUTTON}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

Create A New 360 Feedback Poll With No Name
    [Documentation]    Fails to create a 360 feedback poll because it's missing a name
    Click    ${ADD_NEW_PROJECT}
    Click    ${CREATE_360_POLL_BUTTON}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

# Answer 360 Poll
Create New 360 Feedback Poll With Default Settings
    [Documentation]    Use the given name to create a new 360 Feedback poll
    ...    with default settings and default questions.
    [Arguments]    ${poll_name}
    Wait For Elements State    ${CREATE_NEW_POLL_BUTTON_FIRST}    timeout=60
    Click    ${CREATE_NEW_POLL_BUTTON_FIRST}
    Type Text    ${POLL_NAME_FIELD}    ${poll_name}
    Click    ${CREATE_360_FEEDBACK_BUTTON}
    Wait For Elements State    ${POLL_FORM_LINK}    visible    timeout=60

Open Poll Form
    [Documentation]    Opens a poll form by clicking its link, switching to the new tab,
    ...    and waiting until the evaluator name field is visible.
    Click    ${POLL_FORM_LINK}
    Wait Until Keyword Succeeds    10x    3s    Switch Page    NEW
    # Wait For Heavy Page Elements To Load    ${TIMEOUT_BIG}
    Wait For Elements State    ${EVALUATOR_NAME_FIELD}    visible    timeout=60

Enter Evaluator Name
    [Documentation]    Starts answering a 360 Feedback poll by entering the evaluator name and clicking next.
    [Arguments]    ${test_evaluator_name}
    Type Text    ${EVALUATOR_NAME_FIELD}    ${test_evaluator_name}
    Click    ${NEXT_BUTTON_360_POLL_FORM}

Answer 360 Feedback Questions
    [Documentation]    Completes a 360 Feedback poll by answering
    ...    each question with the first available option,
    ...    and submitting the evaluation at the end.
    @{question_blocks}    Get Elements    ${RATING_BUTTONS_CONTAINER}
    ${question_count}    Evaluate    len(${question_blocks})
    Log    \n Found queations: ${question_count}
    WHILE    ${question_count} > 0
        @{options}    Get Elements    ${RATING_OPTIONS}
        Click    ${options[0]}

        ${question_count}    Evaluate    ${question_count} - 1
        ${is_last_question}    Run Keyword And Return Status    Get Element    ${SUBMIT_EVALUATION_BUTTON}
        IF    ${is_last_question}
            Click    ${SUBMIT_EVALUATION_BUTTON}
        ELSE
            Click    ${NEXTQUESTION_BUTTON_360_POLL_FORM}
        END
    END

Delete Poll
    [Documentation]    Deletes poll and waits for Dashboard to load.
    ...    Assumes that poll settings is already open.
    Scroll To    ${TWEAK_FEEDBACK_OR_REMOVE_POLL}
    Click    ${TWEAK_FEEDBACK_OR_REMOVE_POLL}
    Wait For Elements State    text=Delete this poll and all its feedback completely
    Click    ${DELETE_THIS_POLL_AND_ALL_ITS_FEEDBACK_COMPLETELY}
    Click    ${DELETE_NOW}
    Type Text    ${DESTROY_INPUT_FIELD}    DESTROY
    Click    ${DESTROY_OK_BUTTON}
    Wait For Elements State    ${CREATE_NEW_POLL_BUTTON_FIRST}    timeout=60
