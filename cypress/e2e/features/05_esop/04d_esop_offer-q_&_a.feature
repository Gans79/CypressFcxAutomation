@PLX-2367 @setup
Feature: Q & A

  @ESOPRegression @PLX-2773 
  Scenario Outline: ESOP - Add Q&A: Verify mandatory fields (Issue User ESOP access)
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Q & A' tab is pressed
    When in 'ESOP Offer' page, 'Q & A' tab, 'Add' button is pressed
    And in 'Create Q&A' pop-up, 'Save' button is pressed
    Then in 'Create Q&A' pop-up, 'Question is required' validation error is displayed for Question
    And alert pop-up, error, 'Answer is required' is displayed

    @TestCaseKey=PLX-T294 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |


  @ESOPRegression @PLX-2773 
  Scenario Outline: ESOP - Add Q&A: Add Q&A where Offer [Status] = "Setup' (Issue User ESOP access)
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Q & A' tab is pressed
    When in 'ESOP Offer' page, 'Q & A' tab, 'Add' button is pressed
    And in 'Create Q&A' pop-up, '<Question>' is entered into Question
    And in 'Create Q&A' pop-up, '<Answer>' is entered into Answer
    And in 'Create Q&A' pop-up, 'Save' button is pressed
    Then in 'Q & A' tab, '<Question>' and '<Answer>' Q & A box is displayed

    @TestCaseKey=PLX-T293 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Question                | Answer           |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | What is the question 1? | The Answer is 1. |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | What is the question 3? | The Answer is 3. |
      #PLX-3525
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | What is the question 2? | The Answer is 2. |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | What is the question 2? | The Answer is 2. |


  @ESOPRegression @PLX-2773 
  Scenario Outline: ESOP - Add Q&A: Add Q&A with 5 linked documents where Offer [Status] = "Setup' (Issue User ESOP access)
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Q & A' tab is pressed
    When in 'ESOP Offer' page, 'Q & A' tab, 'Add' button is pressed
    And in 'Create Q&A' pop-up, '<Question>' is entered into Question
    And in 'Create Q&A' pop-up, '<Answer>' is entered into Answer
    And in 'Create Q&A' pop-up, '<Link Document 1>' is selected for Search Documents
    And in 'Create Q&A' pop-up, '<Link Document 2>' is selected for Search Documents
    And in 'Create Q&A' pop-up, '<Link Document 3>' is selected for Search Documents
    And in 'Create Q&A' pop-up, '<Link Document 4>' is selected for Search Documents
    And in 'Create Q&A' pop-up, '<Link Document 5>' is selected for Search Documents
    And in 'Create Q&A' pop-up, 'Save' button is pressed
    Then in 'Q & A' tab, '<Question>' and '<Answer>' Q & A box is displayed with linked documents
      | Linked Documents  |
      | <Link Document 1> |
      | <Link Document 2> |
      | <Link Document 3> |
      | <Link Document 4> |
      | <Link Document 5> |

    #   ## Commented out as a continuous test case.
    #   @TestCaseKey=PLX-T296 @DEV
    #   Examples:
    #     | Issuer | Company       | Plan Name                    | Offer Name                          | Question                | Answer           | Link Document 1 | Link Document 2 | Link Document 3 | Link Document 4     | Link Document 5 |
    #     | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | What is the question 2? | The Answer is 2. | General Doc 1   | General Doc 1   | Legal Doc 1     | General Doc 2 | Legal Doc 3     | Legal Doc 5 |

    # @PLX-2773 @Smoke @Regression
    # Scenario Outline: ESOP - Add Q&A: Add Q&A with 2 linked documents where Offer [Status] = "Setup' (Issue User ESOP access) - Verify in Document & Media
    #   Given '<Issuer>' is logged in to FCX 'App'
    #   And in Company View, <Company> tile is pressed
    #   And company menu 'ESOP' is pressed
    #   And in ESOP, <Plan Name> tile is pressed
    #   And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Q & A' tab is pressed
    When in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    Then in ESOP offer, 'General Documents' section, displays
      | Document Name     | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Link Document 1> | check         |           |          | [Today]       |
    And in ESOP offer, 'Legal Documents' section, displays
      | Document Name     | Signature Required | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Link Document 2> | check              | check         | check     |          | [Today]       |

    @TestCaseKey=PLX-T296 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Question                | Answer           | Link Document 1 | Link Document 2 | Link Document 3     | Link Document 4 | Link Document 5 |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | What is the question 2? | The Answer is 2. | General Doc 1   | Legal Doc 1     | General Doc 2       | Legal Doc 3     | Legal Doc 5     |

  @ESOPRegression @PLX-2773 
  Scenario Outline: ESOP - Edit Q&A: Edit a Q&A where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Q & A' tab is pressed
    When in 'ESOP Offer' page, 'Q & A' tab, 'Edit' action for '<Question>' question is selected
    And in 'Update Q&A' pop-up, '<Question> updated' is entered into Question
    And in 'Update Q&A' pop-up, '<Answer> edited' is entered into Answer
    And in 'Update Q&A' pop-up, '<Link Document 1>' is selected for Search Documents
    And in 'Update Q&A' pop-up, 'Save' button is pressed
    And alert pop-up, success, 'Q & A Updated' is displayed
    # Then in 'Q & A' tab, '<Question> updated' and '<Answer> edited' Q & A box is displayed
    Then in 'Q & A' tab, '<Question> updated' and '<Answer> edited' Q & A box is displayed with linked documents
      | Linked Documents  |
      | <Link Document 1> |

    @TestCaseKey=PLX-T303 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Question                | Answer           | Link Document 1     |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | What is the question 3? | The Answer is 3. | General Doc 3       |
      #PLX-3525
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | What is the question 2? | The Answer is 2. | Legal Doc 5         |
