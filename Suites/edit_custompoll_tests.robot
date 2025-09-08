*** Settings ***
Library    Browser
Resource    ../Resources/keywords.resource
Resource    ../Resources/variables.resource
Library    ../Libs/randomizer.py
Suite Setup    New Context
Suite Teardown    Close Browser
Test Tags    common


*** Test Cases ***
Create A New Custom Poll With A Question
    [Documentation]    Creates A New Custom Poll With A Randomly Generated Question And Deletes The Poll Eventually
    [Tags]    create    poll    question    delete    custom
    Open VibeCatch
    Login To Vibecatch
    Sleep    15
    Create A New Custom Poll
    Sleep    15
    Edit Custom Poll Name
    Sleep    35
    Delete Custom Poll
    Sleep    5
