@PLX-2713
Feature: ESOP Manage participants - add participants (bulk upload)

  @ESOPRegression @PLX-3173 
  Scenario Outline: ESOP - Bulk upload Participant: Given an Offer [Status] = "Setup" | Verify you can download template for bulk upload of participants

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant (Bulk Upload)' action is selected
    And in 'Add Participants (Bulk Import)' pop-up, 'Download Template' button is pressed
    Then verify '<File Name>' file is downloaded
    And downloaded csv file '<File Name>' has header row
      | First Name | Middle Name | Last Name | Email | Address Line 1 | Address Line 2 | Suburb | State | Postcode | Country | Position | Department | Work Number | Number of Securities |

    @TestCaseKey=PLX-T385 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | File Name                            |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Participant_Bulk_Upload_Template.csv |

  @ESOPRegression @PLX-3173 
  Scenario Outline: ESOP - Bulk upload Participant: Given Offer [Status] = "Setup" | Verify error checking on a bulk upload of participants where the csv file is correct format (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant (Bulk Upload)' action is selected
    And in 'Add Participants (Bulk Import)' pop-up, upload '<File Name>' file to 'Upload Document'
    # Then alert pop-up, error, 'The following headers are missing in the file: Work Number' is displayed
    Then alert pop-up, File could not be uploaded, 'contained missing data or incorrect formatting and could not be uploaded.' is displayed
    And in 'Add Participants (Bulk Import)' pop-up, 'File could not be uploaded' table, displays details
      | Column Header        | Rows(s) | Errors                                      |
      | Email                | 4       | Invalid email address                       |
      | Email                | 12, 15  | Duplicate emails in file                    |
      | Last Name            | 5       | Required field                              |
      | Email                | 6       | Required field                              |
      | Address Line 1       | 7       | Required field                              |
      | Suburb               | 8       | Required field                              |
      | State                | 9       | Required field                              |
      | Country              | 10      | Required field                              |
      | Number of Securities | 11      | Number of securities must be greater than 0 |
    @TestCaseKey=PLX-T382 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | File Name                        |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | ESOP_Participant_Bulk_Upload.csv |

  @ESOPRegression @PLX-3173 
  Scenario Outline: ESOP - Bulk upload Participant: Given an Offer [Status] = "Setup" | Verify you can cancel out of a bulk upload of participants where the csv file is correct format (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant (Bulk Upload)' action is selected
    And in 'Add Participants (Bulk Import)' pop-up, upload '<File Name>' file to 'Upload Document'
    Then alert pop-up, error, 'The following headers are missing in the file: Work Number' is displayed
    And in 'Add Participants (Bulk Import)' pop-up, 'Cancel' button is pressed
    Then 'This ESOP Offer has no Participant' table content is displayed

    @TestCaseKey=PLX-T384 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  | File Name                                   |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | Fixed_data_ESOP_Participant_Bulk_Upload.csv |

  @ESOPRegression @PLX-3173 
  Scenario Outline: ESOP - Bulk upload Participant: Given Offer [Status] = "Setup" | Verify bulk upload of participants where the csv file is correct format (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant (Bulk Upload)' action is selected
    And in 'Add Participants (Bulk Import)' pop-up, upload '<File Name>' file to 'Upload Document'
    # And in 'Add Participants (Bulk Import)' pop-up, '<File Name>' file is uploaded
    And in 'Add Participants (Bulk Import)' pop-up, 'Upload' button is pressed
    And alert pop-up, success, 'Participants added successfully' is displayed
    # Then in '' table, show row details #TODO:

    @TestCaseKey=PLX-T383 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  | File Name                                      |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | Fixed_data_ESOP_Participant_Bulk_Upload_V2.csv |

  @ESOPRegression @PLX-3173 
  Scenario Outline: ESOP - Bulk upload Participant: Given Offer [Status] = "Setup" | Verify error (+ duplicates) checking on a bulk upload of participants where the csv file is correct format (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant (Bulk Upload)' action is selected
    And in 'Add Participants (Bulk Import)' pop-up, upload '<File Name>' file to 'Upload Document'
    # Then alert pop-up, error, 'The following headers are missing in the file: Work Number' is displayed
    Then alert pop-up, File could not be uploaded, 'contained missing data or incorrect formatting and could not be uploaded.' is displayed
    And in 'Add Participants (Bulk Import)' pop-up, 'File could not be uploaded' table, displays details
      | Column Header        | Rows(s)                                  | Errors                                             |
      | Email                | 4                                        | Invalid email address                              |
      | Email                | 2, 3, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15 | Duplicate email, user already exists in the system |
      | Email                | 12                                       | Duplicate emails in file                           |
      | Last Name            | 5                                        | Required field                                     |
      | Email                | 6                                        | Required field                                     |
      | Address Line 1       | 7                                        | Required field                                     |
      | Suburb               | 8                                        | Required field                                     |
      | State                | 9                                        | Required field                                     |
      | Country              | 10                                       | Required field                                     |
      | Number of Securities | 11                                       | Number of securities must be greater than 0        |

    @TestCaseKey=PLX-T488 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                  | File Name                        |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | ESOP_Participant_Bulk_Upload.csv |

  @ESOPRegression @PLX-3173 
  Scenario Outline: ESOP - Bulk upload Participant: Given Offer [Status] = "Setup" | Verify bulk upload if not done if csv file format is incorrect (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant (Bulk Upload)' action is selected
    And in 'Add Participants (Bulk Import)' pop-up, upload '<File Name>' file to 'Upload Document'
    Then alert pop-up, error, 'File type must be application/vnd.ms-excel,.xls,.xlsx,text/csv,.csv' is displayed

    @TestCaseKey=PLX-T386 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | File Name            |
      # | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual | Wrong_format_ESOP_Participant_Bulk_Upload_V2.xlsx |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | general_document.pdf |

  @ESOPRegression @PLX-3173 
  Scenario Outline: ESOP - Bulk upload Participant: Given Offer [Status] = "Setup" | Verify you cannot bulk upload a file >100k (Issue user ESOP role)

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> tile is pressed
    And in ESOP plan, <Offer Name> tile is pressed
    And in ESOP offer, 'Participants' tab is pressed
    And 'Participants' tab title is displayed
    When in 'ESOP Offer' page, 'Securities' tab, 'Add Participant (Bulk Upload)' action is selected
    And in 'Add Participants (Bulk Import)' pop-up, upload '<File Name>' file to 'Upload Document'
    Then alert pop-up, error, 'File size is too large. Maximum file size is 100 KB.' is displayed

    @TestCaseKey=PLX-T434 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name                    | Offer Name                          | File Name                          |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated | CYPRESS-ESOP Offer 1 Manual Updated | Bulk_Upload_File_size_more_10K.csv |