*** Settings ***
Documentation       This suite creates 360  Polls

Resource            ../../Resource/keywords.resource

Suite Setup         Open And Login VibeCatch
Suite Teardown      Close Browser
Test Template       Create And Verify 360 Poll

Test Tags           poll    smoke


*** Test Cases ***
360 Poll Case 1    [Documentation]    Log in and creates 360 Poll with parametric name and chosen index inbetween 3-12
    360 Poll    5    [LOWER]    7    3    12
360 Poll Case 2    [Documentation]    Log in and creates 360 Poll with parametric name and random index inbetween 3-12
    360 Poll    7    [UPPER]    RANDOM    3    12
360 Poll Case 3    [Documentation]    Log in and creates 360 Poll with parametric name and chosen index inbetween 3-12
    360 Poll    8    [NUMBERS]    2    3    12