# Not yet complete
Feature: Archive Plan

    @PLX-2738
    Scenario Outline: Archive Plan - As FCX Admin
        AC1: As an FCX admin/Issuer user with ESOP access, I should be able to archive ESOP plan when Issuer do not want to issue any further securities under that plan
        AC2: As an FCX admin/Issuer user with ESOP access, I should be able to see plan status as “archived”

        Given '<Admin>' is logged in to FCX 'PXAdmin'
        And FCX Concierge menu 'ESOP' is pressed
        And progress is complete
        When in 'ESOP' table, 'Archive' action for row detail is selected
            | Company   | ESOP Pool   | Plan Name   | Created | Status |
            | <Company> | <ESOP Pool> | <Plan Name> |         | Active |
        And in 'Archive Plan' pop-up, 'Confirm' button is pressed
        And 'ESOP' table, displays details
            | Company   | ESOP Pool   | Plan Name   | Created | Status   |
            | <Company> | <ESOP Pool> | <Plan Name> |         | Archived |

        @TestCaseKey=PLX-T234 @DEV @TEST 
        Examples:
            | Admin   | Company       | Plan Name                    | ESOP Pool |
            | PXAdmin | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | 9.00%     |

    @PLX-2738
    Scenario: Archive Plan - As Issuer
        AC1: As an FCX admin/Issuer user with ESOP access, I should be able to archive ESOP plan when Issuer do not want to issue any further securities under that plan
        AC2: As an FCX admin/Issuer user with ESOP access, I should be able to see plan status as “archived”

        Given '<Issuer>' is logged in to FCX 'App'
        And in Company View, <Company> tile is pressed
        And company menu 'ESOP' is pressed
        And in ESOP, <Plan Name> tile is pressed
        When more actions 'Archive' is selected
        And in 'Archive Plan' pop-up, 'Confirm' button is pressed
        Then in ESOP, 'Past Plan' section, shows row details
            | Company   | Plan Name   | Created | Archived |
            | <Company> | <Plan Name> | <Date>  | <Date>   |

        @TestCaseKey=PLX-T236 @DEV @TEST 
        Examples:
            | Issuer | Company       | Plan Name             | Date    |
            | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#2 | [Today] |


    @PLX-2738  @PLX-2736
    Scenario Outline: Archive Plan - As FCX Admin verify archived
        AC1: As an FCX admin/Issuer user with ESOP access, I should be able to archive ESOP plan when Issuer do not want to issue any further securities under that plan
        AC2: As an FCX admin/Issuer user with ESOP access, I should be able to see plan status as “archived”

        Given '<Admin>' is logged in to FCX 'PXAdmin'
        And FCX Concierge menu 'ESOP' is pressed
        And '<Company>' name is displayed
        And in 'Search', search for '<Company>'
        Then 'ESOP' table, displays details
            | Company   | ESOP Pool   | Plan Name            | Created | Status   |
            | <Company> | <ESOP Pool> | <Archived Plan Name> | [Today] | Archived |
        And 'ESOP' table, displays details
            | Company   | ESOP Pool   | Plan Name          | Created | Status |
            | <Company> | <ESOP Pool> | <Active Plan Name> | [Today] | Active |

        @TestCaseKey=PLX-T237 @DEV @TEST 
        Examples:
            | Admin   | Company       | ESOP Pool | Archived Plan Name           | Active Plan Name         |
            | PXAdmin | IC Trading Co | 9.00%     | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP 2023Q1#3    |

        @TestCaseKey=PLX-T345 @DEV @TEST 
        Examples:
            | Admin   | Company       | ESOP Pool | Archived Plan Name         | Active Plan Name         |
            | PXAdmin | IC Trading Co | 9.00%     | CYPRESS-ESOP 2023Q1#2      | CYPRESS-ESOP 2023Q1#3    |

    @PLX-2738 @PLX-2736
    Scenario: Archive Plan - As Issuer verify archived
        AC1: As an FCX admin/Issuer user with ESOP access, I should be able to archive ESOP plan when Issuer do not want to issue any further securities under that plan
        AC2: As an FCX admin/Issuer user with ESOP access, I should be able to see plan status as “archived”

        Given '<Issuer>' is logged in to FCX 'App'
        And in Company View, <Company> tile is pressed
        When company menu 'ESOP' is pressed
        Then in 'Current Plans' section, '<Current Plan Name>' is displayed
        And in ESOP, 'Past Plan' section, shows row details
            | Company   | Plan Name            | Created | Archived |
            | <Company> | <Archived Plan Name> | <Date>  | <Date>   |


        @TestCaseKey=PLX-T255 @DEV @TEST 
        Examples:
            | Issuer | Company       | Current Plan Name         | Archived Plan Name         | Date    |
            | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3     | CYPRESS-ESOP 2023Q1#2      | [Today] |
        @TestCaseKey=PLX-T347 @DEV @TEST 
        Examples:
            | Issuer | Company       | Current Plan Name         | Archived Plan Name           | Date    |
            | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3     | CYPRESS-ESOP 2023Q1#1updated | [Today] |
