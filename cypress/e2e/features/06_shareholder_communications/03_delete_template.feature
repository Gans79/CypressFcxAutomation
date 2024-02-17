@PLX-2469 @setup
Feature: Shareholder Communications

  @TestCaseKey=PLX-T895
  Scenario Outline: As FCX Admin I should be able to Delete the created template for a company under investor communications.

    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Communications' is pressed
    When in FCX Admin Communications screen, 'Remove Template' action is selected
    And alert pop-up, Remove Template Confirmation, 'Cancel' is pressed
    And in FCX Admin Communications screen, 'Remove Template' action is selected
    And alert pop-up, Remove Template Confirmation, 'Confirm' is pressed
    Then alert pop-up, success, 'Template removed successfully' is displayed
    And in Communications, 'Button', 'Create a New Template' is displayed
    And in Communications, 'Button', 'Create Template' is displayed

    @ShareCommSmoke @DEV @TEST @run
    Examples:
      | Admin   |
      | PXAdmin |
