@PLX-2373
Feature: ESOP Manage offers - (Participants Tab)

  Background: Issuer with ESOP Role is logged in to FCX App

  @TestCaseKey=PLX-T589
  Scenario Outline: As an Issuer user with ESOP role, I want to be able to close off an open offer manually so that offer can proceed to issuance state

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in ESOP offer, current status is Open
    And in ESOP offer page, hover on status 'Open'
    When in 'Open' status pop-up, 'Progress to Close' button is pressed
    And alert pop-up, Close Offer, 'Close' is pressed
    And alert pop-up, Close Offer Confirmation, 'Confirm' is pressed
    And in ESOP offer, current status is Closed
    Then 'Participants' table, displays details
      | Participant          | Department  | Email    | Invite Status | Invite Date | No. of Securities | Accepted | Issued |
      | Fcx Tester Employee1 |             | <Email>  | Accepted      | [Today]     | 1,000             | dash     |        |

   @ESOPSmoke @ESOPRegression @PLX-3168 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Email                           | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | fcx.tester+employee1@gmail.com  |

   @ESOPSmoke @ESOPRegression @PLX-3168 @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Email                                      | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | fcx.test.tester+employee1@finclear.com.au  |

  @TestCaseKey=PLX-T589
  Scenario Outline: As an Issuer user with ESOP role, I want to be able to close off an open offer manually so that offer can proceed to issuance state

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in ESOP offer, current status is Open
    And in ESOP offer page, hover on status 'Open'
    When in 'Open' status pop-up, 'Progress to Close' button is pressed
    And alert pop-up, Close Offer Confirmation, 'Confirm' is pressed
    And in ESOP offer, current status is Closed
    Then 'Participants' table, displays details
      | Participant          | Department  | Email    | Invite Status | Invite Date | No. of Securities | Accepted | Issued |
      | Fcx Tester Employee1 |             | <Email>  | Accepted      | [Today]     | 1,500             | check    |        |

   @ESOPSmoke @ESOPRegression @PLX-3168 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Email                           |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | fcx.tester+employee1@gmail.com  |

   @ESOPSmoke @ESOPRegression @PLX-3168 @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Email                                     |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | fcx.test.tester+employee1@finclear.com.au |

  @TestCaseKey=PLX-T749
  Scenario Outline: As an Issuer user with ESOP role, I want to be issue securities and verify offer is finalised

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    When in 'Participants' tab, 'Issue Securities' is pressed
    And alert pop-up, Confirm Security Issuance, 'Confirm' is pressed
    And alert pop-up, Congratulations!, 'Done' is pressed
    And in ESOP offer, current status is Finalised
    Then 'Participants' table, displays details
      | Participant          | Department  | Email   | Invite Status | Invite Date | No. of Securities | Accepted | Issued |
      | Fcx Tester Employee1 |             | <Email> | Accepted      | [Today]     | 1,500             | check    | check  |
   
   @ESOPSmoke @ESOPRegression @PLX-3168 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Email                           | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | fcx.tester+employee1@gmail.com  |

   @ESOPSmoke @ESOPRegression @PLX-3168 @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Email                                     |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | fcx.test.tester+employee1@finclear.com.au |

   @TestCaseKey=PLX-T687
   Scenario Outline: As a Participant I want to access the ESOP space | Offer status = closed | 

    Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And investor menu 'My ESOP Offers' is pressed
    And inside Participant Offers, <Offer Name> tile is pressed
    And inside Participant Offer, 'My Offer' tab is pressed
    Then inside Participant 'My Offer' tab, displays details for status 'closed'
      | Offer Name   | Plan Name   | Security Class | Number of Securities | 
      | <Offer Name> | <Plan Name> | ESOP ORD1      | 1,000                | 
    And inside Participant Offer, 'Details' tab is pressed
    Then inside Participant 'Details' tab, displays details for status 'closed'
      | Plan Name    | Offer Description              | Security | Grant Date | Vesting Schedule              | Description                    | 
      | <Plan Name> | ESOP5 Offer 1 closing manual   | ESOP5    | dash         | No Vesting Schedule include | ESOP5 Offer 1 closing manual |
    And inside Participant Offer, 'Documents & Media' tab is pressed
    Then inside Participant 'Documents & Media' tab, displays details for status 'closed'
      | Document Name | Date Uploaded |
      | Legal Doc 5   | [Today]       |
    And inside Participant Offer, 'Q & A' tab is pressed
    Then inside Participant 'Q & A' tab, 'Add' option is not available


   @ESOPSmoke @ESOPRegression @DEV @TEST @run
    Examples:
      | Participant           | Company       | Plan Name                    | Offer Name                          | Participant          | No of securities |
      | Participant_employee1 | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx Tester Employee1 | 1000             |


  @TestCaseKey=PLX-T700
  Scenario Outline: I cannot amend an [offer status] = Closed

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in ESOP offer, current status is Closed
    Then 'Participants' table, displays details
      | Participant          | Department  | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | Fcx Tester Employee1 |             | <Email> | [Today]     | Accepted      | 1,000             |          |        |
    And in ESOP offer, 'Participants' section securities is non editable
    

   @ESOPSmoke @ESOPRegression @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Participant          | Email  | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx Tester Employee1 | fcx.tester+employee1@gmail.com  | 

   @ESOPSmoke @ESOPRegression @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Participant          | Email | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx Tester Employee1 | fcx.test.tester+employee1@finclear.com.au |

  @TestCaseKey=PLX-T667 
  Scenario Outline: As an Issuer user with ESOP role, I want to be able to re-open a closed offer so that I can add additional participants to the offer

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in ESOP offer, current status is Closed
    And in ESOP offer page, hover on status 'Closed'
    When in 'Closed' status pop-up, 'Re-Open' button is pressed
    And in ESOP offer, current status is Open
    Then 'Participants' table, displays details
      | Participant          | Department  | Email   | Invite Status | Invite Date | No. of Securities | Accepted | Issued |
      | Fcx Tester Employee1 |             | <Email> | Accepted     | [Today]     | 1,000             | dash     |        |

   @ESOPSmoke @ESOPRegression @PLX-3167 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Email  | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | fcx.tester+employee1@gmail.com  | 

   @ESOPSmoke @ESOPRegression @PLX-3167 @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Email | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | fcx.test.tester+employee1@finclear.com.au |

  @PLX-3170 
  Scenario Outline: Export Participants
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Participants' tab, 'Export Table' action is selected
    Then verify '<File Name>' file is downloaded
    And downloaded csv file '<File Name>' has header row
      | "First Name" | "Middle Name" | "Last Name" | "Department" | "Email" | "Invite Date" | "Invite Status" | "No. of Securities" | "Accepted" | "Issued" |
    And downloaded csv file '<File Name>' has data row
      | "13GoodData"            | "MiddleNameL" | "LastnameL" | "DepartmentL" | "deborah.dowson+2@fincleartech.com.au" | "" | "Not Sent" | "2000" | "Pending" | "Not Issued" |
      | "12RepeatedEmailAF"     | ""            | "LastnameK" | "DepartmentK" | "emailAA@gmail.com"                    | "" | "Not Sent" | "1000" | "Pending" | "Not Issued" |
      | "2MandatoryFields"      | ""            | "LastnameA" | ""            | "emailA@gmail.com"                     | "" | "Not Sent" | ""     | "Pending" | "Not Issued" |
      | "3AllFields"            | "MiddlenameB" | "LastnameB" | "DepartmentB" | "emailB@gmail.com"                     | "" | "Not Sent" | "500"  | "Pending" | "Not Issued" |
      | "4InvalidEmailF"        | ""            | "LastnameC" | ""            | "emailC@gmail.com"                     | "" | "Not Sent" | ""     | "Pending" | "Not Issued" |
      | "5MissingLastnameF"     | ""            | "LastnameD" | ""            | "emailD@gmail.com"                     | "" | "Not Sent" | ""     | "Pending" | "Not Issued" |
      | "6MissingEmailF"        | ""            | "LastnameE" | ""            | "emailE@gmail.com"                     | "" | "Not Sent" | ""     | "Pending" | "Not Issued" |
      | "7MissingAddressLine1F" | ""            | "LastnameF" | ""            | "emailF@gmail.com"                     | "" | "Not Sent" | ""     | "Pending" | "Not Issued" |
      | "8MissingSuburbF"       | ""            | "LastnameG" | ""            | "emailG@gmail.com"                     | "" | "Not Sent" | ""     | "Pending" | "Not Issued" |
      | "9MissingStateF"        | ""            | "LastnameH" | ""            | "emailH@gmail.com"                     | "" | "Not Sent" | ""     | "Pending" | "Not Issued" |
      | "10MissingCountryF"     | ""            | "LastnameI" | ""            | "emailI@gmail.com"                     | "" | "Not Sent" | ""     | "Pending" | "Not Issued" |
      | "11ZeroSecuritiesF"     | ""            | "LastnameJ" | ""            | "emailJ@gmail.com"                     | "" | "Not Sent" | "1"    | "Pending" | "Not Issued" |
      | "14GoodData"            | ""            | "LastnameM" | "DepartmentM" | "emailM@gmail.com"                     | "" | "Not Sent" | "3000" | "Pending" | "Not Issued" |
      | "Test"                  | "Dev"         | "Employee2" | "Engineering" | "fcx.tester+employee2@gmail.com"       | "" | "Not Sent" | "3000" | "Pending" | "Not Issued" |

    @TestCaseKey=PLX-T431 @DEV @TEST @run 
    Examples: 
      | Issuer | Company       | Plan Name                    | Offer Name                  | File Name                                     |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | CYPRESS-ESOP Offer 1 Manual_Participants_DDMMYYYY.csv |

  @PLX-3164 @Regression
  Scenario Outline: Issuer user with ESOP role can provide user with a new offer or amend their offers
    AC1- Given that: (PLX-3164)
    + Offer status is either “Setup” or “Open” and
    + user has ESOP role and
    + individual offer status is “Pending” and
    + approval process (DocuSign) has NOT been initiated the
    user can amend the current offer by providing a new offer
    + current offer will be cancelled and replaced by the new one

    When in ESOP offer, in <Offer Status> status
    And 'Participants' table, displays details
      | Participant                             | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> | [Today]     | Not Sent      |            10,000 |          |        |
    And in 'Participants' table, 'No. of Securities' changed to '8000' for
      | Participant                             | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> | [Today]     | Not Sent      |            10,000 |          |        |
    And in 'Confirm New Offer' pop-up, 'CURRENT OFFER WILL BE CANCELLED' is displayed
    And in 'Confirm New Offer' pop-up, 'New Offer' of '8,000 Securities' is displayed
    And in 'Confirm New Offer' pop-up, 'Current Offer' of '10,000 Securities' is displayed
    And in 'Confirm New Offer' pop-up, 'Send this Participant an email notifying their offer has been updated' checkbox is checked
    And in 'Confirm New Offer' pop-up, 'Updating offer' is entered in 'Enter reason (Optional)'
    And in 'Confirm New Offer' pop-up, 'Confirm' is pressed
    Then 'Participants' table, displays details
      | Participant                             | Department   | Email   | Invite Date | Invite Status | FNo. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> | [Today]     | Cancelled     |             10,000 |          |        |
    And 'Participants' table, displays details
      | Participant                             | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> | [Today]     | Not Sent      |            10,000 |          |        |

    @TestCaseKey=PLX-T379 @DEV @TEST 
    Examples: 
      | Issuer | Company       | Plan Name                    | Offer Name                         | Offer Status | First Name | Middle Names | Last Name | Position | Department  | Work Number | Email                          | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Cloned | Setup        | Test       | Dev          | Investor1 | Test Bot | Engineering |             | fcx.tester+employee1@gmail.com | Level 8        |  5 Mill Street | Perth  | Western Australia |     6000 | Australia |       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Auto Updated  | Open         | Test       | Dev          | Investor1 | Test Bot | Engineering |             | fcx.tester+employee1@gmail.com | Level 8        |  5 Mill Street | Perth  | Western Australia |     6000 | Australia |       |

  Scenario: AC2- Given that: (PLX-3342)
  + Offer status is either “Open” and
  + user has ESOP role and
  + individual offer status is “Pending” and
  + approval process (DocuSign) has been initiated the
  user can amend the current offer by providing a new offer
  this results in:
  + user being able to notify the participant of amendment (optional)
  ++ they can optionally provide a reason
  ++ (“send email notification” is ticked by default)
  + the current pending offer being cancelled and
  ++ all the pending/ signed DocuSign requests being cancelled - (parties will not be able to sign a cancelled offer documents) and
  + a new offer in pending state being created for the participant

  Scenario: If the individual offer status is: “Accepted”, “Declined” or “Cancelled”
  AC3- Given that: (PLX-3342)
  + Offer status is either “Open” and
  + user has ESOP role and
  + individual offer status is “Accepted”/ “Declined”/ “Cancelled”
  user can amend the current offer by providing a new offer
  this results in:
  + user being able to notify the participant of amendment (optional)
  ++ they can optionally provide a reason
  ++ “send email notification” is ticked by default
  + the current pending offer being cancelled and
  ++ pervious acceptance/ decline / cancellation will be void (and green tick/ red cross/ expiry icon against “acceptance” column will disappear)
  + a new offer in pending state being created

  Scenario: AC4- If an offer is amended, the most recent offer must be displayed in Participants table (PLX-3164 / PLX-3342)

  Scenario: If the offer is Issued: User cannot amend offer for an “issued” record (if individual offer status = issued)
  AC5- User cannot amend offer (update “Number of Securities”) for an “issued” record (if individual offer status = issued) (PLX-3342)

  Scenario: AC6- Issuer user cannot amend participants' offers if they do not have ESOP role.  (PLX-3164)

  Scenario: AC7- Issuer user cannot provide/amend participants' offers if offer status is “Closed” or “Finalised”.  (PLX-3164)

  Scenario: AC8- Given that: (PLX-3164)
    + offer status is “Setup” and
    + “Number of securities” is blank
    + user has ESOP role
    user can provide participant with an offer by populating “Number of securities”
    + (as part of “Edit” function- must be integer , greater than 0)

    Examples: 
      |  |
