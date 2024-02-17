@PLX-3154 @setup
Feature: ESOP Offer - Set up plan enhancements

  @PLX-3527 @Regression
  Scenario Outline: When Offer status Closed or Finalised, as an issurer, I want to be able to perform functionality granted for closed or finalised status - Auto
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    # Close
    And in ESOP offer page, hover on status 'Open'
    When in 'Open' status pop-up, 'Progress to Close' button is pressed
    When in 'Close Offer Confirmation' pop-up, 'Confirm' button is pressed
    And alert pop-up, success, 'Transition to Closed successful.' is displayed
    Then in ESOP offer, current status is Close

    #Find Edit
    And in ESOP offer, 'Details' tab is pressed
    Then in 'ESOP Offer' page, 'Details' tab, 'Edit' action should not be displayed

    @TestCaseKey=PLX-T348 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 2 Closed Auto |

  @PLX-3527 @Regression
  Scenario Outline: When Offer status Closed or Finalised, as an issurer, I want to be able to perform functionality granted for closed or finalised status - Manual
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    # Close
    And in ESOP offer page, hover on status 'Open'
    When in 'Open' status pop-up, 'Progress to Close' button is pressed
    When in 'Close Offer Confirmation' pop-up, 'Confirm' button is pressed
    And alert pop-up, success, 'Transition to Closed successful.' is displayed
    Then in ESOP offer, current status is Close

    #Find Edit
    And in ESOP offer, 'Details' tab is pressed
    Then in 'ESOP Offer' page, 'Details' tab, 'Edit' action should not be displayed

    @TestCaseKey=PLX-T349 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                         |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Closed Manual |
