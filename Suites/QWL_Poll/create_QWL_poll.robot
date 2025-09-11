*** Settings ***
Documentation       Creates QWL Poll
Resource            ../../Resource/keywords.resource

Suite Setup         Open And Login VibeCatch
Suite Teardown      Close Browser
Test Template       Create And Verify QWL Poll

Test Tags           qwl_poll    e2e    create


*** Test Cases ***
QWL Poll Case 1    [Documentation]    Test case creates new QWL Poll and verifies it
    QWL Poll    5    [LOWER]    streamlined    self-governing    ${FALSE}   3
QWL Poll Case 2    [Documentation]    Test case creates new QWL Poll and verifies it
    QWL Poll    6    [UPPER]    streamlined    traditional       ${FALSE}   All
QWL Poll Case 3    [Documentation]    Test case creates new QWL Poll and verifies it
    QWL Poll    7    [NUMBERS]    complete    self-governing     ${TRUE}    15
