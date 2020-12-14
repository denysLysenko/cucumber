# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                              Feature file for sequencing cassette validation checks tests                            #
#                                                                                                                      #
#  https://jira.gene.com/jira/browse/MAUI-48                                                                           #
#  SC -> Sequencing Cassette                                                                                           #
#                                                                                                                      #
#                                                                                                                      #
########################################################################################################################

@all @MAUI-48
Feature:  As a user, I want the system to check the validity of the loaded sequencing cassette, so that I can take corrective
  actions before starting a run.

  Background:
    * instrument user successfully logged in
    * the instrument deck is loaded with "valid" sample tube

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Working sequencing cassette.
            - New sequencing cassette.
            - All data can be acquired.
    Given "valid_new" SC is inserted
    And the clamp is closed
    When scanning of the deck is triggered and finished
    Then the instrument software UI show SC has "no" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Malfunctioning sequencing cassette.
    Given "malfunctioning" SC is inserted
    And the clamp is closed
    When scanning of the deck is triggered and finished
    Then the instrument software UI show SC has "missing SC/Contact error" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Valid sequencing cassette.
            - New sequencing cassette.
            - Barcode not readable
    Given "valid_new" SC is inserted
    And the clamp is closed
    And scanning of the deck is triggered and finished
    When the SC barcode "no_readable"
    Then the instrument software UI show SC has "SC barcode not readable" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Valid sequencing cassette.
            - New sequencing cassette.
            - Expired based on barcode exp date.
    Given "expired_by_barcode" SC is inserted
    And the clamp is closed
    And scanning of the deck is triggered and finished
    When the instrument software checks SC expiration date is "invalid"
    Then the instrument software UI show SC has "expired_by_barcode" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Valid sequencing cassette.
            - New sequencing cassette.
            - Expired based on use by date.
    Given "expired_use_by_date" SC is inserted
    And the clamp is closed
    And scanning of the deck is triggered and finished
    When the instrument software checks SC expiration date is "invalid"
    Then the instrument software UI show SC has "expired_use_by_date" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Valid sequencing cassette.
            - Used sequencing cassette.
            - All data can be acquired
    Given "valid_used" SC is inserted
    And the clamp is closed
    When scanning of the deck is triggered and finished
    Then the instrument software UI show SC has "no" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Valid sequencing cassette.
            - Used sequencing cassette.
            - Expired.
    Given "expired" SC is inserted
    And the clamp is closed
    When scanning of the deck is triggered and finished
    Then the instrument software UI show SC has "expired" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Valid sequencing cassette.
            - Used sequencing cassette.
            - All lanes used.
    Given "all_lanes_used" SC is inserted
    And the clamp is closed
    When scanning of the deck is triggered and finished
    Then the instrument software UI show SC has "no_available_lanes" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Valid sequencing cassette.
            - Used sequencing cassette.
            - incompatible SC type
    Given "incompatible_type" SC is inserted
    And the clamp is closed
    When scanning of the deck is triggered and finished
    Then the instrument software UI show SC has "incompatible_type" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Valid sequencing cassette.
            - Used sequencing cassette.
            - not enough lanes
    Given "not_enough_lanes" SC is inserted
    And the clamp is closed
    When scanning of the deck is triggered and finished
    Then the instrument software UI show SC has "not_enough_lanes" errors

  Scenario: Sequencing cassette validation check:
            - No assay specific method determined.
            - Valid sequencing cassette.
            - New sequencing cassette.
            - DB is down

    Given "valid_new" SC is inserted
    And the clamp is closed
    And scanning of the deck is triggered and finished
    When database is down
    Then the instrument software show error related to database

