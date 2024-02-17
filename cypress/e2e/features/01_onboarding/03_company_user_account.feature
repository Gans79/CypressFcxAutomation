Feature: Onboarding
  I want to onboard new user(s)

  @PLX-2950 @PLX-3118 @PLX-T2 @DEV
  Scenario Outline: User registration - check does not send token details
    Given a user browsers to FCX app 
    ### ie.[https://login.platformx-<env>.fincleartech.io/]
    And 'Log In' title page is displayed
    When 'Create New Account' link is pressed
    Then 'Register' title page is displayed
    And in Registration, details are entered
      | First Name       | FCX                                   |
      | Last Name        | Tester <DateTime Stamp>               |
      | Email            | fcx.tester+<DateTime Stamp>@gmail.com |
      | Password         | <Password>                            |
      | Confirm Password | <Password>                            |
    And 'I agree to the Terms of Use, and consent to my personal information being handled in accordance with the Collection Notice.' checkbox is checked
    And 'Register' button is pressed
    Then 'Check your email' text is displayed
  # And in browser Developer Console - Network tab, userRegistration Response '{"result":{"token":""}}' ie. DOES NOT return token details

  Example:
      | Password     | DateTime Stamp |
      | Password@123 | Now()          |

  @PLX-2951 @PLX-3119 @PLX-T3
  Scenario: Resend User Registration
    Given a user browsers to FCX Registration [https://app.platformx-<env>.fincleartech.io/login/signup]
    And in Registration, details are entered
      | First Name       | FCX                                   |
      | Last Name        | Tester <DateTime Stamp>               |
      | Email            | fcx.tester+<DateTime Stamp>@gmail.com |
      | Password         | <Password>                            |
      | Confirm Password | <Password>                            |
    And 'I agree to the Terms of Use, and consent to my personal information being handled in accordance with the Collection Notice.' checkbox is checked
    And 'Register' button is pressed
    And 'Hi there, looks like you've already registered with this email. Would you like to resend the verification email?' text is displayed
    When 'Resend Verification Email' button is pressed
    Then 'Check your email' text is displayed

  Example:
      | Password     | DateTime Stamp |
      | Password@123 | Now()          |


  Scenario Outline: AA user IWT verify email ST I can login to use the FCX App

    Given <User> checks email and views details
      | Subject | Please verify your email |
      | From    | admin@fcx.com.au         |
      | To      | <User.Email>             |
    When in Email, 'Verify Email' button is pressed
    Then is re-directed to login to FCX App
    # Only occurs if you're already logged in,
    And 'Welcome to FCX' title is displayed

  Example:
      | User     | User.Email                            |
      | new user | fcx.tester+<DateTime Stamp>@gmail.com |

  Scenario Outline: AA user IWT access the FCX App
    Given a user browsers to FCX app
    When re-directed to FCX login
    And <Company> <User> enters login details
    Then user is on the FCX dashboard

    @DEV
    Examples:
      | Company | User  |
      | Alpha   | owner |

 Scenario: KYC/AML Verification - Australian Passport

        Given <Investor> is logged in to FCX app
        And in My Profile, Edit Details pressed
        And in Edit My Profile Details dialog, edit details
            | First Name  | <First Name> |
            | Middle Name | TwoPass      |
            | Last Name   | <Last Name   |
        And in Edit My Profile Details dialog, Save pressed
        And in MY ACCOUNT, Verification
        And in Verification, 'Begin Verification' for KYC/AML Verification
        And in Verification Agreement, check I agree
        And 'Next' is pressed
        And in Personal Information, ADDRESS section details entered for <Investor>
            | Date of Birth | 21/01/1980         |
            | Flat Number   | 8                  |
            | Street Number | 5                  |
            | Street Name   | Mill               |
            | Street Type   | Street             |
            | City / Suburb | Perth              |
            | State         | Western Austratlia |
            | Postcode      | 6000               |
            | Country       | Australia          |
        And 'Next' is pressed
        And in Select an Identification, 'Australian Passport' is selected
        And in Fill in your identification details, fill in details
            | Passport Number | A1111111     |
            | First Name      | <First Name> |
            | Middle Name     | TwoPass      |
            | Last Name       | <Last Name   |
        And in Fill in your identification details, check 'I agree that above information provided is accurate'
        And 'Next' is pressed
        Then in MY ACCOUNT, Verification
        And KYC/AML Verification is Verified

        Examples:
            | Investor       | First Name | Last Name |
            | Company1:owner | Ian        | Owner     |


