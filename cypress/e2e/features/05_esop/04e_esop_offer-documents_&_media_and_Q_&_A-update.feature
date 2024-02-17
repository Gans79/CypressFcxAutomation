@PLX-2367 @setup
Feature: Update “Documents & Media” and “Q&A” Tabs-  by issuer

  @ESOPRegression @PLX-3166 
  Scenario Outline: Open ESOP Offer to Participants (Negative Flow - “Documents & Media” tab "No" published legal document)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, current status is Setup
    And in ESOP offer, 'Documents & Media' tab is pressed
    When in ESOP offer page, hover on status 'Setup'
    And in 'Setup' status pop-up, 'Offer Details' is ticked
    And in 'Setup' status pop-up, 'Legal Document(s)' without description is blank
    Then in 'Setup' status pop-up, 'Progress to Open' button is disabled

    @TestCaseKey=PLX-T392 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name              | Offer Name                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Closed Manual |

  @ESOPRegression @PLX-2775
  Scenario Outline: ESOP - Update Doc: Cancel out of editing a document where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Edit Document' action for row detail is selected
      | Document Name   | Linked to Q&A | Published | Archived | Date Uploaded   |
      | <Document Name> | checked       |           |          | <Date Uploaded> |
    And in 'Edit Document' pop-up, 'Close' button is pressed
    # BUG:3279, missing Cancel button, fixed in TASK:PLX-2548
    Then in ESOP offer, 'General Documents' section, displays
      | Document Name   | Linked to Q&A | Published | Archived | Date Uploaded   |
      | <Document Name> | checked       |           |          | <Date Uploaded> |

    @TestCaseKey=PLX-T367 @DEV @TEST 
    Examples: Not running till fixed.
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Name | Date Uploaded |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General Doc 1 | [Today]       |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc: Edit General document where Offer [Status] = "Setup' and Document [Status] = 'Unpublished' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Edit Document' action for row detail is selected
      | Document Name   | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Document Name> | check         |           |          | [Today]       |
    And in 'Edit Document' pop-up, '<Document Name> updated' is entered into Document Name
    And in 'Edit Document' pop-up, 'Update' button is pressed
    And alert pop-up, success, 'Document updated' is displayed
    Then in ESOP offer, 'General Documents' section, displays
      | Document Name           | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Document Name> updated | check         |           |          | [Today]       |

    @TestCaseKey=PLX-T300 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Name |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General Doc 1 |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc: Edit Legal document where Offer [Status] = "Setup' and Document [Status] = 'Unpublished' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Legal Documents' table, 'Edit Document' action for row detail is selected
      | Document Name   | Signature Required | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Document Name> |                    |               |           |          | [Today]       |
    And in 'Edit Document' pop-up, '<Document Name> updated' is entered into Document Name
    And in 'Edit Document' pop-up, 'The Employee will need to sign this document as part of agreeing to the offer.' checkbox is <Legal Document Agreement>
    And in 'Edit Document' pop-up, 'Update' button is pressed
    And alert pop-up, success, 'Document updated' is displayed
    Then in ESOP offer, 'Legal Documents' section, displays
      | Document Name           | Signature Required | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Document Name> updated | checked            |               |           |          | [Today]       |

    @TestCaseKey=PLX-T301 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Name | Legal Document Agreement |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Legal Doc 2   | checked                  |

  @PLX-2775 
  Scenario Outline: ESOP - Update URL: Edit an URL link where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Media' table, 'Update Video' action for row detail is selected
      | Title         | URL Link    | Date Uploaded |
      | <Video Title> | <Video URL> | [Today]       |
    And in 'Update Video Link' pop-up, '<Video Title> updated' is entered into Title
    And in 'Update Video Link' pop-up, '<New URL>' is entered into URL
    And in 'Update Video Link' pop-up, 'Update' button is pressed
    And alert pop-up, success, 'Video updated' is displayed
    Then 'Media' table, displays details
      | Title         | URL Link  | Date Uploaded |
      | <Video Title> | <New URL> | [Today]       |
    When '<New URL>' video is pressed
    # Then '<New URL Title>' YouTube video title is displayed  #TODO: check video is running

    @TestCaseKey=PLX-T302 @DEV @run
    Examples: #BUG: PLX-3428
      | Issuer | Company       | Plan Name                    | Offer Name                          | Video Title | Video URL                                                | New URL                      | New URL Title        |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | ESOP        | https://www.youtube.com/channel/UCY9c2Rjjwa8zWG4zcmIS8rQ | https://youtu.be/iPJHfIB7HO4 | FCX Cap Raising Demo |

  @PLX-2775
  Scenario Outline: ESOP - Delete URL: Cancel deleting an URL link where Offer [Status] = "Setup' (Issue User ESOP access) (cloned)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Media' table, 'Delete Video' action for row detail is selected
      | Title         | URL Link    | Date Uploaded |
      | <Video Title> | <Video URL> | [Today]       |
    And in 'Delete Video' pop-up, 'Cancel' button is pressed
    Then 'Media' table, displays details
      | Title         | URL Link    | Date Uploaded |
      | <Video Title> | <Video URL> | [Today]       |

    @TestCaseKey=PLX-T358 @DEV @run
    Examples: #BUG: PLX-3428
      | Issuer | Company       | Plan Name            | Offer Name                                  | Video Title  | Video URL                    |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | ESOP updated | https://youtu.be/iPJHfIB7HO4 |

  @PLX-2775
  Scenario Outline: ESOP - Delete URL: Delete an URL link where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Media' table, 'Delete Video' action for row detail is selected
      | Title         | URL Link    | Date Uploaded |
      | <Video Title> | <Video URL> | [Today]       |
    And in 'Delete Video' pop-up, 'Delete' button is pressed
    And alert pop-up, success, 'Video Deleted' is displayed
    Then in 'Documents' tab, '<Video URL>' URL is not displayed

    @TestCaseKey=PLX-T355 @DEV @run
    Examples: #BUG: PLX-3428
      | Issuer | Company       | Plan Name                    | Offer Name                          | Video Title  | Video URL                    |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | ESOP updated | https://youtu.be/iPJHfIB7HO4 |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - 'Update' Doc: Cancel out of publishing a document where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Publish Document' action for row detail is selected
      | Document Name   | Linked to Q&A   | Published | Archived | Date Uploaded   |
      | <Link Document> | <Linked to Q&A> |           |          | <Date Uploaded> |
    And in 'Publish Document' pop-up, 'Cancel' button is pressed
    And in ESOP offer, 'General Documents' section, displays
      | Document Name   | Linked to Q&A   | Published | Archived | Date Uploaded   |
      | <Link Document> | <Linked to Q&A> |           |          | <Date Uploaded> |

    @TestCaseKey=PLX-T321 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Linked to Q&A | Link Document         | Date Uploaded |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check         | General Doc 1 updated | [Today]       |


  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc: Publish General document where Offer [Status] = "Setup' and Document [Status] = 'Unpublished' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Publish Document' action for row detail is selected
      | Document Name   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Linked to Q&A> |           |          | [Today]       |
    And in 'Publish Document' pop-up, 'Publish' button is pressed
    And alert pop-up, success, 'Document published' is displayed
    And in ESOP offer, 'General Documents' section, displays
      | Document Name   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Linked to Q&A> | check     |          | [Today]       |

    @TestCaseKey=PLX-T304 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Linked to Q&A | Link Document         |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check         | General Doc 1 updated |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |               | General Doc 4         |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check         | General Doc 2         |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc: Publish a Legal document where Offer [Status] = "Setup' Document [Status] = 'Unpublished' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Legal Documents' table, 'Publish Document' action for row detail is selected
      | Document Name   | Signature Required   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Signature Required> | <Linked to Q&A> |           |          | [Today]       |
    And in 'Publish Document' pop-up, 'Publish' button is pressed
    And alert pop-up, success, 'Document published' is displayed
    And in ESOP offer, 'Legal Documents' section, displays
      | Document Name   | Signature Required   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Signature Required> | <Linked to Q&A> | check     |          | [Today]       |

    @TestCaseKey=PLX-T305 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Link Document       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check              |               | Legal Doc 2 updated |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |                    | check         | Legal Doc 3         |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc: Unpublish General document where Offer [Status] = "Setup' and Document [Status] = Published (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Unpublish Document' action for row detail is selected
      | Document Name   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Linked to Q&A> | check     |          | [Today]       |
    And in 'Unpublish Document' pop-up, 'Unpublish' button is pressed
    And alert pop-up, success, 'Document unpublished' is displayed
    And in ESOP offer, 'General Documents' section, displays
      | Document Name   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Linked to Q&A> |           |          | [Today]       |

    @TestCaseKey=PLX-T306 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Linked to Q&A | Link Document         |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check         | General Doc 1 updated |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc: Cancel out of unpublishing a document where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Legal Documents' table, 'Unpublish Document' action for row detail is selected
      | Document Name   | Signature Required   | Linked to Q&A   | Published | Archived | Date Uploaded   |
      | <Link Document> | <Signature Required> | <Linked to Q&A> | check     |          | <Date Uploaded> |
    And in 'Unpublish Document' pop-up, 'Cancel' button is pressed
    And in ESOP offer, 'Legal Documents' section, displays
      | Document Name   | Signature Required   | Linked to Q&A   | Published | Archived | Date Uploaded   |
      | <Link Document> | <Signature Required> | <Linked to Q&A> | check     |          | <Date Uploaded> |

    @TestCaseKey=PLX-T322 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Link Document       | Date Uploaded |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check              |               | Legal Doc 2 updated | [Today]       |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc:  Unpublish Legal document where Offer [Status] = "Setup' and Document [Status] = Published (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Legal Documents' table, 'Unpublish Document' action for row detail is selected
      | Document Name   | Signature Required   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Signature Required> | <Linked to Q&A> | check     |          | [Today]       |
    And in 'Unpublish Document' pop-up, 'Unpublish' button is pressed
    And alert pop-up, success, 'Document unpublished' is displayed
    And in ESOP offer, 'Legal Documents' section, displays
      | Document Name   | Signature Required   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Signature Required> | <Linked to Q&A> |           |          | [Today]       |

    @TestCaseKey=PLX-T307 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Link Document       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check              |               | Legal Doc 2 updated |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc:  Archive General document where Offer [Status] = "Setup' and Document [Status] = Published (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Archive Document' action for row detail is selected
      | Document Name   | Linked to Q&A   | Published   | Archived | Date Uploaded   |
      | <Link Document> | <Linked to Q&A> | <Published> |          | <Date Uploaded> |
    And in 'Unpublish Document' pop-up, 'Cancel' button is pressed
    And in ESOP offer, 'General Documents' section, displays
      | Document Name   | Linked to Q&A   | Published   | Archived | Date Uploaded   |
      | <Link Document> | <Linked to Q&A> | <Published> |          | <Date Uploaded> |

    @TestCaseKey=PLX-T323 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Linked to Q&A | Published | Link Document       | Date Uploaded |
      # | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |               | check     | General Doc 1 | [Today]       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check         | check     | General Doc 2       | [Today]       |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc:  Archive General document where Offer [Status] = "Setup' and Document [Status] = Published (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Archive Document' action for row detail is selected
      | Document Name   | Linked to Q&A   | Published   | Archived | Date Uploaded |
      | <Link Document> | <Linked to Q&A> | <Published> |          | [Today]       |
    And in 'Unpublish Document' pop-up, 'Archive' button is pressed
    And alert pop-up, success, 'Document archived' is displayed
    And in ESOP offer, 'General Documents' section, displays
      | Document Name   | Linked to Q&A | Published   | Archived | Date Uploaded |
      | <Link Document> |               | <Published> | check    | [Today]       |

    @TestCaseKey=PLX-T308 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                               | Linked to Q&A | Published | Link Document       |
      # | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |               | check     | General Doc 1 |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check         | check     | General Doc 2 |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Update Doc: Archive Legal document where Offer [Status] = "Setup' and Document [Status] = Published (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Legal Documents' table, 'Archive Document' action for row detail is selected
      | Document Name   | Signature Required   | Linked to Q&A   | Published | Archived | Date Uploaded |
      | <Link Document> | <Signature Required> | <Linked to Q&A> | check     |          | [Today]       |
    And in 'Unpublish Document' pop-up, 'Archive' button is pressed
    And alert pop-up, success, 'Document archived' is displayed
    And in ESOP offer, 'Legal Documents' section, displays
      | Document Name   | Signature Required   | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Link Document> | <Signature Required> |               | check     | check    | [Today]       |
    @TestCaseKey=PLX-T309 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Link Document |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check              |               | Legal Doc 1   |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check              |               | Legal Doc 4   |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Delete Doc: Delete General document where Offer [Status] = "Setup' and Document [Status] = 'Unpublished' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Delete Document' action for row detail is selected
      | Document Name   | Linked to Q&A   | Published   | Archived   | Date Uploaded   |
      | <Link Document> | <Linked to Q&A> | <Published> | <Archived> | <Date Uploaded> |
    And in 'Unpublish Document' pop-up, 'Cancel' button is pressed
    And in ESOP offer, 'General Documents' section, displays
      | Document Name   | Linked to Q&A   | Published   | Archived   | Date Uploaded   |
      | <Link Document> | <Linked to Q&A> | <Published> | <Archived> | <Date Uploaded> |

    @TestCaseKey=PLX-T320 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  | Linked to Q&A | Published | Archived | Link Document         | Date Uploaded |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check         |           |          | General Doc 1 updated | [Today]       |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Delete Doc: Delete General document where Offer [Status] = "Setup' and Document [Status] = 'Unpublished' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'General Documents' table, 'Delete Document' action for row detail is selected
      | Document Name   | Linked to Q&A   | Published   | Archived   | Date Uploaded |
      | <Link Document> | <Linked to Q&A> | <Published> | <Archived> | [Today]       |
    And in 'Unpublish Document' pop-up, 'Delete' button is pressed
    # And alert pop-up, success, 'Document deleted' is displayed
    And alert pop-up, success, 'Document deleted' is closed
    Then 'General Documents' table, does not display row with Document Name
      | Document Name   | Linked to Q&A   | Published   | Archived   | Date Uploaded |
      | <Link Document> | <Linked to Q&A> | <Published> | <Archived> | [Today]       |

    @TestCaseKey=PLX-T312 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Linked to Q&A | Published | Archived | Link Document         |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check         |           |          | General Doc 1 updated |
    @TestCaseKey=PLX-T314 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Linked to Q&A | Published | Archived | Link Document       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |               | check     |          | General Doc 4 |
    @TestCaseKey=PLX-T316 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Linked to Q&A | Published | Archived | Link Document       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |               | check     | check    | General Doc 2 |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Delete Doc:  Delete Legal document where Offer [Status] = "Setup' and Document [Status] = 'Unpublished' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'Legal Documents' table, 'Delete Document' action for row detail is selected
      | Document Name   | Signature Required   | Linked to Q&A   | Published   | Archived   | Date Uploaded |
      | <Link Document> | <Signature Required> | <Linked to Q&A> | <Published> | <Archived> | [Today]       |
    And in 'Unpublish Document' pop-up, 'Delete' button is pressed
    # And alert pop-up, success, 'Document deleted' is displayed
    And alert pop-up, success, 'Document deleted' is closed
    And 'Legal Documents' table, does not display row with Document Name
      | Document Name   | Signature Required   | Linked to Q&A   | Published   | Archived   | Date Uploaded |
      | <Link Document> | <Signature Required> | <Linked to Q&A> | <Published> | <Archived> | [Today]       |

    @TestCaseKey=PLX-T313 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Published | Archived | Link Document       |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check              |               |           |          | Legal Doc 2 updated |
    @TestCaseKey=PLX-T315 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Published | Archived | Link Document |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |                    | check         | check     |          | Legal Doc 3   |
    @TestCaseKey=PLX-T317 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Signature Required | Linked to Q&A | Published | Archived | Link Document |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | check              |               | check     | check    | Legal Doc 4   |

  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Delete Q&A: Cancel deleting a Q&A where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Q & A' tab is pressed
    When in 'ESOP Offer' page, 'Q & A' tab, 'Delete' action for '<Question>' question is selected
    And in 'Delete Q & A' pop-up, 'Cancel' button is pressed
    Then in 'Q & A' tab, '<Question>' and '<Answer>' Q & A box is displayed

    @TestCaseKey=PLX-T319 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Question                | Answer           |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | What is the question 1? | The Answer is 1. |


  @ESOPRegression @PLX-2775 
  Scenario Outline: ESOP - Delete Q&A: Delete a Q&A where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Q & A' tab is pressed
    When in 'ESOP Offer' page, 'Q & A' tab, 'Delete' action for '<Question>' question is selected
    And in 'Delete Q & A' pop-up, 'Delete' button is pressed
    And alert pop-up, success, 'Q & A Deleted' is closed
    Then in 'Q & A' tab, '<Question>' Q & A box is not displayed

    @TestCaseKey=PLX-T318 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Question                | Answer           |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | What is the question 1? | The Answer is 1. |
