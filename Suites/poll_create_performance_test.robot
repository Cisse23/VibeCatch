*** Settings ***
Library     Browser
Library     ../libs/Performance_timer.py
Library     ../libs/PollGenerator.py
Variables   ../Resource/locators.py
Resource    ../Resource/common_var.resource
Resource    ../Resource/keywords.resource

Suite Setup       Open Website
Suite Teardown    Close Browser

*** Test Cases ***
Create Poll Under Threshold
    Login Modal Aware                ${email}    ${password}
    ${poll}=             Generate Poll Name    prefix=PERF
    Run And Measure      5000    Create Poll    ${poll}
    Logout
