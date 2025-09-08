*** Settings ***
Library    Browser
Resource    ../Resources/variables.resource
Resource    ../Resources/locators.resource
Library    ../libs/Randomizer.py


*** Keywords ***
Open VibeCatch
    [Documentation]    Opens Vibecatch on Chrome
    New Browser    chromium    headless=False
    New Page    ${URL}
    Click    ${ALLOW_COOKIES}

Login To Vibecatch
    [Documentation]    Uses a default user and logs into the website
    [Arguments]    ${user}=safia.asheesh@brightstraining.com    ${pw}=kitchen1LAMA.stomped
    Go To    ${URL}
    Click    ${LOGIN_PAGE}
    Type Text    ${USERNAME_FIELD}    ${user}
    Sleep    2
    Type Text    ${PASSWORD_FIELD}    ${pw}
    Click    ${LOGIN_BUTTON}

Create A New QWL Poll
    [Documentation]    Creates A QWL Poll With A Randomly Generated Name
    ${poll_name}=    Generate Random Poll Name
    Click    ${CREATE_A_NEW_POLL}
    Type Text    ${POLL_NAME_FIELD}    ${poll_name}
    Click    ${CREATE_QWL_POLL}

Create A New Custom Poll
    [Documentation]    Creates A Custom Poll With A Randomly Generated Name
    ${poll_name}=    generate_random poll Name
    Click    ${CREATE_A_NEW_POLL}
    Type Text    ${POLL_NAME_FIELD}    ${poll_name}
    Click    ${CREATE_CUSTOM_POLL}

Create A New 360 Feedback Poll
    [Documentation]    Creates A 360 Feedback Poll With A Randomly Generated Name
    ${poll_name}=    Generate Random Poll Name
    Click    ${CREATE_A_NEW_POLL}
    Type Text    ${POLL_NAME_FIELD}    ${poll_name}
    Click    ${CREATE_360_FEEDBACK_POLL}

Delete QWL Poll
    [Documentation]    Deletes A QWL Poll
    Click    ${POLL_SETTINGS2}
    Sleep    10
    Click    ${REMOVE_QWL_1}
    Click    ${REMOVE_QWL_2}
    Click    ${REMOVE_QWL_3}
    Wait For Elements State    ${DESTROY_FIELD}    visible    timeout=5s
    Type Text                  ${DESTROY_FIELD}    DESTROY
    Click    ${DELETE_OK}
    Sleep    30
    # Sleep, jotta toiminnot ehtivät mennä läpi
    Wait For Elements State    ${WELCOME_STATE}    visible    timeout=5s

Delete Custom Poll
    [Documentation]    Deletes A Custom Poll
    Click    ${POLL_SETTINGS2}
    Sleep    5
    Click    ${REMOVE_CUSTOM_1}
    Sleep    5
    Click    ${REMOVE_CUSTOM_2}
    Click    ${REMOVE_CUSTOM_3}
    Wait For Elements State    ${DESTROY_FIELD}    visible    timeout=5s
    Type Text                  ${DESTROY_FIELD}    DESTROY
    Click    ${DELETE_OK}
    Sleep    30
    # Sleep, jotta toiminnot ehtivät mennä läpi
    Wait For Elements State    ${WELCOME_STATE}    visible    timeout=5s

Delete 360 Feedback Poll
    [Documentation]    Deletes A 360 Feedback Poll
    Click    ${REMOVE_360_1}
    Sleep    10
    Click    ${REMOVE_360_2}
    Sleep    10
    Click    ${REMOVE_360_3}
    Wait For Elements State    ${DESTROY_FIELD}    visible    timeout=5s
    Type Text                  ${DESTROY_FIELD}    DESTROY
    Click    ${DELETE_OK}
    Sleep    30
    # Sleep, jotta toiminnot ehtivät mennä läpi
    Wait For Elements State    ${WELCOME_STATE}    visible    timeout=5s

Edit QWL Poll Name
    [Documentation]    Changes the name of a QWL poll
    Click    ${EDIT_QWL_NAME_1}
    Click    ${EDIT_QWL_NAME_2}
    Type Text    ${EDIT_QWL_NAME_FIELD}    ${muutettunimi}
    Click    ${EDIT_QWL_NAME_SAVE}
    Wait For Elements State    text="${muutettunimi}"    visible    timeout=5s

Edit Custom Poll Name
    [Documentation]    Changes the name of a custom poll
    Click    ${EDIT_CUSTOM_NAME_1}
    Click    ${EDIT_CUSTOM_NAME_2}
    Type Text    ${EDIT_CUSTOM_NAME_FIELD}    ${muutettunimi}
    Click    ${EDIT_CUSTOM_NAME_SAVE}
    Wait For Elements State    text="${muutettunimi}"    visible    timeout=5s

Edit 360 Feedback Poll Name
    [Documentation]    Changes the name of a 360 feedback poll
    Click    ${EDIT_360_NAME_1}
    Type Text    ${EDIT_360_NAME_FIELD}    ${muutettunimi}
    Click    ${EDIT_360_NAME_SAVE}
    Wait For Elements State    text="${muutettunimi}"    visible    timeout=5s

Add A Question
    [Documentation]    Adds A Question To A Custom Poll
    ${question}=    generate_random_question
    Click    ${CUSTOM_ADD_QUESTIONS_1}
    Sleep    5
    Type Text    ${CUSTOM_ADD_QUESTIONS_FIELD}    ${question}
    Click    ${CUSTOM_ADD_QUESTIONS_2}
    Click    ${CUSTOM_ADD_QUESTIONS_SAVE}
    Sleep    15
    # Sleep, jotta toiminnot ehtivät mennä läpi


Create A New Email Group
    [Documentation]    Creates a new email group
    Click    ${ALL_USERS_PAGE}
    Click    ${EMAIL_GROUPS_BUTTON}
    Click    ${ADD_NEW_EMAIL_GROUP}
    Type Text    ${NEW_EMAIL_GROUP_NAME_FIELD}    ${email_group_name}
    Click    ${NEW_EMAIL_GROUP_OK}
    Sleep    15
    # Sleep, jotta toiminnot ehtivät mennä läpi
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=5s

Edit Email Group Name
    [Documentation]    Changes the name of the last created email group
    Click    ${RENAME_EMAIL_GROUP}
    Wait For Elements State    ${RENAME_EMAIL_GROUP_FIELD}    visible
    Click    ${RENAME_EMAIL_GROUP_FIELD}
    Focus       ${RENAME_EMAIL_GROUP_FIELD}
    Fill Text    ${RENAME_EMAIL_GROUP_FIELD}    ${new_email_group_name}
    Click    ${RENAME_EMAIL_GROUP_OK}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=5s

Delete Email Group
    [Documentation]    Deletes the last created email group
    Click    ${REMOVE_EMAILGROUP_BUTTON}
    Click    ${REMOVE_EMAIL_GROUP_OK}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=5s

Add Email Address
    [Documentation]    Adds a randomly generated email address to the latest email group
    ${email}=    Generate Random Email
    Click    ${LAST_EMAIL_GROUP}
    Wait For Elements State    ${ADD_EMAILS_BUTTON}    visible    15s
    Click   ${ADD_EMAILS_BUTTON}
    Type Text    ${EMAIL_FIELD}    ${email}
    Click    ${EMAIL_ADD_BUTTON}
    Wait For Elements State    ${ALL_USERS_STATE}    visible    timeout=5s

Create A New QWL Poll With No Name
    [Documentation]    Creates A QWL Poll With A Randomly Generated Name
    Click    ${CREATE_A_NEW_POLL}
    Click    ${CREATE_QWL_POLL}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

Create A New Custom Poll With No Name
    [Documentation]    Creates A Custom Poll With A Randomly Generated Name
    Click    ${CREATE_A_NEW_POLL}
    Click    ${CREATE_CUSTOM_POLL}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

Create A New 360 Feedback Poll With No Name
    [Documentation]    Creates A 360 Feedback Poll With A Randomly Generated Name
    Click    ${CREATE_A_NEW_POLL}
    Click    ${CREATE_360_FEEDBACK_POLL}
    Wait For Elements State    text=Please give a descriptive name for your poll.    visible    timeout=15s

Login To Vibecatch
    [Documentation]    Uses a default user and logs into the website
    [Arguments]    ${user}=safia.asheesh@brightstraining.com    ${pw}=kitchen1LAMA.stomped
    Go To    ${URL}
    Click    ${LOGIN_PAGE}
    Type Text    ${USERNAME_FIELD}    ${user}
    Sleep    2
    Type Text    ${PASSWORD_FIELD}    ${pw}
    Click    ${LOGIN_BUTTON}

Create A New QWL Poll
    [Documentation]    Creates A QWL Poll With A Randomly Generated Name
    ${poll_name}=    Generate Random Poll Name
    Click    ${CREATE_A_NEW_POLL}
    Type Text    ${POLL_NAME_FIELD}    ${poll_name}
    Click    ${CREATE_QWL_POLL}

Create A New Custom Poll
    [Documentation]    Creates A Custom Poll With A Randomly Generated Name
    ${poll_name}=    Generate Random Poll Name
    Click    ${CREATE_A_NEW_POLL}
    Type Text    ${POLL_NAME_FIELD}    ${poll_name}
    Click    ${CREATE_CUSTOM_POLL}

Create A New 360 Feedback Poll
    [Documentation]    Creates A 360 Feedback Poll With A Randomly Generated Name
    ${poll_name}=    Generate Random Poll Name
    Click    ${CREATE_A_NEW_POLL}
    Type Text    ${POLL_NAME_FIELD}    ${poll_name}
    Click    ${CREATE_360_FEEDBACK_POLL}

Delete QWL Poll
    [Documentation]    Deletes A QWL Poll
    Click    ${POLL_SETTINGS2}
    Sleep    10
    Click    ${REMOVE_QWL_1}
    Click    ${REMOVE_QWL_2}
    Click    ${REMOVE_QWL_3}
    Wait For Elements State    ${DESTROY_FIELD}    visible    timeout=5s
    Type Text                  ${DESTROY_FIELD}    DESTROY
    Click    ${DELETE_OK}
    Sleep    30
    Wait For Elements State    ${WELCOME_STATE}    visible    timeout=5s

Delete Custom Poll
    [Documentation]    Deletes A Custom Poll
    Click    ${POLL_SETTINGS2}
    Sleep    5
    Click    ${REMOVE_CUSTOM_1}
    Sleep    5
    Click    ${REMOVE_CUSTOM_2}
    Click    ${REMOVE_CUSTOM_3}
    Wait For Elements State    ${DESTROY_FIELD}    visible    timeout=5s
    Type Text                  ${DESTROY_FIELD}    DESTROY
    Click    ${DELETE_OK}
    Sleep    30
    Wait For Elements State    ${WELCOME_STATE}    visible    timeout=5s

Delete 360 Feedback Poll
    [Documentation]    Deletes A 360 Feedback Poll
    Click    ${REMOVE_360_1}
    Sleep    10
    Click    ${REMOVE_360_2}
    Sleep    10
    Click    ${REMOVE_360_3}
    Wait For Elements State    ${DESTROY_FIELD}    visible    timeout=5s
    Type Text                  ${DESTROY_FIELD}    DESTROY
    Click    ${DELETE_OK}
    Sleep    30
    Wait For Elements State    ${WELCOME_STATE}    visible    timeout=5s

Edit QWL Poll Name
    [Documentation]    Changes the name of a QWL poll
    Click    ${EDIT_QWL_NAME_1}
    Click    ${EDIT_QWL_NAME_2}
    Type Text    ${EDIT_QWL_NAME_FIELD}    ${muutettunimi}
    Click    ${EDIT_QWL_NAME_SAVE}
    Wait For Elements State    text="${muutettunimi}"    visible    timeout=5s

Edit Custom Poll Name
    [Documentation]    Changes the name of a custom poll
    Click    ${EDIT_CUSTOM_NAME_1}
    Click    ${EDIT_CUSTOM_NAME_2}
    Type Text    ${EDIT_CUSTOM_NAME_FIELD}    ${muutettunimi}
    Click    ${EDIT_CUSTOM_NAME_SAVE}
    Wait For Elements State    text="${muutettunimi}"    visible    timeout=5s

Edit 360 Feedback Poll Name
    [Documentation]    Changes the name of a 360 feedback poll
    Click    ${EDIT_360_NAME_1}
    Type Text    ${EDIT_360_NAME_FIELD}    ${muutettunimi}
    Click    ${EDIT_360_NAME_SAVE}
    Wait For Elements State    text="${muutettunimi}"    visible    timeout=5s

Add A Question
    [Documentation]    Adds A Question To A Custom Poll
    ${question}=    Generate Random Question
    Click    ${CUSTOM_ADD_QUESTIONS_1}
    Sleep    5
    Type Text    ${CUSTOM_ADD_QUESTIONS_FIELD}    ${question}
    Click    ${CUSTOM_ADD_QUESTIONS_2}
    Click    ${CUSTOM_ADD_QUESTIONS_SAVE}
    Sleep    15
