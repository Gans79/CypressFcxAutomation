@PLX-2367 @setup
Feature: ESOP Offer - Details/Documents/Media & Q & A

  @ESOPRegression @PLX-2576 @TestCaseKey=PLX-T252 
  Scenario Outline: As an Issuer User with ESOP access, I would like to see the states of ESOP & four section within the ESOP offer

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    # And in ESOP, '<Plan Name>' plan, <Offer Name> tile is pressed
    When in ESOP plan, <Offer Name> tile is pressed
    Then in ESOP offer, <Offer Name>, status show
      | Setup | Open | Close |
    # And in ESOP offer, <Offer Name>, 'Details' tab is pressed
    And in ESOP offer, 'Details' tab is pressed
    And 'Details' tab title is displayed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    And in ESOP offer, 'Participants' tab is pressed
    # And 'Participants' tab header is displayed
    And in ESOP offer, 'Q & A' tab is pressed
    And 'Questions and Answers' tab title is displayed

    @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  |
      # | Owner  | IC Trading Co | CYPRESS-ESOP Plan1 | ESOP Offer8 |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual |
