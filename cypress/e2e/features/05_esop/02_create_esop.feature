@PLX-2346 @setup
Feature: Set up ESOPs
    Pre-requisite:
    And user has role ESOP
    And can access dashboard

  @ESOPRegression @PLX-2559
  Scenario Outline: As a FCX admin, I want to be able to create ESOP plan if Issuer is already on boarded or onboard & create ESOP plan

    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'ESOP' is pressed
    And loading is complete
    When 'Create ESOP' button is pressed
    And in 'Create ESOP' pop-up, '<Company>' is selected for Issuer
    And in 'Create ESOP' pop-up, '<Plan Name>' is entered into Plan Name
    And in 'Create ESOP' pop-up, '<Description>' is entered into Description
    And in 'Create ESOP' pop-up, 'Create' button is pressed
    Then 'ESOP' main header is displayed
    And 'ESOP' table, displays details
      | Company   | ESOP Pool | Plan Name   | Created | Status |
      | <Company> |           | <Plan Name> | [Today] | Active |

    @TestCaseKey=PLX-T199 @DEV @run
    Examples:
      | Admin   | Company       | Plan Name             | Description                   |
      | PXAdmin | IC Trading Co | CYPRESS-ESOP 2023Q1#1 | CYPRESS-ESOP 2023Q1 - Plan #1 |

  @ESOPSmoke @ESOPRegression @PLX-2560
  Scenario Outline: As Issuer, I want to be able to create ESOP plan if Issuer is already on boarded or onboard & create ESOP plan

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And URL contains '/dashboard'
    And company menu 'ESOP' is pressed
    When 'Create Plan' button is pressed
    And in 'Create Plan' pop-up, '<Plan Name>' is entered into Plan Name
    And in 'Create Plan' pop-up, '<Description>' is entered into Description
    And in 'Create Plan' pop-up, '<Vesting>' is entered into Vesting
    And in 'Create Plan' pop-up, 'Create' button is pressed
    Then in 'Current Plans' section, '<Plan Name>' is displayed

    @TestCaseKey=PLX-T200 @DEV @TEST @run 
    Examples:
      | Issuer | Company       | Plan Name             | Description              | Vesting |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP 2023Q1 - #3 |         |
      | Owner  | IC Trading Co | CYPRESS-ESOP Plan1    | ESOP Plan 1              | 5       |
      | Owner  | IC Trading Co | CYPRESS-ESOP Delete   | ESOP Plan Delete         | 5       |


  @ESOPRegression @PLX-2737
  Scenario Outline: Edit ESOP Plan -  as FCX Admin

    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'ESOP' is pressed
    When in 'ESOP' table, 'Edit' action for row detail is selected
      | Company   | ESOP Pool | Plan Name   | Created | Status |
      | <Company> |           | <Plan Name> |         | Active |
    And in 'Edit ESOP' pop-up, '<Company>' Issuer is displayed
    When in 'Edit ESOP' pop-up, '<Plan Name>updated' is entered into Plan Name
    And in 'Edit ESOP' pop-up, '<Description> updated' is entered into Description
    And in 'Edit ESOP' pop-up, 'Save' button is pressed
    Then 'ESOP' main header is displayed
    And 'ESOP' table, displays details
      | Company   | ESOP Pool | Plan Name          | Created | Status |
      | <Company> |           | <Plan Name>updated | [Today] | Active |
    @TestCaseKey=PLX-T221 @DEV @run
    Examples:
      | Admin   | Company       | Plan Name             | Description                   |
      | PXAdmin | IC Trading Co | CYPRESS-ESOP 2023Q1#1 | CYPRESS-ESOP 2023Q1 - Plan #1 |

  @ESOPRegression @PLX-2736
  Scenario Outline: As FCX Admin verify Active, no Pool
    AC1: As an FCX admin/Issuer user with ESOP access, I should be able to archive ESOP plan when Issuer do not want to issue any further securities under that plan
    AC2: As an FCX admin/Issuer user with ESOP access, I should be able to see plan status as “archived”

    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'ESOP' is pressed
    And '<Company>' name is displayed
    And in 'Search', search for '<Company>'
    And 'ESOP' table, displays details
      | Company   | ESOP Pool   | Plan Name   | Created | Status |
      | <Company> | <ESOP Pool> | <Plan Name> | [Today] | Active |

    @TestCaseKey=PLX-T346 @DEV @run
    Examples:
      | Admin   | Company       | ESOP Pool | Plan Name             |
      | PXAdmin | IC Trading Co |           | CYPRESS-ESOP 2023Q1#1 |
