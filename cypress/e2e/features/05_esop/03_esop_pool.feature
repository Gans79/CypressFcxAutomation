@PLX-2346 @setup
Feature: ESOP Pool
  Pre-requisite:
  Get total number of securities

  @PLX-2863 @TestCaseKey=PLX-T217 @DEV @run
  Scenario Outline: As a FCX admin/Issuer user with ESOP access, I should be able to input ESOP Pool - on ESOP creation

    Given 'PXAdmin' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'ESOP' is pressed
    When 'Create ESOP' button is pressed
    And in 'Create ESOP' pop-up, '<Company>' is selected for Issuer
    ### TODO: Get Issued Capital from Dashboard
    And in 'Create ESOP' pop-up, '<Issued Capital>' Issued Capital is displayed
    ## When in 'Create ESOP' pop-up, '<Amount>' is entered into Amount
    ## And in 'Create ESOP' pop-up, '<Percentage>' percentage is displayed
    And in 'Create ESOP' pop-up, '<Plan Name>' is entered into Plan Name
    # And in 'Create ESOP' pop-up, '<Description>' is entered into Description
    And in 'Create ESOP' pop-up, 'Create' button is pressed
    Then 'ESOP' main header is displayed
    And 'ESOP' table, displays details
      | Company   | ESOP Pool     | Plan Name   | Created | Status |
      | <Company> | <Percentage>% | <Plan Name> | [Today] | Active |

    Examples:
      | Issuer | Company       | Plan Name             | Description              | Issued Capital |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#2 | CYPRESS-ESOP 2023Q1 - #2 | 100,000        | 
 

  @PLX-2863 @TestCaseKey=PLX-T218 @DEV @run
  Scenario Outline: As a FCX admin/Issuer user with ESOP access, I should be able to input ESOP Pool - on existing ESOP

    Given 'PXAdmin' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'ESOP' is pressed
    When in 'ESOP' table, 'Edit' action for row detail is selected
      | Company   | ESOP Pool | Plan Name   | Created | Status |
      | <Company> |           | <Plan Name> | [Today] | Active |
    And in 'Create ESOP' pop-up, '<Issued Capital>' Issued Capital is displayed
    And in 'Create ESOP' pop-up, 'Save' button is pressed
    Then 'ESOP' main header is displayed
    And 'ESOP' table, displays details
      | Company   | ESOP Pool     | Plan Name   | Created | Status |
      | <Company> | <Percentage>% | <Plan Name> | [Today] | Active |

    Examples:
      | Issuer | Company       | Plan Name             | Description              | Issued Capital | 
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#2 | CYPRESS-ESOP 2023Q1 - #2 | 100,000        | 
   

  ## TC need to be updated as part of PLX-3584 
  ##@ESOP-Set-up-plans @PLX-2863 @TestCaseKey=PLX-T225 @DEV @run
  ##
  ##Scenario Outline: As an Issuer admin with ESOP access, I should be able to input ESOP Pool
  ##  Includes:
  ##  + Checks the ESOP Pool section
  ##  Pre-requisite:
  ##  + PLX-T200 As Issuer, I want to be able to create ESOP plan if Issuer is already on boarded or onboard & create ESOP plan

  ##  Given '<Issuer>' is logged in to FCX 'App'
  ##  And in Company View, <Company> tile is pressed
  ##  And company menu 'ESOP' is pressed
  ##  And in ESOP, 'ESOP Pool' section, displays
  ##    | ESOP Pool (Percentage) | Total Pool | Unallocated | Allocated   | Participants   |
  ##    | <Percentage>           | <Amount>   | <Amount>    | <Allocated> | <Participants> |
  ##  When in 'ESOP' page, 'ESOP Pool' section, 'Edit' button is pressed
  ##  ### TODO: Get Issued Capital from Dashboard
  ##  And in 'ESOP Pool' pop-up, '<Issued Capital>' Issued Capital is displayed
  ##  ### Note: ESOP Pool (Percentage) uses <canvas> object, not tested/verified
  ##  And in 'ESOP Pool' pop-up, '<New Amount>' is entered into Amount
  ##  And in 'ESOP Pool' pop-up, '<Updated Percentage>' percentage is displayed
  ##  And in 'ESOP Pool' pop-up, 'Save' button is pressed
  ##  And 'Pool updated.' text is displayed
  ##  Then in ESOP, 'ESOP Pool' section, displays
  ##    | ESOP Pool (Percentage) | Total Pool       | Unallocated      | Allocated   | Participants   |
  ##    | <Percentage>           | <Updated Amount> | <Updated Amount> | <Allocated> | <Participants> |

  ##   ### Revert
  ##  When in 'ESOP' page, 'ESOP Pool' section, 'Edit' button is pressed
  ##  ### TODO: Get Issued Capital from Dashboard
  ##  And in 'ESOP Pool' pop-up, '<Issued Capital>' Issued Capital is displayed
  ##  And in 'ESOP Pool' pop-up, '<Percentage>' is entered into Percentage
  ##  ### Change in display is replaced in the Then step
  ##  # And in 'ESOP Pool' pop-up, '<Amount>' percentage is displayed
  ##  And in 'ESOP Pool' pop-up, 'Save' button is pressed
  ##  And 'Pool updated.' text is displayed
  ##  Then in ESOP, 'ESOP Pool' section, displays
  ##    | ESOP Pool (Percentage) | Total Pool       | Unallocated      | Allocated   | Participants   |
  ##    | <Percentage>           | <Updated Amount> | <Updated Amount> | <Allocated> | <Participants> |

  ##  Examples:
  ##    | Issuer | Company       | Plan Name             | Description              | Issued Capital | Amount | Percentage | Allocated | Participants | New Amount | Updated Amount | Updated Percentage |
  ##    | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP 2023Q1 - #3 | 100,000        | 9,000  | 9%         | 0         | 0            | 8000       | 8,000          | 8.00               |
  ##  Examples:
  ##    | Issuer | Company       | Plan Name     | Description      | Issued Capital | Amount | Percentage | Allocated | Participants | New Amount | Updated Amount | Updated Percentage |
  ##    | Owner  | IC Trading Co | ESOP 2023Q1#3 | ESOP 2023Q1 - #3 | 100,000        | 9,000  | 9%         | 0         | 0            | 8000       | 8,000          | 8.00               |
