*** Settings ***
Documentation    Test suite for verifying poll creation functionality in VibeCatch.
...              Ensures that a user can successfully log in, create a poll with a generated name, and log out.
Library          Browser
Resource         ../Resource/common_var.resource
Resource         ../Resource/keywords.resource
Library          ../Libs/PollGenerator.py

# Applies to all tests in the suite
Default Tags     ui
Force Tags       project:VibeCatch

Suite Setup      Open VibeCatch
Suite Teardown   Close Browser


*** Test Cases ***
TC01 Create New Poll
    [Documentation]    Verifies that a new poll can be created with a dynamically generated name.
    ...                Confirms that the workflow (login → create poll → logout) executes successfully.
    [Tags]    feature:poll    regression

    Login              ${username}    ${PASSWORD}
    ${poll_name}=      Generate Poll Name    prefix=QWL
    Create Poll        ${poll_name}
    Logout