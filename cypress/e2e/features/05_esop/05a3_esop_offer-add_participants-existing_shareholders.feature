@PLX-2713
Feature: ESOP Manage participants - add participants (adding existing employee shareholders)

  @ESOPRegression @PLX-3174 
  Scenario Outline: Given an Offer [Status] = Setup then verify the investors listed in the "All Existing Employees" table have [Employee Holding] = yes

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    When company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Participants' tab, 'Add Existing Participants' action is selected
    Then in 'Add Existing Participants' pop-up, 'All Existing Employee' list displays details
      | Full Name                                  | Email |
      | EMPFIRSTNAME2 EMPMIDDLENAME2 EMPLASTNAME2  | FCX.TESTER+COMPANY_INVESTOR@FCX.COM.AU       |
      | EMPFIRSTNAME1 EMPMIDDLENAME1 EMPLASTNAME1  | FCX.TESTER+INDIVIDUAL_INVESTOR1@FCX.COM.AU   |
      | EMPFIRSTNAME3 EMPMIDDLENAME3 EMPLASTNAME3  | FCX.TESTER+JOINT_INVESTOR@FCX.COM.AU         |

    @TestCaseKey=PLX-T429 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                | Investor1         | Investor2        | Investor3  |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto | individual_investor | joint_investor | company_investor  |


  @ESOPRegression @PLX-3174 
  Scenario Outline: ESOP - Add Existing Participants: Verify you can cancel out of adding existing participants to the participant list

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And Company menu 'Cap Table' is pressed
    And Company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed

    When in 'ESOP Offer' page, 'Participants' tab, 'Add Existing Participants' action is selected
    And in 'Add Existing Participants' pop-up, <Investor Name> is selected in 'All Existing Employee' list
    And in 'Add Existing Participants' pop-up, 'Add' button is pressed
    Then in 'Add Existing Participants' pop-up, 'Employees selected to Participate' list displays details
      | Full Name        | Email    |
      | <Investor Name>  | <Email>  |
    And 'Cancel' button is pressed
    Then 'Participants' table, does not display row with Email
      | Participant     | Department   | Email   | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <Investor Name> |              | <Email> |             | Not Sent      |                   |          |        |

    @TestCaseKey=PLX-T437 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                | Investor Name                              | Email                                        |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto | EMPFIRSTNAME1 EMPMIDDLENAME1 EMPLASTNAME1  | FCX.TESTER+INDIVIDUAL_INVESTOR1@FCX.COM.AU   |


  @ESOPRegression @PLX-3174 
  Scenario Outline: ESOP - Add Existing Participants: Given an Offer [Status] = Setup then verify investors in the "All Existing Employees" table can be added and removed to "Employee selected to participate" table and then saved to the offer

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And Company menu 'Cap Table' is pressed
    And Company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed

    # Add an investor to "Employee selected to Participate" table
    When in 'ESOP Offer' page, 'Participants' tab, 'Add Existing Participants' action is selected
    And in 'Add Existing Participants' pop-up, <Investor Name3> is selected in 'All Existing Employee' list
    And in 'Add Existing Participants' pop-up, 'Add' button is pressed
    Then in 'Add Existing Participants' pop-up, 'Employees selected to Participate' list displays details
      | Full Name         | Email     |
      | <Investor Name3>  | <Email3>  |
    And in 'Add Existing Participants' pop-up, 'All Existing Employee' list displays details
      | Full Name         | Email     |
      | <Investor Name2>  | <Email2>  |
      | <Investor Name1>  | <Email1>  |

    # Remove an investor from "Employee selected to Participate" table
    When in 'Add Existing Participants' pop-up, <Investor Name3> is selected in 'Employees selected to Participate' list
    And in 'Add Existing Participants' pop-up, 'Remove' button is pressed
    Then in 'Add Existing Participants' pop-up, 'All Existing Employee' list displays details
      | Full Name         | Email     |
      | <Investor Name2>  | <Email2>  |
      | <Investor Name1>  | <Email1>  |
      | <Investor Name3>  | <Email3>  |

    # Add multiple investor to "Employee selected to Participate" table
    When in 'Add Existing Participants' pop-up, <Investor Name3> is selected in 'All Existing Employee' list
    And in 'Add Existing Participants' pop-up, <Investor Name1> is selected in 'All Existing Employee' list
    And in 'Add Existing Participants' pop-up, 'Add' button is pressed
    Then in 'Add Existing Participants' pop-up, 'Employees selected to Participate' list displays details
      | Full Name         | Email     |
      | <Investor Name3>  | <Email3>  |
      | <Investor Name1>  | <Email1>  |
    And in 'Add Existing Participants' pop-up, 'All Existing Employee' list displays details
      | Full Name         | Email     |
      | <Investor Name2>  | <Email2>  |

    # Remove multiple investors from "Employee selected to Participate" table
    When in 'Add Existing Participants' pop-up, <Investor Name3> is selected in 'Employees selected to Participate' list
    And in 'Add Existing Participants' pop-up, <Investor Name1> is selected in 'Employees selected to Participate' list
    And in 'Add Existing Participants' pop-up, 'Remove' button is pressed
    Then in 'Add Existing Participants' pop-up, 'All Existing Employee' list displays details
      | Full Name         | Email     |
      | <Investor Name2>  | <Email2>  |
      | <Investor Name1>  | <Email1>  |
      | <Investor Name3>  | <Email3>  |

    # Add all investors to "Employee selected to Participate" table
    When in 'Add Existing Participants' pop-up, all employees is selected in 'All Existing Employee' list
    And in 'Add Existing Participants' pop-up, 'Add' button is pressed
    Then in 'Add Existing Participants' pop-up, 'Employees selected to Participate' list displays details
      | Full Name         | Email     |
      | <Investor Name3>  | <Email3>  |
      | <Investor Name1>  | <Email1>  |
      | <Investor Name2>  | <Email2>  |
    When in 'Add Existing Participants' pop-up, 'Submit' button is pressed
    Then alert pop-up, success, 'Participants Added' is displayed
    Then 'Participants' table, displays details
      | Participant      | Department   | Email    | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <Investor Name1> |              | <Email1> |             | Not Sent      |                   |          |        |
      | <Investor Name2> |              | <Email2> |             | Not Sent      |                   |          |        |
      | <Investor Name3> |              | <Email3> |             | Not Sent      |                   |          |        |

    @TestCaseKey=PLX-T435 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                | Investor Name1                             | Email1                                      | Investor Name2                             | Email2                                       | Investor Name3                             | Email3                                       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto | EMPFIRSTNAME1 EMPMIDDLENAME1 EMPLASTNAME1  | FCX.TESTER+INDIVIDUAL_INVESTOR1@FCX.COM.AU  | EMPFIRSTNAME2 EMPMIDDLENAME2 EMPLASTNAME2  | FCX.TESTER+COMPANY_INVESTOR@FCX.COM.AU   | EMPFIRSTNAME3 EMPMIDDLENAME3 EMPLASTNAME3  | FCX.TESTER+JOINT_INVESTOR@FCX.COM.AU  |


  @ESOPRegression @PLX-3174 
  Scenario Outline: Given an Offer [Status] = Setup then verify when a participant is added to Participant list of an Offer then their email will be unique

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And Company menu 'Cap Table' is pressed
    And Company menu 'Investors' is pressed
    And 'Actions' button is pressed
    And 'Add New Shareholder' action is pressed
    And in 'Add Investor' pop-up, '<Investor1_duplicate_email>' data is entered
    And in 'Add Investor' pop-up, 'Save' button is pressed

    When Company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed

    # No existing employees are listed because a person with this email is already in list
    When in 'ESOP Offer' page, 'Participants' tab, 'Add Existing Participants' action is selected

    And 'Cancel' button is pressed

    When in 'Participants' table, 'Remove Participant' action for row detail is selected
      | Participant       | Department   | Email    | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | <Investor Name1>  |              | <Email1> |             | Not Sent      |                   |          |        |
    And in 'Remove Participant' pop-up, 'Confirm' button is pressed
    And alert pop-up, success, 'Participant Removed' is displayed

    When in 'ESOP Offer' page, 'Participants' tab, 'Add Existing Participants' action is selected
    Then in 'Add Existing Participants' pop-up, 'All Existing Employee' list displays details
      | Full Name         | Email     |
      | <Investor Name1>  | <Email1>  |
      | <Investor Name2>  | <Email1>  |
    When in 'Add Existing Participants' pop-up, all employees is selected in 'All Existing Employee' list
    And in 'Add Existing Participants' pop-up, 'Add' button is pressed
    Then in 'Add Existing Participants' pop-up, 'Employees selected to Participate' list displays details
      | Full Name         | Email     |
      | <Investor Name1>  | <Email1>  |
      | <Investor Name2>  | <Email1>  |
    When in 'Add Existing Participants' pop-up, 'Submit' button is pressed
    Then alert pop-up, error, 'Cannot add esop participants. The email addresses \'FCX.TESTER+INDIVIDUAL_INVESTOR1@FCX.COM.AU\' have been used more than once' is displayed

    @TestCaseKey=PLX-T436 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                | Investor1_duplicate_email           | Investor Name1                            | Email1                                     | Investor Name2  |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto | individual_investor_duplicate_email | EMPFIRSTNAME1 EMPMIDDLENAME1 EMPLASTNAME1 | FCX.TESTER+INDIVIDUAL_INVESTOR1@FCX.COM.AU | EMPFIRSTNAME4 EMPMIDDLENAME4 EMPLASTNAME4  |


  @ESOPRegression @PLX-3174 
  Scenario Outline: ESOP - Add Existing Participants: cleanup data

    Given '<Issuer>' is logged in to FCX 'App'
    When in Company View, <Company> tile is pressed
    And Company menu 'Cap Table' is pressed
    And Company menu 'Investors' is pressed
    And in 'Investor' table, '<Investor1>' data is archived
    And in 'Investor' table, '<Investor2>' data is archived
    And in 'Investor' table, '<Investor3>' data is archived
    And in 'Investor' table, '<Investor1_duplicate_email>' data is archived

    When Company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    And in 'Participants' table, 'Remove Participant' action for row detail is selected
      | Participant                                | Department   | Email                                  | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | EMPFIRSTNAME2 EMPMIDDLENAME2 EMPLASTNAME2  |              | FCX.TESTER+COMPANY_INVESTOR@FCX.COM.AU |             | Not Sent      |                   |          |        |
    And in 'Remove Participant' pop-up, 'Confirm' button is pressed
    Then alert pop-up, success, 'Participant Removed' is displayed
    When in 'Participants' table, 'Remove Participant' action for row detail is selected
      | Participant                                | Department   | Email                                | Invite Date | Invite Status | No. of Securities | Accepted | Issued |
      | EMPFIRSTNAME3 EMPMIDDLENAME3 EMPLASTNAME3  |              | FCX.TESTER+JOINT_INVESTOR@FCX.COM.AU |             | Not Sent      |                   |          |        |
    And in 'Remove Participant' pop-up, 'Confirm' button is pressed
    Then alert pop-up, success, 'Participant Removed' is displayed

    @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                | Investor1         | Investor2      | Investor3         | Investor1_duplicate_email |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto | individual_investor | joint_investor | company_investor  | individual_investor_duplicate_email |
