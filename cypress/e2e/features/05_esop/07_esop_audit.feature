
Feature: Audit

  Scenario: Check audit
    # Given PLX-T477 is executed
    # When the admin run the following sql
    # And replace the variables
    # " where audit_timestamp >= audit_timestamp
    # and username = username
    # audit_timestamp
    # current execution time  "
    # Then the system will return the result and verify the value of the following columns

    Given connected to the Platformx database
    When SQL is executed "select * from audit_record ar where username like '<Username>' and audit_timestamp >= '<From Audit Timestamp>' and audit_timestamp < '<To Audit Timestamp>';"
    Then returns results
      | username   | action   | from_state            | to_state            |
      | <Username> | <Action> | <Contains From state> | <Contains To State> |

    @TestCaseKey=PLX-T480 @DEV @TEST 
    Examples:
      | Username | From Audit Timestamp    | To Audit Timestamp      | Action | Actions                   | From State | Expectations                                    | Contains To State                                                                            |
      | Issuer   | 2023-02-27 18:55:05.641 | 2023-02-27 18:55:05.642 | CREATE | x 1 (add participant)     |            | Original (before) value on the first UPDATE row | "name":"CYPRESS-ESOP 2023Q1#3","description":"CYPRESS-ESOP 2023Q1 - #3"                      |
      | Issuer   | 2023-02-28 04:55:10.289 | 2023-02-28 04:55:10.290 | UPDATE | x 2 (before/after update) |            | New (after) values on the 2nd UPDATE row        | "status":"SETUP","name":"ESOP Offer1 Updated","description":"ESOP3 Offer 1 Updated","option" |

