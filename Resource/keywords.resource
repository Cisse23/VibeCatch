*** Settings ***
Documentation   Keywords resource file for Suites
Library         String
Library         Browser    enable_presenter_mode=true
Library         ../libs/CustomLibrary.py
Variables       locators.py
Variables       env_vars.py
Resource        common_var.resource


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
    Wait For Elements State    //*[contains(text(), "${pollname}")]    visible    timeout=120s

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
    VAR    ${status}=    ${False}
    WHILE    not ${status}    limit=5
        Click    ${ADD_QUESTIONS_BUTTON}
        ${status}=    Run Keyword And Return Status
        ...    Wait For Elements State
        ...    ${TYPE_QUESTIONS_FIELD}
        ...    visible
        ...    timeout=3
    END
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
