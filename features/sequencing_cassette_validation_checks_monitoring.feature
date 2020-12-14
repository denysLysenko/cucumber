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

  Scenario: Sequencing cassette validation check:
            - No assay specific method determined.
            - Working sequencing cassette.
            - New sequencing cassette.
            - All data can be acquired
    Given "valid_new" SC is inserted
    And the clamp is closed
    When the instrument software got SC info
    Then the instrument software UI show SC has "no" errors

  Scenario: Sequencing cassette validation check:
            - No assay specific method determined.
            - Malfunctioning sequencing cassette.
    Given "malfunctioning" SC is inserted
    When the clamp is closed
    Then the instrument software UI show SC has "missing SC/Contact error" errors

  Scenario: Sequencing cassette validation check:
            - No assay specific method determined.
            - Working sequencing cassette.
            - New sequencing cassette.
            - DB is down
    Given "valid_new" SC is inserted
    And the clamp is closed
    When the instrument software determined SC is "new"
    # Info that is written to DB: SC name, first seen date
    And database is down
    Then the instrument software show error related to database


  Scenario: Sequencing cassette validation check:
            - No assay specific method determined.
            - Working sequencing cassette.
            - Used sequencing cassette. It was clamped before
    Given "valid_used" SC is inserted
    When the clamp is closed
    Then the instrument software UI show SC has "no" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Working sequencing cassette.
            - New sequencing cassette. Never clamped.
    Given the instrument deck is loaded with "valid" sample tube
    And scanning of the deck is triggered and completed
    When "valid_new" SC is inserted
    And the clamp is closed
    Then the instrument software UI show SC has "no" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Working sequencing cassette.
            - Used sequencing cassette. Clamped before.
            - Enough lanes
    Given the instrument deck is loaded with "valid" sample tube
    And scanning of the deck is triggered and completed
    When "valid_used_enough_lanes" SC is inserted
    And the clamp is closed
    Then the instrument software UI show SC has "no" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Working sequencing cassette.
            - Used sequencing cassette. Clamped before.
            - Expired based on use by date.
    Given the instrument deck is loaded with "valid" sample tube
    And scanning of the deck is triggered and completed
    When "expired" SC is inserted
    And the clamp is closed
    Then the instrument software UI show SC has "expired_use_by_date" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Working sequencing cassette.
            - Used sequencing cassette. Clamped before.
            - Expired based on barcode exp date
    Given the instrument deck is loaded with "valid" sample tube
    And scanning of the deck is triggered and completed
    When "expired" SC is inserted
    And the clamp is closed
    Then the instrument software UI show SC has "expired_by_barcode" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Working sequencing cassette.
            - All lanes used.
    Given the instrument deck is loaded with "valid" sample tube
    And scanning of the deck is triggered and completed
    And assay specific method determined as "METHOD_NAME"
    And "all_lanes_used" SC is inserted
    And the clamp is closed
    When the instrument software checks SC if any lanes available
    Then the instrument software UI show SC has "no_available_lanes" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Working sequencing cassette.
            - Incompatible SC type
    Given the instrument deck is loaded with "valid" sample tube
    And scanning of the deck is triggered and completed
    When "incompatible_type" SC is inserted
    And the clamp is closed
    Then the instrument software UI show SC has "incompatible_type" errors

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Working sequencing cassette.
            - Not enough lanes
    Given the instrument deck is loaded with "valid" sample tube
    And scanning of the deck is triggered and completed
    When "n" available lanes SC is inserted
    And the clamp is closed
    Then the instrument software UI show SC has "not_enough_lanes" errors

  Scenario: Sequencing cassette validation check:
            - Not clamped
    Given "valid new" SC is inserted
    When the clamp is not engaged
    Then instrument software informs user to engage the clamp

  Scenario: Sequencing cassette validation check:
            - Assay specific method determined.
            - Sequencing cassette with multiple issues
    Given the instrument deck is loaded with "valid" sample tube
    And scanning of the deck is triggered and completed
    When "multiple_errors" SC is inserted and the clamp is closed
    Then the instrument software UI show SC has "multiple_errors" errors


