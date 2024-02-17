Feature: Create new Company
  As PX Admin, I want to create new company

  @TestCaseKey=PLX-T456
  Scenario Outline: Create new Company without directors [status pending]
    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And in FCX Admin Dashboard screen, 'Create Company' is pressed
    And in Create Company screen pop-up, '<Company Name>' is entered into Company Name
    And in Create Company screen pop-up, '<ACN>' is entered into ACN
    And in Create Company screen pop-up, '<Phone Number>' is entered into Phone Number
    And in Create Company screen pop-up, '<Address Line 1>' is entered into Address Line 1
    And in Create Company screen pop-up, '<Suburb>' is entered into Suburb
    And in Create Company screen pop-up, '<Postcode>' is entered into Postcode
    And in Create Company screen pop-up, '<State>' is entered into State
    And in Create Company screen pop-up, '<Description>' is entered into Description
    And in Create Company screen pop-up, 'Add next to Security Classes' is pressed 
    And in Add Security Class screen pop-up, '<Security Type>' , '<Identifier>' and '<Description>' entered and save is pressed
    And in Create Company screen pop-up, upload company logo as '<Logo>'
    When in Create Company screen pop-up, 'Save' is pressed
    And in FCX Admin Dashboard screen, '<Company Name>' is entered into search
    Then in FCX Admin Dashboard screen table, display details
       | Name           | Owner            | Date Created | Status  |
       | <Company Name> | admin@fcx.com.au | [Today]      | Pending |

    @CompanySmoke @DEV 
    Examples:
      | Admin   | Company Name            | ACN   | Phone Number | Address Line 1   | Suburb       | Postcode | State            | Country   | Description         | Logo                    | Security Type | Identifier |
      | PXAdmin | CYPRESS-FCX Trading Co  | 12345 | 0411 111 002 | Level 8 Mount St | North Sydney | 2060     | New South Wales  | Australia | FCX Trading Company | FCX_Trading_Co_logo.png | SEC1          | ORD1       |

    @CompanySmoke @TEST 
    Examples:
      | Admin   | Company Name            | ACN   | Phone Number | Address Line 1   | Suburb       | Postcode | State            | Country   | Description         | Logo                    | Security Type | Identifier |
      | PXAdmin | CYPRESS-FCX Trading Co | 12345 | 0411 111 002 | Level 8 Mount St | North Sydney  | 2060     | New South Wales  | Australia | FCX Trading Company | FCX_Trading_Co_logo.png | SEC1          | ORD1       |

@TestCaseKey=PLX-T949
  Scenario Outline: Create new Company with directors [status pending]
    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And in FCX Admin Dashboard screen, 'Create Company' is pressed
    And in Create Company screen pop-up, '<Company Name>' is entered into Company Name
    And in Create Company screen pop-up, '<ACN>' is entered into ACN
    And in Create Company screen pop-up, '<Phone Number>' is entered into Phone Number
    And in Create Company screen pop-up, '<Address Line 1>' is entered into Address Line 1
    And in Create Company screen pop-up, '<Suburb>' is entered into Suburb
    And in Create Company screen pop-up, '<Postcode>' is entered into Postcode
    And in Create Company screen pop-up, '<State>' is entered into State
    And in Create Company screen pop-up, '<Description>' is entered into Description
    And in Create Company screen pop-up, 'Add next to Company Directors' is pressed 
    And in Add Company Directors screen pop-up, '<Director Name>' , '<Director Role>' and '<Signature>' entered and save is pressed
    And in Create Company screen pop-up, Certificate signatory checkbox is '<Certificate signatory>'
    And in Create Company screen pop-up, Enable online shares certificate checkbox is '<Enable online shares>'
    And in Create Company screen pop-up, 'Add next to Security Classes' is pressed 
    And in Add Security Class screen pop-up, '<Security Type>' , '<Identifier>' and '<Description>' entered and save is pressed
    And in Create Company screen pop-up, upload company logo as '<Logo>'
    When in Create Company screen pop-up, 'Save' is pressed
    And in FCX Admin Dashboard screen, '<Company Name>' is entered into search
    Then in FCX Admin Dashboard screen table, display details
       | Name           | Owner            | Date Created | Status  |
       | <Company Name> | admin@fcx.com.au | [Today]      | Pending |

    @CompanySmoke @DEV 
    Examples:
      | Admin   | Company Name             | ACN   | Phone Number | Address Line 1   | Suburb       | Postcode | State            | Country   | Description         | Logo                    | Director Name | Director Role | Signature                   | Security Type | Identifier | Enable online shares | Certificate signatory |
      | PXAdmin | CYPRESS-FCX Trading Co2  | 12345 | 0411111002  | Level 8 Mount St | North Sydney | 2060     | New South Wales  | Australia | FCX Trading Company | FCX_Trading_Co_logo.png | Fcx director1 | Director      | FCX_Trading_Co_signature.jpg | SEC1          | ORD1       | checked              | checked               |

    @CompanySmoke @TEST 
    Examples:
      | Admin   | Company Name             | ACN   | Phone Number | Address Line 1   | Suburb       | Postcode | State            | Country   | Description         | Logo                    | Director Name | Director Role | Signature                   | Security Type | Identifier | Enable online shares | Certificate signatory |  
      | PXAdmin | CYPRESS-FCX Trading Co2  | 12345 | 0411111002  | Level 8 Mount St | North Sydney | 2060     | New South Wales  | Australia | FCX Trading Company | FCX_Trading_Co_logo.png | Fcx director1 | Director      | FCX_Trading_Co_signature.jpg | SEC1          | ORD1       | checked              | checked               |



@TestCaseKey=PLX-T911
  Scenario Outline: Upload Investors [status pending]
    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Dashboard' is pressed
    And in FCX Admin Dashboard screen, '<Company Name>' is entered into search
    And in FCX Admin Dashboard screen, '3 Dots' is pressed
    And in FCX Admin Dashboard screen, 'Upload Investors' is pressed
    When in Upload Investor screen pop-up, upload investors data as '<Investors>'
    Then in Upload Investor screen pop-up, summary table display details
       | Security ID  | Total Units  | Total Investors | 
       | ORD1         | 600          | 3               | 
    And in Upload Investor screen pop-up, investor summary table display details
       | Shareholder Type | Company Name           | Shareholder First Name | Shareholder Middle Name  | Shareholder Last Name |
       | COMPANY          | FCX INVESTOR2COMPANY   |                        |                          |                       |
       | INDIVIDUAL       |                        | FCX                    | ALPHA                    | INVESTOR1             |
       | JOINT            |                        | FCX                    | GAMA                     | INVESTOR3JOINT1       |
    And in Upload Investor screen pop-up, 'Save' is pressed
    And in FCX Admin Dashboard screen, '<Company Name>' is entered into search
    Then in FCX Admin Dashboard screen table, display details
       | Name           | Owner            | Date Created | Status  |
       | <Company Name> | admin@fcx.com.au | [Today]      | Pending |


    @CompanySmoke @DEV 
    Examples:
      | Admin   | Company Name           | ACN   | Phone Number | Address Line 1   | Suburb       | Postcode | State            | Country   | Investors                             | 
      | PXAdmin | CYPRESS-FCX Trading Co | 12345 | 0411 111 002 | Level 8 Mount St | North Sydney | 2060     | New South Wales  | Australia | FCX_Trading_Co_Investor_data_dev.xlsx | 

    @CompanySmoke @TEST 
    Examples:
      | Admin   | Company Name           | ACN   | Phone Number | Address Line 1   | Suburb       | Postcode | State            | Country   | Investors                              | 
      | PXAdmin | CYPRESS-FCX Trading Co | 12345 | 0411 111 002 | Level 8 Mount St | North Sydney | 2060     | New South Wales  | Australia | FCX_Trading_Co_Investor_data_test.xlsx | 


@TestCaseKey=PLX-T912
  Scenario Outline: Review and Approve investors [status active]
    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Dashboard' is pressed
    And in FCX Admin Dashboard screen, '<Company Name>' is entered into search
    And in FCX Admin Dashboard screen, '3 Dots' is pressed
    And in FCX Admin Dashboard screen, 'Review and approve data' is pressed
    Then in Review Investor screen pop-up, summary table display details
       | Security ID  | Total Units  | Total Investors | 
       | ORD1         | 600          | 3               | 
    And in Review Investor screen pop-up, investor summary table display details
       | Shareholder Type | Company Name           | Shareholder First Name | Shareholder Middle Name  | Shareholder Last Name |
       | COMPANY          | FCX INVESTOR2COMPANY   |                        |                          |                       |
       | INDIVIDUAL       |                        | FCX                    | ALPHA                    | INVESTOR1             |
       | PARTNERSHIP      |                        | FCX                    | GAMA                     | INVESTOR3JOINT1       |
    And in Review Investor screen pop-up, 'Approve' is pressed
    And in FCX Admin Dashboard screen, '<Company Name>' is entered into search
    Then in FCX Admin Dashboard screen table, display details
       | Name           | Owner            | Date Created | Status  |
       | <Company Name> | admin@fcx.com.au | [Today]      | Active |

    @CompanySmoke @DEV 
    Examples:
      | Admin   | Company Name           | ACN   | Phone Number | Address Line 1   | Suburb       | Postcode | State            | Country   | Investors                         | 
      | PXAdmin | CYPRESS-FCX Trading Co | 12345 | 0411 111 002 | Level 8 Mount St | North Sydney | 2060     | New South Wales  | Australia | FCX_Trading_Co_Investor_data.xlsx | 

    @CompanySmoke @TEST 
    Examples:
      | Admin   | Company Name           | ACN   | Phone Number | Address Line 1   | Suburb       | Postcode | State            | Country   | Investors                         | 
      | PXAdmin | CYPRESS-FCX Trading Co | 12345 | 0411 111 002 | Level 8 Mount St | North Sydney | 2060     | New South Wales  | Australia | FCX_Trading_Co_Investor_data.xlsx | 

@TestCaseKey=PLX-T913
  Scenario Outline: Invite company owner 
   Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'Dashboard' is pressed
    And in FCX Admin Dashboard screen, '<Company Name>' is entered into search
    And in FCX Admin Dashboard screen, '3 Dots' is pressed
    And in FCX Admin Dashboard screen, 'Invite owner' is pressed
    And in Invite owner screen pop-up, '<Owner Name>' , '<Owner Email>' entered and send invite is pressed for '<Company Name>'
    Then in FCX Admin Dashboard screen table, display details
       | Name           | Owner            | Date Created | Status  |
       | <Company Name> | admin@fcx.com.au | [Today]      | Active  |

    @CompanySmoke @DEV 
    Examples:
      | Admin   | Company Name          | Owner Name | Owner Email | 
      | PXAdmin | CYPRESS-FCX Trading Co| Fcx Owner  | fcx.dev.tester+owner@finclear.com.au |

    @CompanySmoke @TEST 
    Examples:
      | Admin   | Company Name           | Owner Name| Owner Email | 
      | PXAdmin | CYPRESS-FCX Trading Co | Fcx Owner | fcx.test.tester+owner@finclear.com.au |

@TestCaseKey=PLX-T976
  Scenario Outline: Company Owner accepts email invite
    Given Company owner, click on view your invite from email for <Company Name>
    And '<Participant>' clicks login in to FCX 'App'
    When inside Company owner invitations, Accept the invite
    Then inside Company owner invitations, Company invitation is not displayed

    @CompanySmoke @DEV 
    Examples:
      | Participant   | Company Name           | 
      | company_owner | CYPRESS-FCX Trading Co | 

    @CompanySmoke @TEST 
    Examples:
      | Participant   | Company Name           | 
      | company_owner | CYPRESS-FCX Trading Co | 
