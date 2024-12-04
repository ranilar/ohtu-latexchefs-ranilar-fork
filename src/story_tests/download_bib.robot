*** Settings ***
Resource        resource.robot
Suite Setup     Open And Configure Browser
Suite Teardown  Close Browser
Test Setup      Reset Application And Go To List Of References Page

*** Variables ***
${WAIT_TIME}          10 

*** Test Cases ***
Download Bib File For A Single Reference
    Submit Valid Filled Out Book Form     Test Authors    Test Title    2000    Test Publisher  Test Editor  Test-Ref-Key-1
    Toggle BibTeX format
    Wait Until Element Is Visible  class:bibtex-container
    Click Link  Download
    Wait Until File Exists  ~/Downloads/Test-Ref-Key-1.bib
    File Should Exist  ~/Downloads/Test-Ref-Key-1.bib

Download Bib File For All References
    Submit Valid Filled Out Book Form     Test Authors    Test Title    2000    Test Publisher  Test Editor  Test-Ref-Key-1
    Submit Valid Filled Out Book Form     Other Authors    Other Title    2000    Other Publisher  Other Editor  Other-Ref-Key-1
    Toggle BibTeX format
    Wait Until Element Is Visible  class:bibtex-container
    Click Link  Download All References
    Wait Until File Exists  ~/Downloads/allreferences.bib
    File Should Exist  ~/Downloads/allreferences.bib

*** Keywords ***
Reset Application And Go To List Of References Page
    Reset Database
    Go To List Of References Page

Submit Valid Filled Out Book Form 
    [Arguments]  ${authors}  ${title}  ${year}  ${publisher}  ${editor}  ${reference_key}
    Go To Add New Book Reference Page
    Input Text  name=authors  ${authors}
    Input Text  name=title  ${title}
    Input Text  name=year  ${year}
    Input Text  name=publisher  ${publisher}
    Input Text  name=editor  ${editor}
    Input Text  name=reference_key  ${reference_key}
    Click Button  Submit
    Go To List Of References Page

Toggle BibTeX format
    Click Button    Toggle BibTeX format

Wait Until File Exists
    [Arguments]    ${path}    ${timeout}=10
    Wait Until Keyword Succeeds    ${timeout}    1s
    ...    File Should Exist    ${path}