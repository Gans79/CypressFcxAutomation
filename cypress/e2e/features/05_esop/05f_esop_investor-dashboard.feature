@PLX-2349 
Feature: ESOP Offer - Investor Dashboard

   @TestCaseKey=PLX-T810
   Scenario Outline: Investor dashboard: Issuer edit individual investor Employee Details | Investor has Green wallet | Employee Name = Investor Name

    Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And inside Participant Holdings, '<Wallet Name>' tile is pressed
    Then inside Participant ESOP tab, display details 
      | Employee Name    | Unvested | Vested | Total | 
      | <Employee Name>  | 1,500    |  0     | 1,500 | 
 
   @ESOPSmoke @ESOPRegression @DEV @TEST @run
    Examples:
      | Participant           | Employee Name        | Company       | Wallet Name    | 
      | Participant_employee1 | FCX TESTER EMPLOYEE1 | IC Trading Co | FCX EMPLOYEE1  | 
