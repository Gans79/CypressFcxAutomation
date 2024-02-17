Feature: Create Primary Cap Raise
  As PX Admin, I want to create Primary Cap Raise

  @TestCaseKey=PLX-1028
  Scenario Outline: As a Fcx Admin, Create primary cap raise [status=draft]
    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Cap-Raises' is pressed
    And in FCX Admin Cap Raise view, 'Create New Raise' is pressed
    And in Create New Raise view pop-up, '<Company Name>' is entered into Issuer
    And in Create New Raise view pop-up, '<Label>' is entered into Label
    And in Create New Raise view pop-up, '<Raise Type>' is selected for Raise Type
    And in Create New Raise view pop-up, 'Create' is pressed
    Then in FCX Admin Cap Raises view table, display details
       | Issuer          | Raise Type    | Label             | S708     | Creation Date | Status | 
       | <Company Name>  | <Raise Type>  | Primary Cap Raise | Required | [Today]      | Draft  |

    @CapRaiseSmoke @DEV 
    Examples:
      | Admin   | Company Name     | Raise Type     | Label             |
      | PXAdmin | FCX-Capraise Co  | Primary        | Primary Cap Raise | 

    @CapRaiseSmoke @TEST 
    Examples:
      | Admin   | Company Name     | Raise Type     | Label             |
      | PXAdmin | FCX-Capraise Co  | Primary        | Primary Cap Raise | 


@TestCaseKey=PLX-1030
  Scenario Outline: As a Owner, Edit Primary Cap Raise details
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed
    And in Details view tab 'Edit' is pressed
    And in Cap Raise Details view pop-up, '<Overview>' is entered into Overview
    And in Cap Raise Details view pop-up, Security section '<Security ID>' is selected 
    And in Cap Raise Details view pop-up, Price section 'Fixed' is selected and '<Price>' is entered
    And in Cap Raise Details view pop-up, Legal Documents section '<Signatory1 Name>' and '<Signatory1 Email>' is entered
    And in Cap Raise Details view pop-up, 'Save' is pressed
   Then in Primary Raise view, hover over Progress bar in Draft, Cap Raise Details is ticked
    

  @DEV 
  Examples:
      | Participant | Company                | Investor Name | Overview  | Security ID | Price | Signatory1 Name | Signatory1 Email                     |
      | owner       | CYPRESS-FCX Trading Co | FCX OWNER     | Test      | ORD1        | 15    | Fcx Owner       | fcx.dev.tester+owner@finclear.com.au |

  @TEST
  Examples:
      | Participant | Company                 | Investor Name | Overview  | Security ID | Price | Signatory1 Name | Signatory1 Email                     |
      | owner       | CYPRESS-FCX Trading Co  | FCX OWNER     | Test      | ORD1        | 15    | Fcx Owner       | fcx.test.tester+owner@finclear.com.au |


@TestCaseKey=PLX-1031
  Scenario Outline: As a Owner, Upload General Documents
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed
    And in Primary Raise view, Documents & Media tab is pressed
    And in Documents & Media view tab, Documents section, upload is pressed
    And in Upload New Document view pop-up, '<Document name>', '<Document Type>' and '<Document>' entered and click upload
   Then in Primary Raise view, hover over Progress bar in Draft, Add Docs & Media is ticked
    And in Documents & Media view tab, General Documents section, '3 Dots' is clicked and 'Publish Document' is pressed
    And in Publish Document view pop-up, 'Publish' is pressed
   Then in Documents & Media view table, display details
    | Document Name | Linked to Q&A   | Published  | Archived | Date Uploaded | 
    | General Doc   |                 | checked    |          | [Today]       |


  @DEV 
  Examples:
      | Participant | Company                | Document name | Document Type | Document      |                     
      | owner       | CYPRESS-FCX Trading Co | General Doc   | General       | Fcx_General_Doc.PDF | 
  @TEST
  Examples:
      | Participant | Company                | Document name | Document Type | Document      |     
      | owner       | CYPRESS-FCX Trading Co | General Doc   | General       | Fcx_General_Doc.PDF | 


@TestCaseKey=PLX-1032
  Scenario Outline: As a Owner, Add investors
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed
    And in Primary Raise view, Investors Tab is pressed
    And in Investors tab view, Investors section, 'Add investor Action' is pressed
    And in Add investor view pop-up, '<Investor Name>', '<Investor Email>' entered and Add is pressed
   Then in Primary Raise view, hover over Progress bar in Draft, Add Investors is ticked
    

  @DEV 
  Examples:
      | Participant | Company                | Investor Name | Investor Name | Investor Email | 
      | owner       | CYPRESS-FCX Trading Co | FCX OWNER     | Fcx Investor4 | Fcx.Dev.Tester+Investor4@finclear.com.au |
      
  @TEST
  Examples:
      | Participant | Company                | Investor Name | Investor Name | Investor Email |                
      | owner       | CYPRESS-FCX Trading Co | FCX OWNER     | Fcx Investor4 | Fcx.Test.Tester+Investor4@finclear.com.au |


@TestCaseKey=PLX-1033
  Scenario Outline: As a Owner, Fill out Q&A forms 
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed
    And in Primary Raise view, Q & A Tab is pressed
    And in Q & A tab view, Questions and Answers section, 'Add New Q&A' is pressed
    And in Add New Q & A view pop-up, '<Question>', '<Answer>' entered and Save is pressed
   Then in Primary Raise view, hover over Progress bar in Draft, Fill out Q&As is ticked
    

  @DEV 
  Examples:
      | Participant | Company                | Question  | Answer  |
      | owner       | CYPRESS-FCX Trading Co | Question1 | Answer1 |
      
  @TEST
  Examples:
      | Participant | Company                | Question  | Answer  |           
      | owner       | CYPRESS-FCX Trading Co | Question1 | Answer1 |

@TestCaseKey=PLX-1034
  Scenario Outline: As a Owner, Draft Signatory Sign-off
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed
    And in Primary Raise view, Signatory Tab is pressed
    And in Signatory tab view, Draft Sign-Off section, 'Approve' is pressed
    And in Approve Cap Raise Stage view pop-up, 'Approve' is pressed
   Then in Primary Raise view, hover over Progress bar in Draft, Signatory Sign-Off is ticked
    

  @DEV 
  Examples:
      | Participant | Company                | 
      | owner       | CYPRESS-FCX Trading Co |
      
  @TEST
  Examples:
      | Participant | Company                |         
      | owner       | CYPRESS-FCX Trading Co |


@TestCaseKey=PLX-1035
  Scenario Outline: As a Owner, Progress to Application
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed 
    And in Primary Raise view, hover over Progress bar in Draft, Progress to Application is pressed
  Then in Primary Raise view, hover over Progress bar in Application, Application is highlighted


  @DEV 
  Examples:
      | Participant | Company                | 
      | owner       | CYPRESS-FCX Trading Co |
      
  @TEST
  Examples:
      | Participant | Company                |         
      | owner       | CYPRESS-FCX Trading Co |


@TestCaseKey=PLX-1038
  Scenario Outline: As a Owner, Send invite to investor
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed 
    And in Primary Cap Raise view, Investors Tab is pressed
    And in Investors tab view, '3 Dots' is pressed
    And in Investors tab view, 'Send Invite' is pressed
  Then in Investors tab view table, display details
       | Investor Name  | Email   | Offer| Date Invited  | Invited By | Invite Status | 
       | Fcx Investor4  | <Email> |      | [Today]       | <Owner>    | Created       | 


  @DEV 
  Examples:
      | Participant | Company                | Email                                    | Owner  |
      | owner       | CYPRESS-FCX Trading Co | FCX.DEV.TESTER+INVESTOR4@FINCLEAR.COM.AU | fcx.dev.tester+owner@fnclear.com.au |
      
  @TEST
  Examples:
      | Participant | Company                | Email                                     | Owner  |    
      | owner       | CYPRESS-FCX Trading Co | FCX.TEST.TESTER+INVESTOR4@FINCLEAR.COM.AU | fcx.dev.tester+owner@fnclear.com.au |


@TestCaseKey=PLX-1039
  Scenario Outline: As an Investor, Accept the Cap raise invite
   Given '<Participant>' is logged in to FCX 'App'
    And Wallet owner, click on view your invite from email for <Investor Name>
    When inside Deal Room Invitations, Accept the invite
    And in Accept Cap Raise view pop-up, 'Accept' is pressed
    Then inside Deal Room Invitations view, Company invitation is not displayed

  @DEV @TEST
    Examples:
      | Participant | Investor Name | 
      | investor1   | FCX INVESTOR1 | 

@TestCaseKey=PLX-1040
  Scenario Outline: As an Investor, Create an offer application
   Given '<Participant>' is logged in to FCX 'App'
    And in Active Deal Rooms, <Company> tile is pressed
    And in Primary Cap Raise investor view, Application Tab is pressed
    And in Application tab investor view, 'Add Application' is pressed
    And in Application tab investor view, 'Please Select a Wallet' is pressed and '<Wallet Name>' is seleted
    And in Application tab investor view, 'No of securities' is selected and '<Securities>' is seleted and 'Create' is pressed
   Then in Application tab investor view, display details
      | Security Id | Price | No of Securities  | Total Estimated Value  | Total Fees | Total Amount| 
      | ORD1        | $15   | 250               | $3,750.00              | -          | $3,750.00   |


  @DEV @TEST
    Examples:
      | Participant | Investor Name | Company                  | Wallet Name   | Securities | 
      | investor1   | FCX INVESTOR1 | CYPRESS-FCX Trading Co   | FCX INVESTOR4 | 250        |

@TestCaseKey=PLX-1041
  Scenario Outline: As a Owner, Upload legal doc with sign 
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed 
    And in Primary Raise view, Documents & Media tab is pressed
    And in Documents & Media view tab, Documents section, upload is pressed
    And is Upload New Document view pop-up, '<Document name>', '<Document Type>', Issuer signature required is '<Issuer checkbox>' and '<Document>' entered and click upload
  Then in Primary Raise view, hover over Progress bar in Application, Investor legal document added is ticked
    And in Documents & Media view tab, Legal Documents section, '3 Dots' is clicked and 'Publish Document' is pressed
    And in Publish Document view pop-up, 'Publish' is pressed
   Then in Documents & Media view table, display details
    | Document Name | Signature Required | Linked to Q&A | Published  | Archived | Date Uploaded | 
    | Legal Doc     | Issuer Investor    |               | checked    |          | [Today]       |


  @DEV @TEST
  Examples:
      | Participant | Company                | Document name | Document Type | Document          | Issuer checkbox |    
      | owner       | CYPRESS-FCX Trading Co | Legal Doc     | Legal         | Fcx_Legal_Doc.PDF | checked         |
  

@TestCaseKey=PLX-1042
  Scenario Outline: As a Owner, Application Signatory Sign-off
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed
    And in Primary Raise view, Signatory Tab is pressed
    And in Signatory tab view, Application Sign-Off section, 'Approve' is pressed
    And in Approve Cap Raise Stage view pop-up, 'Approve' is pressed
   Then in Primary Raise view, hover over Progress bar in Application, Signatory Sign-Off is ticked


  @DEV @TEST
  Examples:
      | Participant | Company                | Document name | Document Type | Document          | Issuer checkbox |    
      | owner       | CYPRESS-FCX Trading Co | Legal Doc     | Legal         | Fcx_Legal_Doc.PDF | checked         |
      

@TestCaseKey=PLX-1043
  Scenario Outline: As a Owner, Carry over application to actual
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed
    And in Primary Raise view, Offer Tab is pressed
    And in Offer tab view, '3 Dots' is pressed next to '<Investor>' and 'carry over application' is pressed
    And in Carry over Application values to Actual view pop-up, 'Confirm' is pressed
   Then in Offer tab view, display details
      | Name          | No of Securities | Value      | Firm  | No of Securities | Value       | Investor      | 
      | Fcx Investor4 | 250              | $3,750.00  |       | 250              | $3,750.00   | Fcx Investor4 |  


  @DEV @TEST
  Examples:
      | Participant | Company                | Document name | Document Type | Document          | Issuer checkbox |     
      | owner       | CYPRESS-FCX Trading Co | Legal Doc     | Legal         | Fcx_Legal_Doc.PDF | checked         |


@TestCaseKey=PLX-1044
  Scenario Outline: As a Owner, Progress to Subscription
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed 
    And in Primary Raise view, hover over Progress bar in Application, Progress to Subscription is pressed
  Then in Primary Raise view, hover over Progress bar in Subscription, Subscription is highlighted


  @DEV @TEST
  Examples:
      | Participant | Company                | 
      | owner       | CYPRESS-FCX Trading Co |
      

@TestCaseKey=PLX-1045
  Scenario Outline: As an Investor, Accept the offer
   Given '<Participant>' is logged in to FCX 'App'
    And in Active Deal Rooms, <Company> tile is pressed
    And in Primary Cap Raise investor view, Subscription Tab is pressed
    And in Subscription tab investor view, 'Sign' is pressed
    And in Sign Offer view pop-up, 'Confirm' is pressed
    And in Offer Document Sent view pop-up, 'Done' is pressed
   Then in Application tab investor view, display details
      | Security Id | Price | No of Securities  | Total Estimated Value  | Total Fees | Total Amount| Name               | Email   | Signed   | Signed Date | 
      | ORD1        | $15   | 250               | $3,750.00              | -          | $3,750.00   | FCX MID4 INVESTOR4 | <Email> |          |             |

  @DEV 
    Examples:
      | Participant | Investor Name | Company                  | Wallet Name   | Securities | Email | 
      | investor1   | FCX INVESTOR1 | CYPRESS-FCX Trading Co   | FCX INVESTOR4 | 250        | FCX.DEV.TESTER+INVESTOR4@FINCLEAR.COM.AU |

  @TEST
    Examples:
      | Participant | Investor Name | Company                  | Wallet Name   | Securities | Email | 
      | investor1   | FCX INVESTOR1 | CYPRESS-FCX Trading Co   | FCX INVESTOR4 | 250        | FCX.TEST.TESTER+INVESTOR4@FINCLEAR.COM.AU |

@TestCaseKey=PLX-1046
  Scenario Outline: As an Investor, I can complete Docusign
   Given '<Participant>' is logged in to FCX 'App'
    And in Active Deal Rooms, <Company> tile is pressed
    And in Primary Cap Raise investor view, Subscription Tab is pressed
    And investor review and signs Docusign for <Investor Name> and <Email>
    Then in Subscription tab investor view, displays details 
      | Security Id | Price | No of Securities  | Total Estimated Value  | Total Fees | Total Amount| Name               | Email   | Signed   | Signed Date | 
      | ORD1        | $15   | 250               | $3,750.00              | -          | $3,750.00   | FCX MID4 INVESTOR4 | <Email> | checked  | [Today]     |


  @DEV @run
    Examples:
      | Participant | Company                | Email                                    | 
      | Investor11  | CYPRESS-FCX Trading Co | fcx.dev.tester+investor4@finclear.com.au | 

  @TEST @run
    Examples:
      | Participant| Company                | Email                                     | 
      | Investor1  | CYPRESS-FCX Trading Co | fcx.test.tester+investor4@finclear.com.au | 



@TestCaseKey=PLX-1047
  Scenario Outline: As a Owner, Subscription Signatory Sign-off
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed
    And in Primary Raise view, Signatory Tab is pressed
    And in Signatory tab view, Subscription Sign-Off section, 'Approve' is pressed
    And in Approve Cap Raise Stage view pop-up, 'Approve' is pressed
   Then in Primary Raise view, hover over Progress bar in Application, Signatory Sign-Off is ticked


  @DEV @TEST
  Examples:
      | Participant | Company                | Document name | Document Type | Document          | Issuer checkbox |    
      | owner       | CYPRESS-FCX Trading Co | Legal Doc     | Legal         | Fcx_Legal_Doc.PDF | checked         |
      

@TestCaseKey=PLX-1048
  Scenario Outline: As a Owner, Progress to Closed
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed 
    And in Primary Raise view, hover over Progress bar in Subscription, Progress to Closed is pressed
  Then in Primary Raise view, hover over Progress bar in Closed, Closed is highlighted


  @DEV @TEST
  Examples:
      | Participant | Company                | 
      | owner       | CYPRESS-FCX Trading Co |
      

@TestCaseKey=PLX-1049
  Scenario Outline: As a Owner, Approve Settlement
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed 
    And in Primary Raise view, Offer Tab is pressed
    And in Offer tab view, 'Approve Settlement' is pressed
    And in Approve Settlement view pop-up, 'Send' is pressed
    And in Email sent view pop-up, 'Done' is pressed
   Then in Offer tab view, Stettlement section '<Message>' is shown


  @DEV @TEST
  Examples:
      | Participant | Company                | Message                       | 
      | owner       | CYPRESS-FCX Trading Co | Settlement approval has begun | 
      

@TestCaseKey=PLX-1050
  Scenario Outline: As an Owner, I can complete Cap Raise Docusign
   Given '<Participant>' is logged in to FCX 'App'
    And in Active Deal Rooms, <Company> tile is pressed
    And owner review and signs Docusign for <Participant> and <Email>
    Then in Subscription tab investor view, displays details 
      | Security Id | Price | No of Securities  | Total Estimated Value  | Total Fees | Total Amount| Name               | Email   | Signed   | Signed Date | 
      | ORD1        | $15   | 250               | $3,750.00              | -          | $3,750.00   | FCX MID4 INVESTOR4 | <Email> | checked  | [Today]     |


  @DEV @run
    Examples:
      | Participant | Company                | Email                                    | 
      | owner       | CYPRESS-FCX Trading Co | fcx.dev.tester+owner@finclear.com.au | 

  @TEST @run
    Examples:
      | Participant| Company                | Email                                     | 
      | owner      | CYPRESS-FCX Trading Co | fcx.test.tester+owner@finclear.com.au | 


@TestCaseKey=PLX-1051
  Scenario Outline: As a Owner, Finalise the settlement
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed 
    And in Primary Raise view, Offer Tab is pressed
    And in Offer tab view, Settlement section, 'Final Settlement' is pressed
    And in Final Settlement view pop-up, 'Confirm' is pressed
    And in Final Settlement view pop-up, 'Done' is pressed
    And in Primary Raise view, hover over Progress bar in Closed, Settlement is ticked
   Then in Offer tab view, Settlement section displays details 
      | No of Securities| Gross Amount| FCX Fee  | Other Fees  | Total Available Cash | 
      | 250             | $3,750.00   | $0.00    | $0.00       | $3,750.00            |


  @DEV @TEST
  Examples:
      | Participant | Company                | 
      | owner       | CYPRESS-FCX Trading Co |
      

@TestCaseKey=PLX-1052
  Scenario Outline: As a Owner, I can finalise cap raise [status=finalised]
   Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'Capital Raising' is pressed
    And company menu 'All Cap Raises' is pressed
    And in Capital Raising view, 'Primary Cap Raise' is pressed 
    And in Primary Raise view, hover over Progress bar in Closed, Finalise Cap Raise is pressed
  Then in Primary Raise view, hover over Progress bar in Finalised, Finalised is highlighted


  @DEV @TEST
  Examples:
      | Participant | Company                | 
      | owner       | CYPRESS-FCX Trading Co |
      
