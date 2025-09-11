*** Settings ***
Documentation    Test suite for verifying QWL poll creation functionality in VibeCatch.
...              Ensures that a user can successfully log in, create a poll with a generated name, and log out.
Resource         ../../Resource/keywords.resource
Library          ../../Libs/PollGenerator.py

Suite Setup      Open VibeCatch
Suite Teardown   Close Browser

Test Tags        qwl_poll    create    e2e


*** Test Cases ***
TC01 Create New Poll
    [Documentation]    Verifies that a new poll can be created with a dynamically generated name.
    ...                Confirms that the workflow (login → create poll → logout) executes successfully.
    Login              ${username}    ${PASSWORD}
    ${poll_name}=      Generate Poll Name    prefix=QWL
    Create Poll        ${poll_name}
    Logout
