@setup
Feature: ESOP role

  @ESOPSmoke @ESOPRegression @PLX-3120 @PLX-2864 
  Scenario Outline: AC2: As an Issuer User, I should be able to “edit” existing users access and grant them ESOP access so they can view and edit ESOP section & manage securities
    Given '<Issuer>' is logged in to FCX 'App'
    # And user has role ESOP
    And in Company View, <Company> tile is pressed
    And URL contains '/dashboard'
    And Company menu 'Company' is pressed
    And Company menu 'Users' is pressed
    And loading is complete
    And company user actions for <Issuer> is pressed
    When 'Edit Role' action is pressed
    Then 'Update roles for Fcx Owner' pop-up is displayed
    And 'ESOP' checkbox is set to enabled
    And 'Save' button is pressed
   
   @TestCaseKey=PLX-T9 @DEV @TEST @run
    Examples:
      | Issuer | Company       |
      | Owner  | IC Trading Co |

  @ESOPSmoke @ESOPRegression @PLX-3121 @PLX-2864 
  Scenario Outline: AC1: As an Issuer User, I should be able to add new user with their name & email address and grant them ESOP access so that they can view & edit ESOP section
    Given '<Issuer>' is logged in to FCX 'App'
    # And user has role ESOP
    And in Company View, <Company> tile is pressed
    And URL contains '/dashboard'
    And Company menu 'Company' is pressed
    And Company menu 'Users' is pressed
    When 'Add New User' button is pressed
    And 'Add New User' pop-up is displayed
    And Name '<Name>' is entered
    And Email '<Email>' is entered
    And 'ESOP' checkbox is set to enabled
    ### Not saving - just a validation
    # And 'Save' button is pressed

    @TestCaseKey=PLX-T10 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Name     | Email                         |
      | Owner  | IC Trading Co | Fcx ESOP | fcx.tester+dev_esop@gmail.com |
