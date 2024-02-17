@PLX-2340
Feature: ESOP Offer - Issuer Dashboard

  @TestCaseKey=PLX-T806
  Scenario Outline: Issuer user with ESOP access should be able to see Top 10 participants on ESOP Issuer Dashboard

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    Then in ESOP Dashboard, Top ESOP Participants display details
      | Participant Name     | Balance  | 
      | Fcx Tester Employee1 | 1,500    | 
      | Fcx Tester Employee1 | 1,000    | 

    @ESOPSmoke @DEV @TEST @run
    Examples:
      | Issuer | Company       |
      | Owner  | IC Trading Co | 
