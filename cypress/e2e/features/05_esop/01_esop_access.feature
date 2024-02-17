@PLX-2864 @setup
Feature: ESOP access

  @ESOPSmoke @ESOPRegression @PLX-2968 @PLX-2864
  Scenario Outline: As an issuer user with ESOP access, I should be able to see the ESOP landing page
    + @PLX-2864 AC3: Only issuer user with ESOP access can see ESOP section

    Given '<Issuer>' is logged in to FCX 'App'
    # And user has role ESOP
    And in Company View, <Company> tile is pressed
    And URL contains '/dashboard'
    When company menu 'ESOP' is pressed
    Then 'ESOP' main Header is displayed
    And 'ESOP' text is displayed
    And 'Current Plans' text is displayed
    And 'Past Plans' text is displayed

    @TestCaseKey=PLX-T197 @DEV @TEST @run
    Examples:
      | Issuer | Company       |
      | Owner  | IC Trading Co |

  @ESOPSmoke @ESOPRegression @PLX-2864
  Scenario: Other users cannot see ESOP section

    Given '<Issuer>' is logged in to FCX 'app'
    When in Company View, <Company> tile is pressed
    Then in company menu 'ESOP' is not visible

    @TestCaseKey=PLX-T198 @DEV @TEST @run
    Examples:
      | Issuer    | Company       |
      | Secretary | IC Trading Co |