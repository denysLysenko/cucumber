# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for Reagent Cassette validation tests                                         #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-403                                                                           #
########################################################################################################################

@all @reagent-cassette-validation @MAUI-403 @regression
Feature: Reagent Cassette validation
  As a user, I want the system to check the validity of reagent cassette loaded on the sequencing instrument,
  so that I can take corrective actions before starting a run

  Background: User is logged in and sample tubes were successfully scanned
    * instrument user successfully logged in
    * assay specific method determined

  @positive @reset_deck_layout
  Scenario: Perform validation for reagent cassette(s):
    - valid reagent cassette
    - not expired

    Given "valid" reagent cassette and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show reagent cassette has "no" errors
    And user "can" proceed with workflow

  @negative @reset_deck_layout
  Scenario: Perform validation for reagent cassette(s):
    - valid reagent cassette
    - expired

    Given "expired" reagent cassette and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show reagent cassette has "expired" errors
    And user "can not" proceed with workflow

  @negative @reset_deck_layout
  Scenario: Perform validation for reagent cassette(s):
    - damaged/unreadable barcode
    - no reagent cassette

    Given "unreadableBarcode" reagent cassette and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show reagent cassette has "missingUnreadableBarcode" errors
    And user "can not" proceed with workflow

  @negative @reset_deck_layout
  Scenario Outline: Perform validation for reagent cassette(s): incompatible reagents
    Given "<issueType>" reagent cassette and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show reagent cassette has "<issueType>" errors
    And user "can not" proceed with workflow

    Examples:
      | issueType            |
      | invalidContentType   |
      | invalidComponentType |
      | invalidProtocolType  |

  @negative @reset_deck_layout
  Scenario: Perform validation for reagent cassette(s): invalid barcode
    Given "invalidBarcode" reagent cassette and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show reagent cassette has "invalidBarcode" errors
    And user "can not" proceed with workflow
