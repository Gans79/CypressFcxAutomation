Feature: Create new Wallet
  As PX Admin, I want to create new wallet 

  @TestCaseKey=PLX-T942
  Scenario Outline: As a Fcx Admin, Create new individual wallet 
    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Wallets' is pressed
    And in FCX Admin Wallets screen, 'Create Wallet' is pressed
    And in Create New Wallet screen pop-up, '<Company Name>' is entered into Issuer
    And in Create New Wallet screen pop-up, '<Investor>' is entered into Investor
    And in Create New Wallet screen pop-up, '<Individual1 Dob>' is entered into Date of Birth
    And in Create New Wallet screen pop-up, 'Create' is pressed
    And in New Wallet Created screen pop-up, 'Done' is pressed for '<Investor>'
    Then in FCX Admin Wallet screen table, display details
       | Wallet Type  | Wallet Name   | Account Designation | Users        | Date Created | Status   | 
       | Individual   | FCX INVESTOR1 |                     | <User Email> | [Today]      | Invited  |

    @WalletSmoke @DEV 
    Examples:
      | Admin   | Company Name            | Investor      | User Email                               | Individual1 Dob  | 
      | PXAdmin | CYPRESS-FCX Trading Co  | FCX INVESTOR1 | FCX.DEV.TESTER+INVESTOR1@FINCLEAR.COM.AU | 22/07/1979       |

    @WalletSmoke @TEST 
    Examples:
      | Admin   | Company Name            | Investor      | User Email                                | Individual1 Dob  |
      | PXAdmin | CYPRESS-FCX Trading Co  | FCX INVESTOR1 | FCX.TEST.TESTER+INVESTOR1@FINCLEAR.COM.AU | 22/07/1979       |

  @TestCaseKey=PLX-T943
  Scenario Outline: As a Fcx Admin, Create new joint wallet 
    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Wallets' is pressed
    And in FCX Admin Wallets screen, 'Create Wallet' is pressed
    And in Create New Wallet screen pop-up, '<Company Name>' is entered into Issuer
    And in Create New Wallet screen pop-up, '<Investor>' is entered into Investor
    And in Create New Wallet screen pop-up, '<Individual1 Dob>' is entered into Date of Birth 
    And in Create New Wallet screen pop-up, 'Individual 2 Details' is pressed
    And in Create New Wallet screen pop-up, '<Individual2 Dob>' is entered into Date of Birth for individual2
    And in Create New Wallet screen pop-up, '<Individual2 Mob>' is entered into Mobile Number for individual2
    And in Create New Wallet screen pop-up, '<Individual2 Email>' is entered into Email Address for individual2
    And in Create New Wallet screen pop-up, '<Individual2 Email>' is entered into Confirm Email Address for individual2
    And in Create New Wallet screen pop-up, '<Individual2 Address>' is entered into Address Line1 for individual2
    And in Create New Wallet screen pop-up, '<Individual2 Suburb>' is entered into Suburb for individual2
    And in Create New Wallet screen pop-up, '<Individual2 State>' is entered into State for individual2
    And in Create New Wallet screen pop-up, '<Individual2 Postcode>' is entered into Postcode for individual2
    And in Create New Wallet screen pop-up, '<Individual2 Country>' is entered into Country for individual2
    And in Create New Wallet screen pop-up, 'Create' is pressed
    And in New Wallet Created screen pop-up, 'Done' is pressed for '<Investor>'
    Then in FCX Admin Wallet screen table, display details
       | Wallet Type  | Wallet Name   | Account Designation | Users               | Date Created | Status   | 
       | Joint        | FCX INVESTOR3 |                     | <Individual1 Email> | [Today]      | Invited  |

    @WalletSmoke @DEV 
    Examples:
      | Admin   | Company Name            | Investor            | Individual1 Email                        | Individual1 Dob  | Individual2 Email                        | Individual2 Dob | Individual2 Mob | Individual2 Address | Individual2 Suburb | Individual2 State | Individual2 postcode | Individual2 Country |
      | PXAdmin | CYPRESS-FCX Trading Co  | FCX INVESTOR3JOINT1 | FCX.DEV.TESTER+INVESTOR3@FINCLEAR.COM.AU | 22/07/1979       | FCX.DEV.TESTER+INVESTOR4@FINCLEAR.COM.AU | 15/08/1985      | +61435099344    | 50 SAMPLE ST        | SYDNEY             | NEW SOUTH WALES   |  2000                | Australia           |

    @WalletSmoke @TEST 
    Examples:
      | Admin   | Company Name            | Investor            | Individual1 Email                         | Individual1 Dob  | Individual2 Email                        | Individual2 Dob | Individual2 Mob | Individual2 Address | Individual2 Suburb | Individual2 State | Individual2 postcode | Individual2 Country |
      | PXAdmin | CYPRESS-FCX Trading Co  | FCX INVESTOR3JOINT1 | FCX.TEST.TESTER+INVESTOR3@FINCLEAR.COM.AU | 22/07/1979       | FCX.TEST.TESTER+INVESTOR4@FINCLEAR.COM.AU | 15/08/1985      | +61435099344    | 50 SAMPLE ST        | SYDNEY             | NEW SOUTH WALES   |  2000                | Australia           |

@TestCaseKey=PLX-T944
  Scenario Outline: As a Fcx Admin, Create new company wallet 
    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Wallets' is pressed
    And in FCX Admin Wallets screen, 'Create Wallet' is pressed
    And in Create New Wallet screen pop-up, '<Company Name>' is entered into Issuer
    And in Create New Wallet screen pop-up, '<Investor>' is entered into Investor
    And in Create New Wallet screen pop-up, '<Authorised Firstname>' is entered into firstname for company
    And in Create New Wallet screen pop-up, '<Authorised Lastname>' is entered into lastname for company
    And in Create New Wallet screen pop-up, '<Authorised Position>' is entered into position for company
    And in Create New Wallet screen pop-up, '<Authorised Email>' is entered into email for company
    And in Create New Wallet screen pop-up, 'Check' is pressed
    And in Create New Wallet screen pop-up, 'Create' is pressed
    And in New Wallet Created screen pop-up, 'Done' is pressed for '<Investor>'
    Then in FCX Admin Wallet screen table, display details
       | Wallet Type  | Wallet Name          | Account Designation | Users               | Date Created | Status   | 
       | Company      | FCX INVESTOR2COMPANY |                     | <Authorised Email> | [Today]      | Invited  |

    @WalletSmoke @DEV 
    Examples:
      | Admin   | Company Name            | Investor             | Authorised Firstname | Authorised Lastname | Authorised Position | Authorised Email                         | 
      | PXAdmin | CYPRESS-FCX Trading Co  | FCX INVESTOR2COMPANY | FCX                  | INVESTOR2COMPANY    | DIRECTOR            | FCX.DEV.TESTER+INVESTOR2@FINCLEAR.COM.AU |

    @WalletSmoke @TEST 
    Examples:
      | Admin   | Company Name            | Investor             | Authorised Firstname | Authorised Lastname | Authorised Position | Authorised Email                         | 
      | PXAdmin | CYPRESS-FCX Trading Co  | FCX INVESTOR2COMPANY | FCX                  | INVESTOR2COMPANY    | DIRECTOR            | FCX.TEST.TESTER+INVESTOR2@FINCLEAR.COM.AU |

      

@TestCaseKey=PLX-T939
  Scenario Outline: As a Investor accepts wallet email invite
   Given '<Participant>' is logged in to FCX 'App'
    And Wallet owner, click on view your invite from email for <Investor Name>
    When inside Wallet Invitations, Accept the invite
    Then inside Wallet Invitations, Wallet invitation is not displayed
    

  @WalletSmoke @DEV @TEST
  Examples:
      | Participant | Investor Name | 
      | investor1   | FCX INVESTOR1 | 
      | investor3   | FCX INVESTOR3JOINT1  |
      | investor2   | FCX INVESTOR2COMPANY |

@TestCaseKey=PLX-T999
  Scenario Outline: As a Investor, Add Holdings to Wallet 
   Given '<Participant>' is logged in to FCX 'App'
    And in Add Holding to a Wallet screen pop-up, 'Next' is pressed
    And in Add Holding to a Wallet screen pop-up, 'Confirm' is pressed
    And in Request Sent screen pop-up, 'Close' is pressed
    Then 'Welcome to FCX' main header is displayed

    @WalletSmoke @DEV @TEST
    Examples:
      | Participant | Investor Name | 
      | investor1   | FCX INVESTOR1 | 
      | investor3   | FCX INVESTOR3JOINT1  | 
      | investor2   | FCX INVESTOR2COMPANY |



@TestCaseKey=PLX-T1000
  Scenario Outline: As an Issuer, Accept the investor request for Wallet transfer 
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And Company menu 'Cap Table' is pressed
    And Cap Table menu 'Requests' is pressed
    And in Issuer Requests screen, 3 dots is pressed next to '<Investor>'
    And in Issuer Requests screen, 'Review Request' is pressed
    And in Review Request screen pop-up, 'Authorise' is pressed
    Then in Requests screen, '<Investor>' is not visible
    
    @WalletSmoke @DEV @TEST 
    Examples:
      | Issuer        | Company                | Investor      | 
      | company_owner | CYPRESS-FCX Trading Co | Fcx Investor1 |
      | company_owner | CYPRESS-FCX Trading Co | Fcx Investor3 |
      | company_owner | CYPRESS-FCX Trading Co | Fcx Investor2 |



@TestCaseKey=PLX-T1001
  Scenario Outline: As a Investor, Able to access Green wallet
  Given '<Participant>' is logged in to FCX 'App'
   And in My Holdings, <Company Name> tile is pressed
   And Investor menu 'Wallets' is pressed
   And inside My Wallets, '<Wallet Name>' tile is pressed
   And inside My Wallets, 'Holdings in Wallet' tab is pressed
   Then inside Investor Holdings in Wallet tab, display details 
      | Company Name    | Total Securities   |  
      | <Company Name>  | <Total Securities> |  

 
    @WalletSmoke @DEV @TEST 
    Examples:
      | Participant  | Company Name           | Wallet Name          | Total Securities |
      | investor1    | CYPRESS-FCX Trading Co | FCX INVESTOR1        | 100              |
      | investor3    | CYPRESS-FCX Trading Co | FCX INVESTOR3JOINT1  | 300              |
      | investor2    | CYPRESS-FCX Trading Co | FCX INVESTOR2COMPANY | 200              |

