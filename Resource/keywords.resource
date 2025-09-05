*** Settings ***
Documentation   Keywords resource file for Suites
Library         Browser    enable_presenter_mode=true
Variables       locators.py
Variables       env_vars.py
Resource        common_var.resource


*** Keywords ***
Open VibeCheck
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

Open And Login VibeCheck
    [Documentation]    Open website with given url and logins
    Open VibeCheck
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