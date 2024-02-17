@PLX-2713
Feature: ESOP- Manage participants - (Participants Tab)

  @TestCaseKey=PLX-T406 
  Scenario Outline: I want to be able to send an invite to all or selected participant

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in ESOP offer, current status is Open
    Then 'Participants' table, displays details
      | Participant     | Department  | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <Participant>   |             | <Email> |             | Not Sent      | <Securities>      |          |        |
    And in ESOP offer, <Participant> section, more 'Send Invite' is pressed for <Offer Name>
    Then 'Participants' table, displays details
      | Participant     | Department  | Email    | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <Participant>   |             | <Email>  | [Today]     | Invited       | <Securities>      |          |        |
  
   @ESOPSmoke @ESOPRegression @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Participant          | Securities | Email                          | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx Tester Employee1 | 1,000      | fcx.tester+employee1@gmail.com |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx Tester Employee1 | 1,200      | fcx.tester+employee1@gmail.com |

   @ESOPSmoke @ESOPRegression @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Participant          | Securities | Email                                     |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx Tester Employee1 | 1,000      | fcx.test.tester+employee1@finclear.com.au |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx Tester Employee1 | 1,200      | fcx.test.tester+employee1@finclear.com.au |
      

  @TestCaseKey=PLX-T654
  Scenario Outline: As a Participant I want to accept an invite

    Given '<Participant>' is logged in to FCX 'App'
    And ESOP Participant, click on view your invite from email for <Offer Name>
    When inside Participant Offers, Accept the invite
    Then inside Participant Offers, ESOP invitation is not displayed

   @ESOPSmoke @ESOPRegression @DEV @TEST @run
    Examples:
      | Participant           | Company       | Offer Name |
      | Participant_employee1 | IC Trading Co | CYPRESS-ESOP Offer 1 Closed Manual |
      | Participant_employee1 | IC Trading Co | CYPRESS-ESOP Offer 2 Closed Auto   |


  @TestCaseKey=PLX-T695
  Scenario Outline: I want to be able to amend an accepted offer  

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in ESOP offer, current status is Open
    Then 'Participants' table, displays details
      | Participant    | Department  | Email    | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <Participant>  |             | <Email>  | [Today]     | Accepted      | 1,200             |          |        |
    And in ESOP offer, status is 'Open', 'Participants' section securities updated to <No of securities>
    Then 'Participants' table, displays details
      | Participant    | Department  | Email    | Invite Date | Invite Status | No. of Securities   | Accepted | Issued |
      | <Participant>  |             | <Email>  | [Today]     | Accepted      | <No of securities>  |          |        |

   @ESOPSmoke @ESOPRegression @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Participant          | No of securities | Email                          | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx Tester Employee1 | 1,500            | fcx.tester+employee1@gmail.com | 

   @ESOPSmoke @ESOPRegression @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Participant          | No of securities | Email                                     | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx Tester Employee1 | 1,500            | fcx.test.tester+employee1@finclear.com.au |

  @TestCaseKey=PLX-T695
  Scenario Outline: As a Participant I want to view the amended offer  

    Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And investor menu 'My ESOP Offers' is pressed
    And inside Participant Offers, <Offer Name> tile is pressed
    And inside Participant Offer, 'My Offer' tab is pressed
    Then inside Participant 'My Offer' tab, displays details for status 'pending'
      | Securities | Security Class | Status   |
      | 1,500      | ESOP           | Pending  |

  @ESOPSmoke @ESOPRegression @DEV @TEST @run
    Examples:
      | Participant           | Company       | Plan Name                    | Offer Name                          | No of securities |
      | Participant_employee1 | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | 1500             |

  @TestCaseKey=PLX-T680
  Scenario Outline: As a Participant I want to access the ESOP space | Offer status = open | 

    Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And investor menu 'My ESOP Offers' is pressed
    And inside Participant Offers, <Offer Name> tile is pressed
    And inside Participant Offer, 'My Offer' tab is pressed
    Then inside Participant 'My Offer' tab, displays details for status 'open'
      | Offer Name   | Plan Name   | Security Class | Number of Securities | Accept  | Decline | 
      | <Offer Name> | <Plan Name> | ESOP ORD1      | 1,500                | button  | button  |
    And inside Participant Offer, 'Details' tab is pressed
    Then inside Participant 'Details' tab, displays details for status 'open'
      | Plan Name    | Offer Description              | Security | Grant Date | Vesting Schedule            | Description                    | 
      | <Plan Name> | ESOP1 Offer 2 for closing auto | ESOP1    | [Today]    | No Vesting Schedule include | ESOP1 Offer 2 for closing auto |
    And inside Participant Offer, 'Documents & Media' tab is pressed
    Then inside Participant 'Documents & Media' tab, displays details for status 'open'
      | Document Name | Date Uploaded |
      | Legal Doc 5   | [Today]       |
    And inside Participant Offer, 'Q & A' tab is pressed
    Then inside Participant 'Q & A' tab, 'Add' option is not available

  @ESOPSmoke @ESOPRegression @DEV @TEST @run
    Examples:
      | Participant           | Company       | Plan Name                    | Offer Name                          | Participant          | No of securities |
      | Participant_employee1 | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx Tester Employee1 | 1500             |
 
  @TestCaseKey=PLX-T892
  Scenario Outline: As a Participant I can accept ESOP offer and complete Docusign

    Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And investor menu 'My ESOP Offers' is pressed
    And inside Participant Offers, <Offer Name> tile is pressed
    And inside Participant Offer, 'My Offer' tab is pressed
    And inside 'My Offer' tab, 'Accept' is pressed
    When inside alert pop-up, Confirm Offer Acceptance, 'Confirm' is pressed
    And inside alert pop-up, Email Sent, 'Done' is pressed
    And participant review and signs Docusign for <Offer Name> and <Email>
    Then inside Participant 'My Offer' tab, displays details for status 'open and signed'
      | Name                 | Email           | Signed  | Date Signed | 
      | FCX TESTER EMPLOYEE1 | <Display Email> | checked | [Today]     | 
    And inside Participant 'My Offer' tab, displays details for status 'accepted'
       | Securities | Security Class | Status    |
       | 1,500      | ESOP           | Accepted  |

  @ESOPSmoke @ESOPRegression @DEV @run
    Examples:
      | Participant           | Company       | Plan Name                    | Offer Name                          | Email                          | Display Email   |
      | Participant_employee1 | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | fcx.tester+employee1@gmail.com | FCX.TESTER+EMPLOYEE1@GMAIL.COM |

  @ESOPSmoke @ESOPRegression @TEST @run
    Examples:
      | Participant           | Company       | Plan Name                    | Offer Name                          | Email                                     | Display Email   |
      | Participant_employee1 | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | fcx.test.tester+employee1@finclear.com.au | FCX.TEST.TESTER+EMPLOYEE1@FINCLEAR.COM.AU | 


 @ESOPRegression @PLX-2807
  Scenario Outline: As an Issuer user with ESOP role, I want to be able to view “Participants” tab in all offer states so that I can manage ESOP process

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    Then in 'Participants' table, shows row details
      | Participant                      | Department  | Email                                | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | 13GoodData MiddleNameL LastnameL | DepartmentL | deborah.dowson+2@fincleartech.com.au |             | Not Sent      | 2,000             |          |        |
      | 12RepeatedEmailAF LastnameK      | DepartmentK | emailAA@gmail.com                    |             | Not Sent      | 1,000             |          |        |
      | 2MandatoryFields LastnameA       |             | emailA@gmail.com                     |             | Not Sent      |                   |          |        |
      | 3AllFields MiddlenameB LastnameB | DepartmentB | emailB@gmail.com                     |             | Not Sent      | 500               |          |        |
      | 4InvalidEmailF LastnameC         |             | emailC@gmail.com                     |             | Not Sent      |                   |          |        |
      | 5MissingLastnameF LastnameD      |             | emailD@gmail.com                     |             | Not Sent      |                   |          |        |
      | 6MissingEmailF LastnameE         |             | emailE@gmail.com                     |             | Not Sent      |                   |          |        |
      | 7MissingAddressLine1F LastnameF  |             | emailF@gmail.com                     |             | Not Sent      |                   |          |        |
      | 8MissingSuburbF LastnameG        |             | emailG@gmail.com                     |             | Not Sent      |                   |          |        |
      | 9MissingStateF LastnameH         |             | emailH@gmail.com                     |             | Not Sent      |                   |          |        |
      | 10MissingCountryF LastnameI      |             | emailI@gmail.com                     |             | Not Sent      |                   |          |        |
      | 11ZeroSecuritiesF LastnameJ      |             | emailJ@gmail.com                     |             | Not Sent      | 1                 |          |        |
      | 14GoodData LastnameM             | DepartmentM | emailM@gmail.com                     |             | Not Sent      | 3,000             |          |        |
      | Test Dev Employee2               | Engineering | fcx.tester+employee2@gmail.com       |             | Not Sent      | 3,000             |          |        |

    @TestCaseKey=PLX-T381 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual |

  @ESOPRegression @PLX-2823 
  Scenario Outline: ESOP - Edit Participant: Offer [Status] = "Setup" | Invite [Status] = "Not sent" | Validate email is unique (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in 'Participants' table, 'Update Participant' action for row detail is selected
      | Participant        | Department        | Email        | Invite Date | Invite Status        | No. of Securities     | Accepted | Issued |
      | <From Participant> | <From Department> | <From Email> |             | <From Invite Status> | <From Num Securities> |          |        |
    And in 'Edit Participant' pop-up, '<Email>' is entered into Email
    When in 'Edit Participant' pop-up, 'Update' button is pressed
    Then alert pop-up, error, '<Error Message>' is displayed
    # Different to requirements
    # Then in 'Edit Participant' pop-up, '<Error Message>' validation error is displayed for Email

    @TestCaseKey=PLX-T449 @DEV @TEST @run
    Examples: ESOP - Edit Participant: Offer [Status] = "Setup" | Invite [Status] = "Not sent" | Validate email is unique (Issue user ESOP role)
      | Issuer | Company       | Plan Name                    | Offer Name                          | From Participant           | From Department | From Email                     | From Invite Status | From Num Securities | Email             | Error Message                               |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual         | 2MandatoryFields LastnameA |                 | emailA@gmail.com               | Not Sent           |                     | emailAA@gmail.com | Email address already exists in the offer.  |

  @ESOPRegression @PLX-2823 
  Scenario Outline: ESOP - Edit Participant: Offer [Status] = "Setup" | Invite [Status] = "Not sent" | Verify mandatory fields are checked (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in 'Participants' table, 'Update Participant' action for row detail is selected
      | Participant        | Department        | Email        | Invite Date | Invite Status        | No. of Securities     | Accepted | Issued |
      | <From Participant> | <From Department> | <From Email> |             | <From Invite Status> | <From Num Securities> |          |        |
    And in 'Edit Participant' pop-up, ' ' is entered into First Name
    And in 'Edit Participant' pop-up, ' ' is entered into Middle Names
    And in 'Edit Participant' pop-up, ' ' is entered into Last Name
    And in 'Edit Participant' pop-up, ' ' is entered into Position
    And in 'Edit Participant' pop-up, ' ' is entered into Department
    And in 'Edit Participant' pop-up, ' ' is entered into Work Number
    And in 'Edit Participant' pop-up, ' ' is entered into Email
    And in 'Edit Participant' pop-up, ' ' is entered into Address Line 1
    And in 'Edit Participant' pop-up, ' ' is entered into Address Line 2
    And in 'Edit Participant' pop-up, ' ' is selected for Country
    And in 'Edit Participant' pop-up, ' ' is entered into Suburb
    ### Becomes Combo box after country 'AUSTRALIA' selected
    And in 'Edit Participant' pop-up, ' ' is entered into State
    And in 'Edit Participant' pop-up, ' ' is entered into Postcode
    And in 'Edit Participant' pop-up, ' ' is entered into No. of securities
    When in 'Edit Participant' pop-up, 'Update' button is pressed
    And 'Updating' button is not displayed
    Then in 'Edit Participant' pop-up, 'Enter a valid email' validation error is displayed for Email
    And in 'Edit Participant' pop-up, '<Email>' is entered into Email
    When in 'Edit Participant' pop-up, 'Update' button is pressed
    And 'Updating' button is not displayed
    Then in 'Edit Participant' pop-up, 'Country is required' validation error is displayed for Country
    # Then alert pop-up, error, 'Country is required' is displayed
    When in 'Edit Participant' pop-up, '<Country>' is selected for Country
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    # Then alert pop-up, error, 'Postcode is required' is displayed
    Then in 'Edit Participant' pop-up, 'Postcode is required' validation error is displayed for Postcode
    When in 'Edit Participant' pop-up, '<Postcode>' is entered into Postcode
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    # Then alert pop-up, error, 'First Name is required' is displayed
    #BUG: 'first_name mandatory'
    When in 'Edit Participant' pop-up, '<First Name>' is entered into First Name
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    # Then alert pop-up, error, 'Last Name is required' is displayed
    #BUG: 'last_name mandatory'
    # And in 'Edit Participant' pop-up, '<Middle Name>' is entered into Middle Names
    When in 'Edit Participant' pop-up, '<Last Name>' is entered into Last Name
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    # Then alert pop-up, error, 'Address Line 1 is required' is displayed
    #BUG: 'address_line_1 mandatory'
    When in 'Edit Participant' pop-up, '<Address Line 1>' is entered into Address Line 1
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    # Then alert pop-up, error, 'Suburb is required' is displayed
    #BUG: 'suburb mandatory'
    And 'Updating' button is not displayed
    When in 'Edit Participant' pop-up, '<Suburb>' is entered into Suburb
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    # Then alert pop-up, error, 'State is required' is displayed
    #BUG: 'state mandatory'
    And 'Updating' button is not displayed
    When in 'Edit Participant' pop-up, '<State>' is selected for State
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    And 'Updating' button is not displayed
    # Then alert pop-up, error, 'Invalid offer value' is displayed
    When in 'Edit Participant' pop-up, '<Offer>' is entered into No. of securities
    And in 'Edit Participant' pop-up, '<Middle Name>' is entered into Middle Names
    And in 'Edit Participant' pop-up, '<Position>' is entered into Position
    And in 'Edit Participant' pop-up, '<Department>' is entered into Department
    And in 'Edit Participant' pop-up, '<Work Number>' is entered into Work Number
    And in 'Edit Participant' pop-up, '<Address Line 2>' is entered into Address Line 2
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    Then 'Participants' table, displays details
      | Participant                            | Department   | Email   | Invite Date | Invite Status   | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Name> <Last Name> | <Department> | <Email> |             | <Invite Status> | <Offer>           |          |        |

    @TestCaseKey=PLX-T453 @DEV @TEST @run
    Examples: ESOP - Edit Participant: Offer [Status] = "Setup" | Invite [Status] = "Not sent" | Verify mandatory fields are checked (Issue user ESOP role)
      | Issuer | Company       | Plan Name                    | Offer Name                  | From Participant   | From Department | From Email        | From Invite Status | From Num Securities | First Name | Middle Name | Last Name | Position | Department  | Work Number  | Email                          | Invite Status | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | 14GoodData LastnameM | DepartmentM   | emailM@gmail.com  | Not Sent           | 3,000                | Test       | Dev         | Employee2 | Test Bot | Engineering | 08 6666 9999 | fcx.tester+employeex@gmail.com | Not Sent      | Level 8        | 5 Mill Street  | Perth  | Western Australia | 6000     | Australia | 3,000  |

  @ESOPRegression @PLX-2823 
  Scenario Outline: ESOP - Edit Participant: Offer [Status] = "Setup" | Invite [Status] = "Not sent" | Individual has no and have securities (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    When in 'Participants' table, 'Update Participant' action for row detail is selected
      | Participant        | Department        | Email        | Invite Date | Invite Status        | No. of Securities     | Accepted | Issued |
      | <From Participant> | <From Department> | <From Email> |             | <From Invite Status> | <From Num Securities> |          |        |
    And in 'Edit Participant' pop-up, '<First Name>' is entered into First Name
    And in 'Edit Participant' pop-up, '<Middle Name>' is entered into Middle Names
    And in 'Edit Participant' pop-up, '<Last Name>' is entered into Last Name
    And in 'Edit Participant' pop-up, '<Email>' is entered into Email
    And in 'Edit Participant' pop-up, '<Address Line 1>' is entered into Address Line 1
    And in 'Edit Participant' pop-up, '<Suburb>' is entered into Suburb
    And in 'Edit Participant' pop-up, '<Country>' is selected for Country
    ### Becomes Combo box after country 'AUSTRALIA' selected
    And in 'Edit Participant' pop-up, '<State>' is selected for State
    And in 'Edit Participant' pop-up, '<Offer>' is entered into No. of securities
    And in 'Edit Participant' pop-up, 'Update' button is pressed
    Then alert pop-up, success, 'Participant Updated' is displayed
    And 'Participants' table, displays details
      | Participant                            | Department   | Email   | Invite Date | Invite Status   | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Name> <Last Name> | <Department> | <Email> |             | <Invite Status> | <Offer>           |          |        |

    @TestCaseKey=PLX-T447 @DEV @TEST @run
    Examples: ESOP - Edit Participant: Offer [Status] = "Setup" | Invite [Status] = "Not sent" | Individual has no securities (Issue user ESOP role)
      | Issuer | Company       | Plan Name                    | Offer Name                          | From Participant   | From Department | From Email                     | From Invite Status | From Num Securities | First Name | Middle Name | Last Name | Position  | Department  | Work Number  | Email                          | Invite Status | Address Line 1 | Address Line 2   | Suburb       | State           | Postcode | Country   | Offer |
      # From Participant will need to be 'Test Employee2' after bug fixes
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | Test Dev Employee2 | Engineering     | fcx.tester+employee2@gmail.com | Not Sent           | 3,000                | Test3      | Dev3        | Employee3 | Test Bot3 | Engineering | 08 6666 9999 | fcx.tester+employee21@gmail.com | Not Sent      | Level 8        | 118 Mount Street | North Sydney | New South Wales | 2060     | Australia |       |
    #Revert
    @TestCaseKey=PLX-T448 @DEV @TEST @run
    Examples: ESOP - Edit Participant: Offer [Status] = "Setup" | Invite [Status] = "Not sent" | Individual has securities (Issue user ESOP role)
      | Issuer | Company       | Plan Name                    | Offer Name                          | From Participant     | From Department | From Email                     | From Invite Status | From Num Securities | First Name | Middle Name | Last Name | Position | Department  | Work Number  | Email                          | Invite Status | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | Test3 Dev3 Employee3 | Engineering     | fcx.tester+employee21@gmail.com | Not Sent           |                     | Test       | Dev         | Employee2 | Test Bot | Engineering | 08 6666 9999 | fcx.tester+employee31@gmail.com | Not Sent      | Level 8        | 5 Mill Street  | Perth  | Western Australia | 6000     | Australia | 3,000  |