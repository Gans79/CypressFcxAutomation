Feature: Company Owner 
I want to login as owner of the company 

 @TestCaseKey=PLX-T977
  Scenario Outline: As a company owner i want to login and view investors
    Given '<Participant>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And Company menu 'Cap Table' is pressed
    And Cap Table menu 'Investors' is pressed
    Then in Investors tab, Holdings Summary Table display details
      | Shareholders Name        | Shareholder Name 2          | Group Name   | Employee | Primary Email Address  | Total Securities | In Wallet |
      | FCX INVESTOR2COMPANY     |                             |              | -        | <Investor2 Email>      | 200              |           |
      | FCX ALPHA INVESTOR1      |                             |              | Yes      | <Investor1 Email>      | 100              |           |
      | FCX GAMA INVESTOR3JOINT1 | FCX CHARLIE INVESTOR3JOINT2 |              | -        | <Investor3 Email>      | 300              |           |

  @CompanySmoke @DEV 
    Examples:
      | Participant   | Company                | Investor1 Email                          | Investor2 Email                          | Investor3 Email                          |
      | company_owner | CYPRESS-FCX Trading Co | FCX.DEV.TESTER+INVESTOR1@FINCLEAR.COM.AU | FCX.DEV.TESTER+INVESTOR2@FINCLEAR.COM.AU | FCX.DEV.TESTER+INVESTOR3@FINCLEAR.COM.AU |

  @CompanySmoke @TEST 
    Examples:
      | Participant   | Company                | Investor1 Email                           | Investor2 Email                           | Investor3 Email                           |
      | company_owner | CYPRESS-FCX Trading Co | FCX.TEST.TESTER+INVESTOR1@FINCLEAR.COM.AU | FCX.TEST.TESTER+INVESTOR2@FINCLEAR.COM.AU | FCX.TEST.TESTER+INVESTOR3@FINCLEAR.COM.AU |