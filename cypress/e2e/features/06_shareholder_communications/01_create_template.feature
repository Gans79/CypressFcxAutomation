@PLX-2469 @setup
Feature: Shareholder Communications

  @TestCaseKey=PLX-T890
  Scenario Outline: As an FCX admin, I want to be able to provide “FCX Introduction email” template so that issuers can use this template in their communication with their shareholders

    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Communications' is pressed
    When 'Create Template' button is pressed
    And in FCX Admin Communications screen, '<Template Name>' is entered into Template Name
    And in FCX Admin Communications screen, '<Template Body>' is entered into Template Body
    And in FCX Admin Communications screen, '<Template Footer>' is entered into Template Footer
    And 'Save' button is pressed
    And alert pop-up, Save Template Confirmation, 'Save' is pressed
    Then alert pop-up, success, 'Template saved successfully' is displayed
    And in Communications, 'Template Name', '<Template Name>' is displayed
    And in Communications, 'Template Body', '<Template Body>' is displayed
    And in Communications, 'Template Footer', '<Template Footer>' is displayed

    @ShareCommSmoke @DEV @TEST @run
    Examples:
      | Admin   | Template Name   | Template Body              | Template Footer              |
      | PXAdmin | Template Test 1 | This is test template body | This is test template footer |
