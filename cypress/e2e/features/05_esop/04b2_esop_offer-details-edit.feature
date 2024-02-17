@PLX-3154 @setup
Feature: PLX-3154- Set Up Plans/Offer Enhancements

    Scenario Outline: Delete Offer from plan page [Offer status] = 'Setup'

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And 'Details' tab title is displayed
    When in 'ESOP Offer' page, 'Details' tab, 'Delete' action is selected
    And alert pop-up, Delete Offer, 'Confirm' is pressed
    And in ESOP, '<Offer Name>' is not displayed for '<Plan Name>'

    @ESOPSmoke @TestCaseKey=PLX-T508 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                         | 
      | Owner  | IC Trading Co | CYPRESS-ESOP Plan1    | CYPRESS-ESOP Offer 1 Closed Manual | 

    @ESOPRegression @TestCaseKey=PLX-T508 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                         | 
      | Owner  | IC Trading Co | CYPRESS-ESOP Delete  | CYPRESS-ESOP Offer Delete         | 


  @ESOPRegression @PLX-2772
  Scenario Outline: As an Issuer admin with ESOP access, I should be able to edit the offer details at any point in time - Auto

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> Cloned tile is pressed
    And 'Details' tab title is displayed
    When in 'ESOP Offer' page, 'Details' tab, 'Edit' action is selected
    And in 'Edit Offer' pop-up, '<Plan Name>' plan is displayed
    And in 'Edit Offer' pop-up, '<Offer Name> updated' is entered into Offer Name
    And in 'Edit Offer' pop-up, '<Description> updated' is entered into Description
    # And in 'Create Offer' pop-up, '<Security ID>' is selected for Security ID
    And in 'Edit Offer' pop-up, 'Grant Date not Applicable' checkbox is <Grant Date not Applicable>
    And in 'Edit Offer' pop-up, '<Grant Date>' is entered into Grant Date
    And in 'Edit Offer' pop-up, 'Expiry Date not Applicable' checkbox is <Expiry Date not Applicable>
    And in 'Edit Offer' pop-up, '<Expiry Date>' is entered into Expiry Date

    And in 'Edit Offer' pop-up, 'Issue Price not Applicable' checkbox is <Issue Price not Applicable>
    And in 'Edit Offer' pop-up, '<Issue Price>' is entered into Issue Price
    And in 'Edit Offer' pop-up, 'Exercise Price not Applicable' checkbox is <Exercise Price not Applicable>
    And in 'Edit Offer' pop-up, '<Exercise Price>' is entered into Exercise Price
    And in 'Edit Offer' pop-up, '<Close Date>' is entered into Close Date
    And in 'Edit Offer' pop-up, <Employee Wallet> radio is selected for 'Employees nominates a different entity to recieve security'
    And in 'Edit Offer' pop-up, 'Save' button is pressed
    Then in 'ESOP' page, 'Details' tab, '<Plan Name>' is displayed for Plan Name
    And in 'ESOP' page, 'Details' tab, '<Description> updated' is displayed for Description
    And in 'ESOP' page, 'Details' tab, '<Security ID>' is displayed for Security ID
    And in 'ESOP' page, 'Details' tab, '<Issue Price>' is displayed for Issue Price
    And in 'ESOP' page, 'Details' tab, '<Exercise Price>' is displayed for Exercise Price
    And in 'ESOP' page, 'Details' tab, '<Grant Date>' is displayed for Grant Date
    And in 'ESOP' page, 'Details' tab, '<Close Date>' is displayed for Close Date
    And in 'ESOP' page, 'Details' tab, '<Expiry Date>' is displayed for Expiry Date

    @TestCaseKey=PLX-T253 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  | Description   | Security ID | Grant Date | Grant Date not Applicable | Expiry Date | Expiry Date not Applicable | Vesting Schedule | Frequency   | Vesting Amount | Rounding   | Issue Price | Issue Price not Applicable | Exercise Price | Exercise Price not Applicable | Close Date | Employee Wallet |
      #TODO need to fix price decimal point 
      #| Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | ESOP7 Offer 1 | ESOP7       | [Today]    | unchecked                 | [Today] + 2 | unchecked                  | Auto             | Half Yearly | 33%            | Round Down | 10.5        | unchecked                  | 5.5            | unchecked                     | [Tomorrow] | Yes             |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | ESOP7 Offer 1 | ESOP7       | [Today]    | unchecked                 | [Today] + 2 | unchecked                  | Auto             | Half Yearly | 33%            | Round Down | 105        | unchecked                  | 55            | unchecked                     | [Tomorrow] | Yes             |

  @ESOPRegression @PLX-2772 
  Scenario Outline: As an Issuer admin with ESOP access, I should be able to edit the offer details at any point in time - Manual

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> updated tile is pressed
    And 'Details' tab title is displayed
    When in 'ESOP Offer' page, 'Details' tab, 'Edit' action is selected
    And in 'Edit Offer' pop-up, '<Plan Name>' plan is displayed
    And in 'Edit Offer' pop-up, '<Offer Name> Updated' is entered into Offer Name
    And in 'Edit Offer' pop-up, '<Description> Updated' is entered into Description
    # And in 'Create Offer' pop-up, '<Security ID>' is selected for Security ID
    And in 'Edit Offer' pop-up, 'Grant Date not Applicable' checkbox is <Grant Date not Applicable>
    And in 'Edit Offer' pop-up, '<Grant Date>' is entered into Grant Date
    And in 'Edit Offer' pop-up, 'Expiry Date not Applicable' checkbox is <Expiry Date not Applicable>
    And in 'Edit Offer' pop-up, '<Expiry Date>' is entered into Expiry Date

    And in 'Edit Offer' pop-up, 'Issue Price not Applicable' checkbox is <Issue Price not Applicable>
    And in 'Edit Offer' pop-up, 'Exercise Price not Applicable' checkbox is <Exercise Price not Applicable>
    And in 'Edit Offer' pop-up, '<Close Date>' is entered into Close Date
    And in 'Edit Offer' pop-up, <Employee Wallet> radio is selected for 'Employees nominates a different entity to recieve security'
    And in 'Edit Offer' pop-up, 'Save' button is pressed
    Then in 'ESOP' page, 'Details' tab, '<Plan Name>' is displayed for Plan Name
    And in 'ESOP' page, 'Details' tab, '<Description> Updated' is displayed for Description
    And in 'ESOP' page, 'Details' tab, '<Security ID>' is displayed for Security ID
    And in 'ESOP' page, 'Details' tab, '<Issue Price>' is displayed for Issue Price
    And in 'ESOP' page, 'Details' tab, '<Exercise Price>' is displayed for Exercise Price
    And in 'ESOP' page, 'Details' tab, '<Grant Date>' is displayed for Grant Date
    And in 'ESOP' page, 'Details' tab, '<Close Date>' is displayed for Close Date
    And in 'ESOP' page, 'Details' tab, '<Expiry Date>' is displayed for Expiry Date

    @TestCaseKey=PLX-T254 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  | Description   | Security ID | Grant Date | Grant Date not Applicable | Expiry Date  | Expiry Date not Applicable | Vesting Schedule | Vesting Date | Vesting Amount | Rounding | Issue Price | Issue Price not Applicable | Exercise Price | Exercise Price not Applicable | Close Date   | Employee Wallet |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | ESOP7 Offer 1 | ESOP7       | [Today]    | unchecked                 | [Today] + 90 | unchecked                  | Manual           | [Today] + 1  | 40%            | Nearest  | -           | checked                    | -              | checked                       | [Today] + 60 | No              |