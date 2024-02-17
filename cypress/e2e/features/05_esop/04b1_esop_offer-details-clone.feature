@PLX-2367 @setup
Feature: ESOP Offer - Details

  @ESOPRegression @PLX-2872
  Scenario Outline: Cancel out

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And 'Details' tab title is displayed
    When in 'ESOP Offer' page, 'Details' tab, 'Clone' action is selected
    And in 'Clone Offer' pop-up, '<Offer Name>' is entered into Offer Name
    And in 'Clone Offer' pop-up, '<Expiry Date>' is entered into Expiry Date
    And in 'Clone Offer' pop-up, 'Cancel' button is pressed
    And in ESOP, '<Plan Name>', '<Offer Name>' is displayed

    @TestCaseKey=PLX-T258 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                | Expiry Date |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto | [Tomorrow]  |

  @ESOPRegression @PLX-2872
  Scenario Outline: Verify unique ESOP Offer names

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And 'Details' tab title is displayed
    When in 'ESOP Offer' page, 'Details' tab, 'Clone' action is selected
    And in 'Clone Offer' pop-up, '<Offer Name>' is entered into Offer Name
    And in 'Clone Offer' pop-up, '<Expiry Date>' is entered into Expiry Date
    And in 'Clone Offer' pop-up, '<Grant Date>' is entered into Grant Date
    And in 'Clone Offer' pop-up, <Include Vesting Schedule?> radio is selected for 'Include Vesting Schedule'
    And in 'Clone Offer' pop-up, '<Vesting Description>' is entered into Vesting Description
    And in 'Clone Offer' pop-up, 'Clone' button is pressed
    Then in 'Clone Offer' pop-up, 'This Offer Name is already in use, please update the Offer Name: Hint, you can add the year or month in which this plan is offered to differentiate between plan offers.' validation error is displayed for Offer Name
    #BUG PLX-3348: but showing 'Offer model with this name already exists'

    @TestCaseKey=PLX-T281 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                | Expiry Date  | Grant Date | Include Vesting Schedule? | Vesting Description |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto | [Today] + 90 | [Tomorrow] | No                        | No Vesting Schedule |

  @ESOPRegression @PLX-2872
  Scenario Outline: As an Issuer admin with ESOP access, I should be able to Clone the offer when it is “set up” - Manual

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And 'Details' tab title is displayed
    When in 'ESOP Offer' page, 'Details' tab, 'Clone' action is selected
    And in 'Clone Offer' pop-up, '<Offer Name> Cloned' is entered into Offer Name
    And in 'Clone Offer' pop-up, '<Description> Cloned' is entered into Description
    And in 'Clone Offer' pop-up, '<Close Date>' is entered into Close Date
    And in 'Clone Offer' pop-up, '<Grant Date>' is entered into Grant Date
    And in 'Clone Offer' pop-up, '<Expiry Date>' is entered into Expiry Date
    And in 'Clone Offer' pop-up, <Include Vesting Schedule?> radio is selected for 'Include Vesting Schedule'
    And in 'Clone Offer' pop-up, '<Vesting Description>' is entered into Vesting Description
    # And in 'Clone Offer' pop-up, fix the vesting schedule TODO

    And in 'Clone Offer' pop-up, 'Clone' button is pressed
    And alert pop-up, success, 'Offer Cloned Successfully' is displayed
    And '<Offer Name> Cloned' secondary title is displayed
    Then in 'ESOP' page, 'Details' tab, '<Plan Name>' is displayed for Plan Name
    # And in 'ESOP' page, 'Details' tab, '<Description> updated' is displayed for Description #BUG:3450
    And in 'ESOP' page, 'Details' tab, '<Security ID>' is displayed for Security ID
    And in 'ESOP' page, 'Details' tab, '<Issue Price>' is displayed for Issue Price
    And in 'ESOP' page, 'Details' tab, '<Exercise Price>' is displayed for Exercise Price
    And in 'ESOP' page, 'Details' tab, '<Grant Date>' is displayed for Grant Date
    And in 'ESOP' page, 'Details' tab, '<Close Date>' is displayed for Close Date
    And in 'ESOP' page, 'Details' tab, '<Expiry Date>' is displayed for Expiry Date

    @TestCaseKey=PLX-T257 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  | Description                    | Security ID | Grant Date | Grant Date not Applicable | Expiry Date  | Expiry Date not Applicable | Vesting Schedule | Vesting Date | Vesting Amount | Rounding | Issue Price | Issue Price not Applicable | Exercise Price | Exercise Price not Applicable | Close Date   | Employee Wallet | Include Vesting Schedule? | Vesting Description |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | CYPRESS-ESOP Offer 2023Q1 - #1 | ESOP7       | [Today]    | checked                   | [Today] + 60 | unchecked                  | Manual           | [Today] + 1  | 40%            | Nearest  | -           | checked                    | -              | checked                       | [Today] + 14 | No              | No                        | No Vesting Schedule |

  @ESOPRegression @PLX-2872
  Scenario Outline: As an Issuer admin with ESOP access, I should be able to Clone the offer when it is “set up” - Auto

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And 'Details' tab title is displayed
    When in 'ESOP Offer' page, 'Details' tab, 'Clone' action is selected
    And in 'Clone Offer' pop-up, '<Offer Name> Cloned' is entered into Offer Name
    And in 'Clone Offer' pop-up, '<Offer Name> Cloned' is entered into Description
    And in 'Clone Offer' pop-up, '<Grant Date>' is entered into Grant Date
    And in 'Clone Offer' pop-up, '<Close Date>' is entered into Close Date
    And in 'Clone Offer' pop-up, '<Expiry Date>' is entered into Expiry Date
    And in 'Clone Offer' pop-up, <Include Vesting Schedule?> radio is selected for 'Include Vesting Schedule'
    And in 'Clone Offer' pop-up, '<Vesting Description>' is entered into Vesting Description
    And in 'Clone Offer' pop-up, 'Clone' button is pressed
    And alert pop-up, success, 'Offer Cloned Successfully' is displayed
    Then in 'ESOP' page, 'Details' tab, '<Plan Name>' is displayed for Plan Name
    # And in 'ESOP' page, 'Details' tab, '<Description>' is displayed for Description #BUG:3450
    And in 'ESOP' page, 'Details' tab, '<Security ID>' is displayed for Security ID
    And in 'ESOP' page, 'Details' tab, '<Issue Price>' is displayed for Issue Price
    And in 'ESOP' page, 'Details' tab, '<Exercise Price>' is displayed for Exercise Price
    And in 'ESOP' page, 'Details' tab, '<Grant Date>' is displayed for Grant Date
    And in 'ESOP' page, 'Details' tab, '<Close Date>' is displayed for Close Date
    And in 'ESOP' page, 'Details' tab, '<Expiry Date>' is displayed for Expiry Date


    @TestCaseKey=PLX-T256 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                | Description                    | Security ID | Grant Date | Grant Date not Applicable | Expiry Date  | Expiry Date not Applicable | Vesting Schedule | Frequency | Vesting Amount | Rounding | Issue Price | Issue Price not Applicable | Exercise Price | Exercise Price not Applicable | Close Date   | Employee Wallet | Include Vesting Schedule? | Vesting Description |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto | CYPRESS-ESOP Offer 2023Q1 - #3 | ESOP3       | [Today]    | checked                   | [Today] + 60 | checked                    | Auto             | Annually  | 40%            | Nearest  | -           | checked                    | -              | checked                       | [Today] + 14 | No              | No                        | No Vesting Schedule |
