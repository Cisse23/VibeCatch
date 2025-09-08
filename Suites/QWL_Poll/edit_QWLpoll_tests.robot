*** Settings ***
Library    Browser
Resource    ../Resources/keywords.resource
Resource    ../Resources/variables.resource
Library    ../Libs/Randomizer.py
Suite Setup    New Context
Suite Teardown    Close Browser
Test Tags    common



*** Test Cases ***
Edit A QWL Poll Test
    [Documentation]    Creates, edits and deletes a new QWL poll
    [Tags]    create    poll    delete    qwl
    Open VibeCatch
    Login To Vibecatch
    Sleep    15
    Create A New QWL Poll
    Sleep    15
    # Sleep, jotta toiminto ehtii toteutua
    Edit QWL Poll Name
    Sleep    30
    # Sleep, jotta toiminto ehtii toteutua
    Delete QWL Poll
    Sleep    15
    # Sleep, jotta toiminto ehtii toteutua
