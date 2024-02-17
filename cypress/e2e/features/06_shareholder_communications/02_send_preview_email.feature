@PLX-2469 @setup
Feature: Shareholder Communications

  @TestCaseKey=PLX-T894
  Scenario Outline: As FCX Admin I should be able to Send the Preview of the created template under investor communications.

    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Communications' is pressed
    When in FCX Admin Communications screen, 'Edit Template' action is selected
    And in FCX Admin Communications screen, '<Updated Template Name>' is entered into Template Name
    And 'Send Preview' button is pressed
    And alert pop-up, Send Email Preview, 'Cancel' is pressed
    And 'Send Preview' button is pressed
    And in 'Send Email Preview' pop-up, '<Email>' is entered into Email
    And in 'Send Email Preview' pop-up, '<Subject>' is entered into Subject
    And alert pop-up, Send Email Preview, 'Send Now' is pressed
    Then 'Email sent' title page is displayed
    And '<Email>' text is displayed
    And '<Subject>' text is displayed
    And 'Done' button is pressed

    @ShareCommSmoke @DEV @TEST @run 
    Examples:
      | Admin   | Updated Template Name           | Email                 | Subject      |
      | PXAdmin | Template Test 1 updated         | fcx.tester@gmail.com  | test subject |
