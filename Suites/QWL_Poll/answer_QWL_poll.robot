*** Settings ***
Documentation       Answers QWL Poll
Resource            ../../Resource/keywords.resource

Suite Setup         Open And Login VibeCatch
Suite Teardown      Close Browser
Test Template       Answer QWL Poll
Test Setup          Start Video Recording    name=QWLanswer
Test Teardown       Stop Video Recording

Test Tags           poll    smoke


*** Test Cases ***
Answer QWL Poll Case 1    [Documentation]    Answers QWL Poll randomily from pool of answers.
    QWL Poll    ALL    ${NONE}    ${NONE}
Answer QWL Poll Case 2    [Documentation]    Answers QWL Poll with Quality_2 answers only
    QWL Poll    QUALITY    ${NONE}    QUALITY_2
Answer QWL Poll Case 3    [Documentation]    Answers QWL Poll with negative answers and can be reproduced with seed.
    QWL Poll    NEQATIVE    42    ${NONE}
Answer QWL Poll Case 4    [Documentation]    Answers QWL Poll with positive answers only
    QWL Poll    POSITIVE    ${NONE}    ${NONE}