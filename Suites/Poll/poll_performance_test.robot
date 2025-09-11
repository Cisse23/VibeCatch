*** Settings ***
Documentation    Tests QWL poll creation under defined performance limits
Library     ../../Libs/Performance_timer.py
Library     ../../Libs/PollGenerator.py
Resource    ../../Resource/keywords.resource

Suite Setup       Open VibeCatch  
Suite Teardown    Close Browser

Test Tags        create    performance    qwl_poll


*** Test Cases ***
Create Poll Under Threshold
    Login Modal Aware                ${username}    ${password}
    ${poll}=             Generate Poll Name    prefix=PERF
    Run And Measure      5000    Create Poll    ${poll}
    Logout
