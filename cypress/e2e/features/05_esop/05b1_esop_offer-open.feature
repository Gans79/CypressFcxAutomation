@PLX-2713
Feature: Open to participants - (Participants Tab)

  @PLX-3166 
  Scenario Outline: As an Issuer user with ESOP role, I want to open ESOP offer to participant so that they can view and action their offers
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, current status is Setup
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    ### Legal document must not be Archived
    And in ESOP offer, 'Legal Documents' section, displays
      | Document Name    | Signature Required   | Linked to Q&A   | Published   | Archived   | Date Uploaded   |
      | <Legal Document> | <Signature Required> | <Linked to Q&A> | <Published> | <Archived> | <Date Uploaded> |
    ### ALL participants must have No. of Securities offered
    And in ESOP offer page, hover on status 'Setup'
    And in 'Setup' status pop-up, 'Offer Details' is ticked
    And in 'Setup' status pop-up, 'Participant Offers' with 'All Participants must have a number of securities on offer' description is ticked
    And in 'Setup' status pop-up, 'Legal Document(s)' without description is ticked
    When in 'Setup' status pop-up, 'Progress to Open' button is pressed
    And alert pop-up, success, 'Transition to Open successful.' is displayed
    Then in ESOP offer, current status is Open

    @ESOPSmoke @TestCaseKey=PLX-T389 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Published | Archived | Date Uploaded | Legal Document |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | check              |               | check     |          | [Today]       | Legal Doc 5    |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | check              |               | check     |          | [Today]       | Legal Doc 5    |
 
    @ESOPRegression @TestCaseKey=PLX-T389 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Published | Archived | Date Uploaded | Legal Document |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual         | check              | checked       | checked   |          | [Today]       | Legal Doc 5    |
      #PLX-3525
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | check              | checked       | checked   |          | [Today]       | Legal Doc 5    |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | check              | checked       | checked   |          | [Today]       | Legal Doc 5    |