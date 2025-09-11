*** Settings ***
Library     Browser
Library     ../Libs/Performance_timer.py
Library     ../Libs/PollGenerator.py
Variables   ../Resource/locators.py
Resource    ../Resource/common_var.resource
Resource    ../Resource/keywords.resource

Suite Setup       Open VibeCatch  
Suite Teardown    Close Browser


*** Test Cases ***
Create Poll Under Threshold
    Login Modal Aware                ${username}    ${password}
    ${poll}=             Generate Poll Name    prefix=PERF
    Run And Measure      5000    Create Poll    ${poll}
    Logout
