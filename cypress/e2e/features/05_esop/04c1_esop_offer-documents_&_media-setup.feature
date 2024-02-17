@PLX-2367 @setup
Feature: Details/Documents/Media

  @ESOPRegression @PLX-2773 
  Scenario Outline: ESOP - Add Doc: Verify mandatory fields (Issue User ESOP access)
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'ESOP Offer' page, 'Documents & Media' tab, 'Upload' button is pressed
    And in 'Upload New Document' pop-up, 'Upload' validation is pressed
    Then in 'Upload New Document' pop-up, 'Document Name is required' validation error is displayed for Document Name
    And alert pop-up, error, 'Please Upload a File' is displayed

    @TestCaseKey=PLX-T282 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |

  @ESOPRegression @PLX-2773
  Scenario Outline: ESOP - Add URL: Verify mandatory fields (Issue User ESOP access)
    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'ESOP Offer' page, 'Documents & Media' tab, 'Add' button is pressed
    And in 'Add Video Link' pop-up, 'Add' button is pressed
    Then in 'Add Video Link' pop-up, 'Title is required' validation error is displayed for Title
    And in 'Add Video Link' pop-up, 'URL is required' validation error is displayed for URL

    @TestCaseKey=PLX-T290 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated |
  # | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3 | CYPRESS-ESOP Offer 1 Auto |

  @ESOPRegression @PLX-2773 
  Scenario Outline: Setup Documents - General

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    And in 'ESOP Offer' page, 'Documents & Media' tab, 'Upload' button is pressed
    When in 'Upload New Document' pop-up, '<Document Name>' is entered into Document Name
    And in 'Upload New Document' pop-up, <Document Type> radio is selected for 'Document Type'
    And in 'Upload New Document' pop-up, upload '<Filename>' file to 'UPLOAD DOCUMENT (PDF ONLY) *'
    And in 'Upload New Document' pop-up, '<Filename>' file is uploaded
    And in 'Upload New Document' pop-up, 'Upload' button is pressed
    Then in ESOP offer, 'General Documents' section, displays
      | Document Name   | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Document Name> |               |           |          | [Today]       |

    @TestCaseKey=PLX-T283 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Name | Document Type | Filename             |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General Doc 1 | General       | general_document.pdf |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General Doc 2 | General       | general_document.pdf |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General Doc 3 | General       | general_document.pdf |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General Doc 4 | General       | general_document.pdf |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General Doc 5 | General       | general_document.pdf |


  @PLX-2773  
  Scenario Outline: Setup Documents - Legal

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    And in 'ESOP Offer' page, 'Documents & Media' tab, 'Upload' button is pressed
    When in 'Upload New Document' pop-up, '<Document Name>' is entered into Document Name
    And in 'Upload New Document' pop-up, <Document Type> radio is selected for 'Document Type'
    And in 'Upload New Document' pop-up, 'The Employee will need to sign this document as part of agreeing to the offer.' checkbox is <Legal Document Agreement>
    And in 'Upload New Document' pop-up, upload '<Filename>' file to 'UPLOAD DOCUMENT (PDF ONLY) *'
    And in 'Upload New Document' pop-up, '<Filename>' file is uploaded
    And in 'Upload New Document' pop-up, 'Upload' button is pressed
    And in ESOP offer, <Document Name> section, more 'Publish Document' is pressed for <Offer Name>
    Then in ESOP offer, 'Legal Documents' section, displays
      | Document Name   | Signature Required | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Document Name> | check              |               | checked   |          | [Today]       |

    @ESOPSmoke @TestCaseKey=PLX-T285 @DEV @TEST @run 
    Examples: Legal Document Agreement : Checked
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Name | Document Type | Legal Document Agreement | Filename             |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Closed Manual  | Legal Doc 5   | Legal         | checked                  | legal_document.pdf   |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Legal Doc 5   | Legal         | checked                  | legal_document.pdf   |
    
    @ESOPRegression @TestCaseKey=PLX-T285 @DEV @TEST @run 
    Examples: Legal Document Agreement : Checked
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Name | Document Type | Legal Document Agreement | Filename             |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Legal Doc 1   | Legal         | checked                  | legal_document.pdf   |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Legal Doc 4   | Legal         | checked                  | legal_document.pdf   |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Legal Doc 5   | Legal         | checked                  | legal_document.pdf   |
      #PLX-3525
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 2 Closed Auto    | Legal Doc 5   | Legal         | checked                  | legal_document.pdf   |

  @ESOPRegression @PLX-2773 
  Scenario Outline: Setup Documents - Legal (Not Legal Document Agreement)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    And in 'ESOP Offer' page, 'Documents & Media' tab, 'Upload' button is pressed
    When in 'Upload New Document' pop-up, '<Document Name>' is entered into Document Name
    And in 'Upload New Document' pop-up, <Document Type> radio is selected for 'Document Type'
    And in 'Upload New Document' pop-up, 'The Employee will need to sign this document as part of agreeing to the offer.' checkbox is <Legal Document Agreement>
    And in 'Upload New Document' pop-up, upload '<Filename>' file to 'UPLOAD DOCUMENT (PDF ONLY) *'
    And in 'Upload New Document' pop-up, '<Filename>' file is uploaded
    And in 'Upload New Document' pop-up, 'Upload' button is pressed
    Then in ESOP offer, 'Legal Documents' section, displays
      | Document Name   | Signature Required | Linked to Q&A | Published | Archived | Date Uploaded |
      | <Document Name> |                    |               |           |          | [Today]       |

    @TestCaseKey=PLX-T286 @DEV @run 
    Examples: Legal Document Agreement : Not checked
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Name | Document Type | Legal Document Agreement | Filename           |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Legal Doc 2   | Legal         |                          | legal_document.pdf |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Legal Doc 3   | Legal         |                          | legal_document.pdf |

  @PLX-2773 
  Scenario Outline: ESOP - Add URL: Add URL (YouTube) where Offer [Status] = "Setup' (Issue User ESOP access)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'ESOP Offer' page, 'Documents & Media' tab, 'Add' button is pressed
    And in 'Add Video Link' pop-up, '<Video Title>' is entered into Title
    And in 'Add Video Link' pop-up, '<Video URL>' is entered into URL
    And in 'Add Video Link' pop-up, 'Add' button is pressed
    And alert pop-up, success, 'Video updated' is displayed
    Then 'Media' table, displays details
      | Title         | URL Link    | Date Uploaded |
      | <Video Title> | <Video URL> | [Today]       |
    When '<Video URL>' video is pressed
    Then '<Video URL>' YouTube video is displayed

    @TestCaseKey=PLX-T291 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Video Title | Video URL                                                |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | ESOP        | https://www.youtube.com/channel/UCY9c2Rjjwa8zWG4zcmIS8rQ |
    # | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Auto | ESOP        | https://www.youtube.com/channel/UCY9c2Rjjwa8zWG4zcmIS8rQ |

    @TestCaseKey=PLX-T291 @DEV
    Examples: #TODO: Does not work as expected, possibly due to internal re-directs for embeded (leobenkel/tampermonkey_youtube_redirect.js)
      | Issuer | Company       | Plan Name                    | Offer Name                          | Video Title | Video URL                                   |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | URL 1       | https://youtu.be/iPJHfIB7HO4                |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | URL 2       | https://www.youtube.com/watch?v=C0DPdy98e4c |

  @PLX-2773 @Regression 
  Scenario Outline: Setup Documents - 50 limit

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    And 'Documents' tab title is displayed
    When in 'ESOP Offer' page, 'Documents & Media' tab, 'Upload' <Number of Documents> documents of <Document Type>
    And in '<Document Type> Documents' table, 'Clone <Document Type> doc <Number of Documents>' name is displayed
    And in ESOP offer, '<Document Type> Documents' section, displays
      | Document Name                                   | Signature Required | Linked to Q&A | Published | Archived | Date Uploaded |
      | Clone <Document Type> doc <Number of Documents> |                    |               |           |          | [Today]       |
    And in 'ESOP Offer' page, 'Documents & Media' tab, 'Upload' button has mouse over
    Then 'You've reached the maximum number of documents (50) you can upload.' info box is displayed

    @TestCaseKey=PLX-T284 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Type | Filename             | Number of Documents |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General       | general_document.pdf | 44                  |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#3        | CYPRESS-ESOP Offer 1 Auto Cloned    | Legal         | legal_document.pdf   | 50                  |

  @ESOPRegression @PLX-2773 
  Scenario Outline: AC4- Issuer user can view / download the documents

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Documents & Media' tab is pressed
    When in '<Document Table>' table, '<Document Name>' is pressed
    Then verify '<Filename>' file is downloaded

    @TestCaseKey=PLX-T332 @DEV @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | Document Table    | Document Name | Filename             |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | General Documents | General Doc 1 | general_document.pdf |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Legal Documents   | Legal Doc 2   | legal_document.pdf   |

