@PLX-2367 @setup
Feature: ESOP Offer - Create

  @PLX-2576
  Scenario Outline: As an Issuer User with ESOP access, I would like to create ESOP offer so that I can offer it to participants - Auto Vesting Schedule

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    When 'Create Offer' button is pressed
    And in 'Create Offer' pop-up, '<Plan Name>' Plan is displayed
    And in 'Create Offer' pop-up, '<Offer Name>' is entered into Offer Name
    And in 'Create Offer' pop-up, '<Description>' is entered into Description
    And in 'Create Offer' pop-up, '<Security ID>' is selected for Security ID
    And in 'Create Offer' pop-up, '<Grant Date>' is entered into Grant Date
    And in 'Create Offer' pop-up, 'Grant Date not Applicable' checkbox is <Grant Date not Applicable>
    And in 'Create Offer' pop-up, '<Expiry Date>' is entered into Expiry Date
    And in 'Create Offer' pop-up, 'Expiry Date not Applicable' checkbox is <Expiry Date not Applicable>
    And in 'Create Offer' pop-up, <Include Vesting Schedule?> radio is selected for 'Include Vesting Schedule'
    And in 'Create Offer' pop-up, '<Description>' is entered into Vesting Description
    And in 'Create Offer' pop-up, '<Issue Price>' is entered into Issue Price
    And in 'Create Offer' pop-up, 'Issue Price not Applicable' checkbox is <Issue Price not Applicable>
    And in 'Create Offer' pop-up, '<Exercise Price>' is entered into Exercise Price
    And in 'Create Offer' pop-up, 'Exercise Price not Applicable' checkbox is <Exercise Price not Applicable>
    And in 'Create Offer' pop-up, '<Close Date>' is entered into Close Date
    And in 'Create Offer' pop-up, <Employee Wallet> radio is selected for 'Employees nominates a different entity to recieve security'
    And in 'Create Offer' pop-up, 'Create' button is pressed
    Then in ESOP, '<Plan Name>', '<Offer Name>' is displayed
    And in ESOP, '<Plan Name>', 'Setup' is displayed

    @ESOPSmoke @TestCaseKey=PLX-T219 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                       | Description                    | Security ID | Grant Date | Grant Date not Applicable | Expiry Date  | Expiry Date not Applicable | Include Vesting Schedule? | Frequency | Vesting Amount | Rounding | Issue Price | Issue Price not Applicable | Exercise Price | Exercise Price not Applicable | Close Date   | Employee Wallet |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 2 Closed Auto | ESOP1 Offer 2 for closing auto | ESOP1       | [Today]    | unchecked                 | [Today] + 90 | unchecked                  | No                        | Annually  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |
      | Owner  | IC Trading Co | CYPRESS-ESOP Plan1    | CYPRESS-ESOP Offer 2 Closed Auto | ESOP2 Offer 2 for closing auto | ESOP2       | [Today]    | unchecked                 | [Today] + 90 | unchecked                  | No                        | Annually  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |


    @ESOPRegression @TestCaseKey=PLX-T219 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                       | Description                    | Security ID | Grant Date | Grant Date not Applicable | Expiry Date  | Expiry Date not Applicable | Include Vesting Schedule? | Frequency | Vesting Amount | Rounding | Issue Price | Issue Price not Applicable | Exercise Price | Exercise Price not Applicable | Close Date   | Employee Wallet |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto        | ESOP3 Offer 1                  | ESOP3       | [Today]    | unchecked                 | [Today] + 90 | unchecked                  | No                        | Annually  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |
      #PLX-3525
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 2 Closed Auto | ESOP4 Offer 2 for closing auto | ESOP4       | [Today]    | unchecked                 | [Today] + 90 | unchecked                  | No                        | Annually  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |
 

  @PLX-2576 
  Scenario Outline: As an Issuer User with ESOP access, I would like to create ESOP offer so that I can offer it to participants - Manual multiple Vesting Schedule

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    When 'Create Offer' button is pressed
    And in 'Create Offer' pop-up, '<Plan Name>' Plan is displayed
    And in 'Create Offer' pop-up, '<Offer Name>' is entered into Offer Name
    And in 'Create Offer' pop-up, '<Description>' is entered into Description
    And in 'Create Offer' pop-up, '<Security ID>' is selected for Security ID
    And in 'Create Offer' pop-up, '<Grant Date>' is entered into Grant Date
    And in 'Create Offer' pop-up, 'Grant Date not Applicable' checkbox is <Grant Date not Applicable>
    And in 'Create Offer' pop-up, '<Expiry Date>' is entered into Expiry Date
    And in 'Create Offer' pop-up, 'Expiry Date not Applicable' checkbox is <Expiry Date not Applicable>
    And in 'Create Offer' pop-up, <Include Vesting Schedule?> radio is selected for 'Include Vesting Schedule'
    And in 'Create Offer' pop-up, '<Description>' is entered into Vesting Description
    And in 'Create Offer' pop-up, '<Issue Price>' is entered into Issue Price
    And in 'Create Offer' pop-up, 'Issue Price not Applicable' checkbox is <Issue Price not Applicable>
    And in 'Create Offer' pop-up, '<Exercise Price>' is entered into Exercise Price
    And in 'Create Offer' pop-up, 'Exercise Price not Applicable' checkbox is <Exercise Price not Applicable>
    And in 'Create Offer' pop-up, '<Close Date>' is entered into Close Date
    And in 'Create Offer' pop-up, <Employee Wallet> radio is selected for 'Employees nominates a different entity to recieve security'
    And in 'Create Offer' pop-up, 'Create' button is pressed
    Then in ESOP, '<Plan Name>', '<Offer Name>' is displayed
    And in ESOP, '<Plan Name>', 'Setup' is displayed
  
    @ESOPSmoke @TestCaseKey=PLX-T244 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name             | Offer Name                         | Description                  | Security ID | Grant Date | Grant Date not Applicable | Expiry Date  | Expiry Date not Applicable | Include Vesting Schedule? | Vesting Date | Vesting Amount | Rounding | Issue Price | Issue Price not Applicable | Exercise Price | Exercise Price not Applicable | Close Date   | Employee Wallet |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Closed Manual | ESOP5 Offer 1 closing manual | ESOP5       |            | checked                   | [Today] + 90 | unchecked                  | No                        | [Today] + 1  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |
      | Owner  | IC Trading Co | CYPRESS-ESOP Plan1    | CYPRESS-ESOP Offer 1 Closed Manual | ESOP6 Offer 1 closing manual | ESOP6       |            | checked                   | [Today] + 90 | unchecked                  | No                        | [Today] + 1  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |


    @ESOPRegression @TestCaseKey=PLX-T244 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                         | Description                  | Security ID | Grant Date | Grant Date not Applicable | Expiry Date  | Expiry Date not Applicable | Include Vesting Schedule? | Vesting Date | Vesting Amount | Rounding | Issue Price | Issue Price not Applicable | Exercise Price | Exercise Price not Applicable | Close Date   | Employee Wallet |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual        | ESOP7 Offer 1                | ESOP7       |            | checked                   | [Today] + 90 | unchecked                  | No                        | [Today] + 1  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |
      #PLX-3525
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual | ESOP8 Offer 1 closing manual | ESOP8       |            | checked                   | [Today] + 90 | unchecked                  | No                        | [Today] + 1  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |
      | Owner  | IC Trading Co | CYPRESS-ESOP Delete          | CYPRESS-ESOP Offer Delete          | ESOP8 Offer for delete       | ESOP9       |            | checked                   | [Today] + 90 | unchecked                  | No                        | [Today] + 1  | 40%            | Nearest  | 10          | checked                    | 5              | checked                       | [Today] + 60 | No              |