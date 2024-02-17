@PLX-2713 @setup
Feature: ESOP Manage participants - (Participants Tab)

  @ESOPRegression @PLX-3175 
  Scenario Outline: View Participants - No participants
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    Then in 'ESOP' page, 'Participants' tab, '-' is displayed for Total Participants
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Total Participants - Securities
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Participants Invited
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Participants Invited - Accepted
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Participants Invited - Declined
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Participants Invited - Cancelled
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Securities Accepted
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Securities Accepted - Participants
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Securities Declined
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Securities Declined - Participants
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Securities Issued
    And in 'ESOP' page, 'Participants' tab, '-' is displayed for Securities Issued - Participants
    And 'This ESOP Offer has no Participant' table content is displayed

    # Separate tests - Add Participants button
    When 'Please Add Participants' button is pressed
    # Separate tests - Cancel @TestCaseKey=PLX-T371
    And in 'Add Participant' pop-up, 'Cancel' button is pressed
    And 'This ESOP Offer has no Participant' table content is displayed

    @TestCaseKey=PLX-T379 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |

  @ESOPRegression @PLX-3175 
  Scenario Outline: ESOP - Add Participant: Verify mandatory fields
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, current status is Setup
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant' action is selected
    And in 'Add Participant' pop-up, 'Add' button is pressed
    Then in 'Add Participant' pop-up, 'First Name is required' validation error is displayed for First Name
    And in 'Add Participant' pop-up, 'Last Name is required' validation error is displayed for Last Name
    And in 'Add Participant' pop-up, 'Email is required' validation error is displayed for Email
    And in 'Add Participant' pop-up, 'Address Line 1 is required' validation error is displayed for Address Line 1
    And in 'Add Participant' pop-up, 'Suburb is required' validation error is displayed for Suburb
    And in 'Add Participant' pop-up, 'State is required' validation error is displayed for State
    # And in 'Add Participant' pop-up, 'Postcode is required' validation error is displayed for Postcode
    And in 'Add Participant' pop-up, 'Country is required' validation error is displayed for Country

    @TestCaseKey=PLX-T368 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |

  @ESOPRegression @PLX-2822 
  Scenario Outline: ESOP - Add Participant: Verify Securities > 0 given Offer [Status] = "Setup" (Issue user ESOP role)
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant' action is selected
    And in 'Add Participant' pop-up, '<First Name>' is entered into First Name
    And in 'Add Participant' pop-up, '<Last Name>' is entered into Last Name
    And in 'Add Participant' pop-up, '<Email>' is entered into Email
    And in 'Add Participant' pop-up, '<Address Line 1>' is entered into Address Line 1
    And in 'Add Participant' pop-up, '<Suburb>' is entered into Suburb
    And in 'Add Participant' pop-up, '<State>' is entered into State
    And in 'Add Participant' pop-up, '<Postcode>' is entered into Postcode
    And in 'Add Participant' pop-up, '<Country>' is selected for Country
    And in 'Add Participant' pop-up, '<Offer>' is entered into No. of securities
    And in 'Add Participant' pop-up, 'Add' button is pressed
    Then in 'Add Participant' pop-up, 'Required more than zero security' validation error is displayed for No. of securities
    And in 'Add Participant' pop-up, 'Postcode is required' validation error is displayed for Postcode

    @TestCaseKey=PLX-T378 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Position | Department | Work Number | Email                          | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Fcx        | Tester       | Employee1 |          |            |             | fcx.tester+employee1@gmail.com | Level 8        |                | Perth  | Western Australia |          | Australia | 0     |
    
    @TestCaseKey=PLX-T378 @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Position | Department | Work Number | Email                                     | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Fcx        | Tester       | Employee1 |          |            |             | fcx.test.tester+employee1@finclear.com.au | Level 8        |                | Perth  | Western Australia |          | Australia | 0     |


  @PLX-2822 
  Scenario Outline: Add Participants | Add Participants individually - 'Add Participant' Actions

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    # And 'This ESOP Offer has no Participant' table content is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant' action is selected
    And in 'Add Participant' pop-up, '<First Name>' is entered into First Name
    And in 'Add Participant' pop-up, '<Middle Names>' is entered into Middle Names
    And in 'Add Participant' pop-up, '<Last Name>' is entered into Last Name
    And in 'Add Participant' pop-up, '<Position>' is entered into Position
    And in 'Add Participant' pop-up, '<Department>' is entered into Department
    And in 'Add Participant' pop-up, '<Work Number>' is entered into Work Number
    And in 'Add Participant' pop-up, '<Email>' is entered into Email
    And in 'Add Participant' pop-up, '<Address Line 1>' is entered into Address Line 1
    And in 'Add Participant' pop-up, '<Address Line 2>' is entered into Address Line 2
    And in 'Add Participant' pop-up, '<Suburb>' is entered into Suburb
    And in 'Add Participant' pop-up, '<State>' is entered into State
    And in 'Add Participant' pop-up, '<Postcode>' is entered into Postcode
    And in 'Add Participant' pop-up, '<Country>' is selected for Country
    ### Becomes Combo box after country 'AUSTRALIA' selected
    And in 'Add Participant' pop-up, '<State>' is selected for State
    And in 'Add Participant' pop-up, '<Offer>' is entered into No. of securities
    And in 'Add Participant' pop-up, 'Add' button is pressed
    Then 'Participants' table, displays details
      | Participant                             | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> |             | Not Sent      | 1,000             |          |        |

    @ESOPSmoke @TestCaseKey=PLX-T369 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Position | Department | Work Number | Email                          | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx        | Tester       | Employee1 |          |            |             | fcx.tester+employee1@gmail.com | Level 8        |                | Perth  | Western Australia | 6000     | Australia | 1000  |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx        | Tester       | Employee1 |          |            |             | fcx.tester+employee1@gmail.com | Level 8        |                | Perth  | Western Australia | 6000     | Australia | 1000  |

    @ESOPRegression @TestCaseKey=PLX-T369 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Position | Department | Work Number | Email                          | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Fcx        | Tester       | Employee1 |          |            |             | fcx.tester+employee1@gmail.com | Level 8        |                | Perth  | Western Australia | 6000     | Australia |       |
      #PLX-3525
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx        | Tester       | Employee1 |          |            |             | fcx.tester+employee1@gmail.com | Level 8        |                | Perth  | Western Australia | 6000     | Australia | 1000  |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx        | Tester       | Employee1 |          |            |             | fcx.tester+employee1@gmail.com | Level 8        |                | Perth  | Western Australia | 6000     | Australia | 1000  |

    @ESOPSmoke @TestCaseKey=PLX-T369 @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Position | Department | Work Number | Email                                     | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx        | Tester       | Employee1 |          |            |             | fcx.test.tester+employee1@finclear.com.au | Level 8        |                | Perth  | Western Australia | 6000     | Australia | 1000  |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx        | Tester       | Employee1 |          |            |             | fcx.test.tester+employee1@finclear.com.au | Level 8        |                | Perth  | Western Australia | 6000     | Australia | 1000  |

    @ESOPRegression @TestCaseKey=PLX-T369 @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Position | Department | Work Number | Email                                     | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Fcx        | Tester       | Employee1 |          |            |             | fcx.test.tester+employee1@finclear.com.au | Level 8        |                | Perth  | Western Australia | 6000     | Australia |       |
      #PLX-3525
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Fcx        | Tester       | Employee1 |          |            |             | fcx.test.tester+employee1@finclear.com.au | Level 8        |                | Perth  | Western Australia | 6000     | Australia | 1000  |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx        | Tester       | Employee1 |          |            |             | fcx.test.tester+employee1@finclear.com.au | Level 8        |                | Perth  | Western Australia | 6000     | Australia | 1000  |

   
  @TestCaseKey=PLX-T692
  Scenario Outline: I want to be able to amend an [offer status] = setup and [invite status] = not sent

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And in ESOP offer, current status is Setup
    Then 'Participants' table, displays details
      | Participant     | Department  | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <Participant>   |             | <Email> |             | Not Sent     | 1,000             |          |        |
    And in ESOP offer, status is 'Setup', 'Participants' section securities updated to <No of securities>
    Then 'Participants' table, displays details
      | Participant    | Department  | Email    | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <Participant>  |             | <Email>  |             | Not Sent      | 1,200            |          |        |

    @ESOPSmoke @ESOPRegression @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Participant          | No of securities | Email                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx Tester Employee1 | 1200             | fcx.tester+employee1@gmail.com |

    @ESOPSmoke @ESOPRegression @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Participant          | No of securities | Email                                     |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Fcx Tester Employee1 | 1200             | fcx.test.tester+employee1@finclear.com.au |


  @ESOPRegression @PLX-2822 
  Scenario Outline: ESOP - Add Participant: Verify email is unique Offer [Status] = "Setup" (Issue user ESOP role)
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant' action is selected
    And in 'Add Participant' pop-up, '<First Name>' is entered into First Name
    And in 'Add Participant' pop-up, '<Last Name>' is entered into Last Name
    And in 'Add Participant' pop-up, '<Email>' is entered into Email
    And in 'Add Participant' pop-up, '<Address Line 1>' is entered into Address Line 1
    And in 'Add Participant' pop-up, '<Suburb>' is entered into Suburb
    And in 'Add Participant' pop-up, '<State>' is entered into State
    And in 'Add Participant' pop-up, '<Postcode>' is entered into Postcode
    And in 'Add Participant' pop-up, '<Country>' is selected for Country
    And in 'Add Participant' pop-up, 'Add' button is pressed
    Then alert pop-up, error, 'Email address already exists in the offer' is displayed

    @TestCaseKey=PLX-T372 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Position | Department  | Work Number | Email                          | Address Line 1 | Address Line 2 | Suburb | State             | Postcode | Country   | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Fcx        | Tester       | Employee1 | Test Bot | Engineering |             | fcx.tester+employee1@gmail.com | Level 8        | 5 Mill Street  | Perth  | Western Australia | 6000     | Australia |       |

  @ESOPRegression @PLX-3166 
  Scenario Outline: Open ESOP Offer to Participants (Negative Flow - Participants have no securities )

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, current status is Setup
    And in ESOP offer, 'Documents & Media' tab is pressed
    When in ESOP offer page, hover on status 'Setup'
    And in 'Setup' status pop-up, 'Offer Details' is ticked
    And in 'Setup' status pop-up, 'Participant Offers' with 'All Participants must have a number of securities on offer' description is blank
    Then in 'Setup' status pop-up, 'Progress to Open' button is disabled

    @TestCaseKey=PLX-T391 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |

  @ESOPRegression @PLX-2824 
  Scenario Outline: ESOP - Remove Participant: Cancel out of removing a participant from an Offer | Offer [Status] = "Setup" (Issue user ESOP role)
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'Participants' table, 'Remove Participant' action for row detail is selected
      | Participant                             | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> |             | Not Sent      | <Offer>           |          |        |
    And in 'Remove Participant' pop-up, 'Cancel' button is pressed
    Then 'Participants' table, displays details
      | Participant                             | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> |             | Not Sent      |                   |          |        |

    @TestCaseKey=PLX-T394 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Department | Email                          | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Fcx        | Tester       | Employee1 |            | fcx.tester+employee1@gmail.com |       |

  @ESOPRegression @PLX-2824 
  Scenario Outline: Setup status of the offer | As an Issuer user with ESOP role, I want to be able to remove participants from the list so that I can maintain the list
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'Participants' table, 'Remove Participant' action for row detail is selected
      | Participant                             | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> |             | Not Sent      | <Offer>           |          |        |
    And in 'Remove Participant' pop-up, 'Confirm' button is pressed
    And alert pop-up, success, 'Participant Removed' is displayed
    Then 'Participants' table, does not display row with Email
      | Participant                             | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <First Name> <Middle Names> <Last Name> | <Department> | <Email> |             | Not Sent      | <Offer>           |          |        |

    @TestCaseKey=PLX-T393 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | First Name | Middle Names | Last Name | Department | Email                          | Offer |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Fcx        | Tester       | Employee1 |            | fcx.tester+employee1@gmail.com |       |
