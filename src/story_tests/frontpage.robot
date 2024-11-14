*** Settings ***
Resource  resource.robot
Suite Setup     Open And Configure Browser
Suite Teardown  Close Browser
Test Setup      Reset Application And Go To Front Page

*** Test Cases ***
Click To Selector Link
    Click Link  To selector
    Selector Page Should Be Open

*** Keywords ***
Reset Application And Go To Front Page
    Go To Front Page
    # Resetointia ei ole vielä implementoitu