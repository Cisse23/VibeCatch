*** Settings ***
Documentation   Keywords resource file for Suites
Library         String
Library         Browser
Library         ../libs/CustomLibrary.py
Variables       locators.py
Variables       env_vars.py
Resource        common_var.resource

Library         ../libs/Randomizer.py

*** Keywords ***
Open VibeCatch
    [Documentation]    Opens the site with given URL.
    [Arguments]    ${browser}=chromium    ${headless}=${HEADLESS}
    New Browser    browser=${browser}    headless=${headless}
    New Page    ${URL}

Login
    [Documentation]    Logs in with username and password.
    [Arguments]    ${username}    ${password}
    Wait For Elements State    ${LOGIN_BUTTON}    timeout=10
    Click    ${LOGIN_BUTTON}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Text    ${PASSWORD_FIELD}    ${password}
    Click    ${LOGIN_BUTTON2}

Logout
    [Documentation]    Logs out and verifies logout button is visible again.
    Click    ${LOG_OUT_ELEMENT}
    Wait For Elements State    ${LOGIN_BUTTON}    timeout=10

Close Browser And Logout
    [Documentation]    Logs out and closes the browser.
    Logout
    Close Browser

Open And Login VibeCatch
    [Documentation]    Opens the site and logs in.
    Open VibeCatch
    Login    ${username}    ${password}

Login And Return Status
    [Documentation]    Logs in and returns boolean status for success.
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
    [Documentation]    Asserts login status equals expected result.
    [Arguments]    ${username}    ${password}    ${expected_result}
    ${status}=    Login And Return Status    ${username}    ${password}
    Should Be Equal    ${status}    ${expected_result}

Create A New Email Group
    [Documentation]    Creates a new email group.
    Click    ${ALL_USERS_PAGE}
    Click    ${EMAIL_GROUPS_BUTTON}
    Click    ${ADD_NEW_EMAIL_GROUP}
    Type Text    ${NEW_EMAIL_GROUP_NAME_FIELD}    ${email_group_name}
    Click    ${NEW_EMAIL_GROUP_OK}
    Sleep    15
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=30

Edit Email Group Name
    [Documentation]    Renames the last created email group.
    Click    ${RENAME_EMAIL_GROUP}
    Wait For Elements State    ${RENAME_EMAIL_GROUP_FIELD}    visible
    Click    ${RENAME_EMAIL_GROUP_FIELD}
    Focus    ${RENAME_EMAIL_GROUP_FIELD}
    Fill Text    ${RENAME_EMAIL_GROUP_FIELD}    ${new_email_group_name}
    Click    ${RENAME_EMAIL_GROUP_OK}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=30

Delete Email Group
    [Documentation]    Deletes the last created email group.
    Click    ${REMOVE_EMAILGROUP_BUTTON}
    Click    ${REMOVE_EMAIL_GROUP_OK}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=30

Add Email Address
    [Documentation]    Adds a random email address to the last email group.
    ${email}=    Generate Random Email
    Click    ${LAST_EMAIL_GROUP}
    Wait For Elements State    ${ADD_EMAILS_BUTTON}    visible    timeout=30
    Click    ${ADD_EMAILS_BUTTON}
    Type Text    ${EMAIL_FIELD}    ${email}
    Click    ${EMAIL_ADD_BUTTON}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=30

Create QWL Poll
    [Documentation]    Creates a default QWL poll and saves it.
    [Arguments]    ${project_prefix}=QWL Poll
    ...    ${rand_len}=5
    ...    ${charset}=[LOWER]
    ...    ${type}=complete
    ...    ${organization_type}=traditional
    ...    ${hide_vector_graphs}=${TRUE}
    ...    ${number_of_questions}=All
    ${suffix}=    Generate Random String    ${rand_len}    ${charset}
    ${poll_name}=    Set Variable    ${project_prefix} ${suffix}
    Sleep    10
    Wait For Elements State    ${ADD_NEW_PROJECT}    timeout=15
    Click    ${ADD_NEW_PROJECT}
    Type Text    ${ADD_PROJECT_NAME}    ${poll_name}
    Click    ${CREATE_QWL_POLL_BUTTON}
    Sleep    10
    Select Options By    ${QWL_TYPE_OPTIONS}    value    ${type}
    Select Options By    ${ORGANIZATION_TYPE_OPTIONS}    label    ${organization_type}
    IF    ${hide_vector_graphs}
        Check Checkbox    ${HIDE_VECTOR_GRAPHS_CHECKBOX}
    ELSE
        Uncheck Checkbox    ${HIDE_VECTOR_GRAPHS_CHECKBOX}
    END
    Click    //button[contains(text(),"${number_of_questions}")]
    Click    ${SAVE_CHANGES_BUTTON}
    RETURN    ${poll_name}

Verify Poll Created
    [Documentation]    Verifies that the poll link with given name exists.
    [Arguments]    ${pollname}
    Go To    ${URL}
    Sleep    10
    Wait For Elements State    //a[normalize-space()="${pollname}"]    visible    timeout=120s

Create And Verify QWL Poll
    [Documentation]    Creates a QWL poll and verifies it exists.
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
    [Documentation]    Creates a custom poll with given questions and returns its name.
    [Arguments]    ${project_prefix}=Custom Poll    ${rand_len}=5    ${charset}=[LOWER]    @{questions}
    ${suffix}=    Generate Random String    ${rand_len}    ${charset}
    ${poll_name}=    Set Variable    ${project_prefix} ${suffix}
    Wait For Elements State    ${ADD_NEW_PROJECT}    visible    timeout=20
    Click    ${ADD_NEW_PROJECT}
    Wait For Elements State    ${ADD_PROJECT_NAME}    visible    10s
    Type Text    ${ADD_PROJECT_NAME}    ${poll_name}
    Wait For Elements State    ${CREATE_CUSTOM_POLL_BUTTON}    enabled    10s
    Click    ${CREATE_CUSTOM_POLL_BUTTON}
    Sleep    10
    Wait For Elements State    ${ADD_QUESTIONS_BUTTON}    visible    timeout=30
    Click    ${ADD_QUESTIONS_BUTTON}
    VAR    ${status}=    ${False}
    WHILE    not ${status}    limit=5
        Click    ${ADD_QUESTIONS_BUTTON}
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${TYPE_QUESTIONS_FIELD}    visible    timeout=3
    END
    FOR    ${q}    IN    @{questions}
        Wait For Elements State    ${TYPE_QUESTIONS_FIELD}    visible    10s
        Sleep    10
        Type Text    ${TYPE_QUESTIONS_FIELD}    ${q}    clear=False
        Sleep    10
    END
    Wait For Elements State    ${ADD_QUESTIONS_BUTTON3}    timeout=30
    Click    ${ADD_QUESTIONS_BUTTON3}
    Click    ${SAVE_CHANGES_BUTTON}
    RETURN    ${poll_name}

Create And Verify Custom Poll
    [Documentation]    Creates a custom poll and verifies it exists.
    [Arguments]    ${project_prefix}    ${rand_len}    ${charset}    @{questions}
    ${pollname}=    Create Custom Poll    ${project_prefix}    ${rand_len}    ${charset}    @{questions}
    Verify Poll Created    ${pollname}

Create 360 Poll
    [Documentation]    Creates a 360 poll with one random question.
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
        ${status}=    Run Keyword And Return Status    Wait For Elements State    ${SELECT_NEW_QUESTION}    visible    timeout=3
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
    [Documentation]    Creates a 360 poll and verifies it exists.
    [Arguments]    ${project_prefix}
    ...    ${rand_len}
    ...    ${charset}
    ...    ${question_index}
    ...    ${min_index}
    ...    ${max_allowed}
    ${pollname}=    Create 360 Poll    ${project_prefix}    ${rand_len}    ${charset}
    Verify Poll Created    ${pollname}

Answer Custom Poll
    [Documentation]    Answers a custom poll using selected or random options.
    [Arguments]    ${poll_name}=Custom Poll    ${pool}=ALL    ${fixed_answer}=${NONE}
    Wait For Elements State
    ...    //div[contains(@class,"row") and contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][contains(normalize-space(.),"${poll_name}")] ][1]//a[@mattooltip="View poll form"]
    ...    visible
    ...    20s
    Click
    ...    //div[contains(@class,"row") and contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][contains(normalize-space(.),"${poll_name}")] ][1]//a[@mattooltip="View poll form"]
    Sleep    20
    Switch Page    NEW
    Wait For Elements State    ${NEXT_BUTTON_FEEDBACK}    visible    timeout=30
    Click    ${NEXT_BUTTON_FEEDBACK}
    Sleep    10
    Wait For Elements State    ${NEXT_PAGE_BUTTON_QWL_POLL}    visible    timeout=60
    WHILE    True
        ${visible_elements}=    Get Element Count    ${NEXT_PAGE_BUTTON_QWL_POLL}
        IF    '${fixed_answer}' != '${NONE}'
            VAR    ${random_locator}    ${fixed_answer}
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

Fill QWL Poll
    [Documentation]    Fills a QWL poll with random/seeded answers.
    [Arguments]    ${name_poll}=QWL Poll    ${pool}=ALL    ${seed}=${NONE}    ${fixed_answer}=${NONE}
    Wait For Elements State
    ...    //div[contains(@class,"row") and contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][contains(normalize-space(.),"${name_poll}")] ][1]//a[@mattooltip="View poll form"]
    ...    visible
    ...    10s
    Click
    ...    //div[contains(@class,"row") and contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][contains(normalize-space(.),"${name_poll}")] ][1]//a[@mattooltip="View poll form"]
    Sleep    20
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
    [Documentation]    Starts the QWL form and delegates to Fill QWL Poll.
    [Arguments]    ${name_poll}= QWL Poll    ${pool}=ALL    ${seed}=${NONE}    ${fixed_answer}=${NONE}
    Wait For Elements State    ${LOG_OUT_ELEMENT}    timeout=10
    Sleep    10
    Fill QWL Poll

Create A New QWL Poll With No Name
    [Documentation]    Asserts error when creating QWL poll without a name.
    Click    ${ADD_NEW_PROJECT}
    Click    ${CREATE_QWL_POLL_BUTTON}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

Create A New Custom Poll With No Name
    [Documentation]    Asserts error when creating custom poll without a name.
    Click    ${ADD_NEW_PROJECT}
    Click    ${CREATE_CUSTOM_POLL_BUTTON}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

Create A New 360 Feedback Poll With No Name
    [Documentation]    Asserts error when creating 360 poll without a name.
    Click    ${ADD_NEW_PROJECT}
    Click    ${CREATE_360_POLL_BUTTON}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

Create New 360 Feedback Poll With Default Settings
    [Documentation]    Creates a 360 poll with default settings.
    [Arguments]    ${poll_name}
    Wait For Elements State    ${CREATE_NEW_POLL_BUTTON_FIRST}    timeout=60
    Click    ${CREATE_NEW_POLL_BUTTON_FIRST}
    Type Text    ${POLL_NAME_FIELD}    ${poll_name}
    Click    ${CREATE_360_FEEDBACK_BUTTON}
    Wait For Elements State    ${POLL_FORM_LINK}    visible    timeout=60

Open Poll Form
    [Documentation]    Opens poll form link and waits for the first field.
    Click    ${POLL_FORM_LINK}
    Wait Until Keyword Succeeds    10x    3s    Switch Page    NEW
    Wait For Elements State    ${EVALUATOR_NAME_FIELD}    visible    timeout=60

Enter Evaluator Name
    [Documentation]    Types evaluator name and clicks next.
    [Arguments]    ${test_evaluator_name}
    Type Text    ${EVALUATOR_NAME_FIELD}    ${test_evaluator_name}
    Click    ${NEXT_BUTTON_360_POLL_FORM}

Answer 360 Feedback Questions
    [Documentation]    Answers all 360 questions with the first option and submits.
    @{question_blocks}    Get Elements    ${RATING_BUTTONS_CONTAINER}
    ${question_count}    Evaluate    len(${question_blocks})
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
    [Documentation]    Deletes the current poll from settings.
    Scroll To    ${TWEAK_FEEDBACK_OR_REMOVE_POLL}
    Click    ${TWEAK_FEEDBACK_OR_REMOVE_POLL}
    Wait For Elements State    text=Delete this poll and all its feedback completely
    Click    ${DELETE_THIS_POLL_AND_ALL_ITS_FEEDBACK_COMPLETELY}
    Click    ${DELETE_NOW}
    Type Text    ${DESTROY_INPUT_FIELD}    DESTROY
    Click    ${DESTROY_OK_BUTTON}
    Wait For Elements State    ${CREATE_NEW_POLL_BUTTON_FIRST}    timeout=60

Verify Poll Was Deleted
    [Documentation]    Verifies a poll with given name has fewer instances after deletion.
    [Arguments]    ${poll_name}    ${count_polls_before}
    Wait For Elements State    ${CREATE_NEW_POLL_BUTTON_FIRST}    timeout=60
    @{polls_with_name_after}    Find Polls By Name    ${poll_name}
    ${count_polls_after}    Evaluate    len(${polls_with_name_after})
    Should Be True    ${count_polls_before} > ${count_polls_after}

Find Polls By Name
    [Documentation]    Returns a list of poll elements matching the given name.
    [Arguments]    ${poll_name}
    Wait For Elements State    ${POLLS_TABLE_ROW}    visible    timeout=120
    @{polls}    Get Elements    xpath=//a[@class="project-name" and normalize-space(.)="${poll_name}"]
    RETURN    ${polls}

Open Poll Settings
    [Documentation]    Opens settings from a poll title locator.
    [Arguments]    ${poll_title_locator}
    Click    ${poll_title_locator}
    Wait For Elements State    ${SETTINGS_LINK}    visible    timeout=60
    Click    ${SETTINGS_LINK}
    Wait For Elements State    ${SETTINGS_LINK_ACTIVE}    timeout=60

# Helper variants (name-based flows)
Open Website (Maximized With Cookie Accept)
    [Documentation]    Opens maximized window and accepts cookie banner if present.
    New Browser    browser=chromium    headless=${False}    args=["--start-maximized"]
    New Context    viewport=${None}
    New Page       ${URL}
    Run Keyword And Ignore Error    Wait For Elements State    ${BTN_ALLOW_COOKIES}    visible    timeout=8s
    Run Keyword And Ignore Error    Click    ${BTN_ALLOW_COOKIES}

Go To Login (If Not Visible)
    [Documentation]    Shows login form if not already visible.
    ${form_visible}=    Run Keyword And Return Status    Wait For Elements State    ${INPUT_EMAIL}    visible    timeout=1s
    IF    not ${form_visible}
        Wait For Elements State    ${BTN_LOGIN}    visible    timeout=15s
        Click    ${BTN_LOGIN}
        Wait For Elements State    ${INPUT_EMAIL}    visible    timeout=20s
    END

Login Modal Aware
    [Documentation]    Logs in and waits for possible modal overlay to disappear.
    [Arguments]    ${email}    ${password}
    Go To Login (If Not Visible)
    Fill Text    ${INPUT_EMAIL}    ${email}
    Fill Text    ${INPUT_PASSWORD}    ${password}
    Click        ${BTN_SUBMIT_LOGIN}
    Wait For Load State    networkidle    timeout=45s
    Run Keyword And Ignore Error    Wait For Elements State    css=.dialog-overlay    hidden    timeout=10s

Create Poll By Name
    [Documentation]    Clicks Create → types name → creates a QWL poll.
    [Arguments]    ${poll_name}
    Wait For Elements State    xpath=//body/vibe-app/div[@id='masterContainer']/vibe-list/div[2]/div[1]/a[1]    visible    timeout=20s
    Click                      xpath=//body/vibe-app/div[@id='masterContainer']/vibe-list/div[2]/div[1]/a[1]
    Wait For Elements State    xpath=//input[@id='addProjectName']    visible    timeout=20s
    Fill Text                  xpath=//input[@id='addProjectName']    ${poll_name}
    Wait For Elements State    xpath=//button[normalize-space()='Create a QWL poll']    visible    timeout=15s
    Click                      xpath=//button[normalize-space()='Create a QWL poll']
    Wait For Load State        networkidle    timeout=30s

Open Poll Settings By Name
    [Documentation]    Finds poll card by name and opens its settings.
    [Arguments]    ${poll_name}
    ${BASIC_SECT}=    Set Variable    xpath=//vibe-settings-advanced-button[@icon='cog']//div[contains(@class,'accordionTitle')]
    ${on_settings}=    Run Keyword And Return Status    Wait For Elements State    ${BASIC_SECT}    visible    timeout=3s
    Return From Keyword If    ${on_settings}
    ${CARD1}=    Set Variable    css=.project:has(h3:has-text("${poll_name}"))
    ${CARD2}=    Set Variable    css=.project:has(:text("${poll_name}"))
    ${CARD3}=    Set Variable    xpath=//*[contains(@class,'project')][.//*[self::h1 or self::h2 or self::h3 or self::a][normalize-space()="${poll_name}"]]
    ${ok}=    Run Keyword And Return Status    Wait For Elements State    ${CARD1}    visible    timeout=6s
    IF    not ${ok}
        ${ok}=    Run Keyword And Return Status    Wait For Elements State    ${CARD2}    visible    timeout=6s
        IF    not ${ok}
            Wait For Elements State    ${CARD3}    visible    timeout=10s
            ${CARD}=    Set Variable    ${CARD3}
        ELSE
            ${CARD}=    Set Variable    ${CARD2}
        END
    ELSE
        ${CARD}=    Set Variable    ${CARD1}
    END
    Hover    ${CARD}
    ${clicked}=    Run Keyword And Return Status    Click    ${CARD} >> css=i.fa-gears
    IF    not ${clicked}
        ${clicked}=    Run Keyword And Return Status    Click    ${CARD} >> css=i.fa-cog
        IF    not ${clicked}
            ${clicked}=    Run Keyword And Return Status    Click    ${CARD} >> xpath=.//i[contains(@class,'fa') and (contains(@class,'gears') or contains(@class,'cog'))]
            IF    not ${clicked}
                Click    ${CARD}
            END
        END
    END
    Wait For Load State    networkidle    timeout=20s

Open Basic Settings
    [Documentation]    Opens Basic Settings accordion; navigates to settings by name if needed.
    [Arguments]    ${poll_name}=${NONE}
    ${BASIC_SECT}=    Set Variable    xpath=//vibe-settings-advanced-button[@icon='cog']//div[contains(@class,'accordionTitle')]
    ${ok}=    Run Keyword And Return Status    Wait For Elements State    ${BASIC_SECT}    visible    timeout=5s
    IF    not ${ok}
        Run Keyword    Open Poll Settings By Name    ${poll_name}
        Wait For Elements State    ${BASIC_SECT}    visible    timeout=8s
    END
    Scroll To    ${BASIC_SECT}
    Click        ${BASIC_SECT}

Save Changes
    [Documentation]    Clicks Save on settings and waits for network idle.
    Wait For Elements State    ${SAVE_CHANGES_BUTTON}    visible    20s
    Scroll To                  ${SAVE_CHANGES_BUTTON}
    Click                      ${SAVE_CHANGES_BUTTON}
    Wait For Load State        networkidle    30s

Add Finnish
    [Documentation]    Adds Finnish translation in Basic Settings and saves.
    ${DDL}=    Set Variable    //select[@id="addLanguage" or contains(@id,"language")]
    Wait For Elements State    ${DDL}    visible    20s
    Scroll To                  ${DDL}
    Click                      ${DDL}
    Select Options By          ${DDL}    label    Finnish (full QWL report and questions)
    Click                      ${SAVE_CHANGES_BUTTON}
