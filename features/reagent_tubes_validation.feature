# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                Feature file for reagent tubes validation tests                                       #
#                                                                                                                      #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-272                                                                           #
########################################################################################################################

@all @reagent-tubes-validation @MAUI-272 @regression
Feature: Reagent Tubes validation
  As a user, I want the system to check the validity of reagent tubes, so that I can take corrective
  actions before starting a run.

  Background: User is logged in and sample tubes were successfully scanned
    * instrument user successfully logged in
    * assay specific method determined

  @positive @reset_deck_layout
  Scenario: Perform validation for reagent tubes:
      - all tubes are valid
      - barcode readable
      - not expired
      - lot is matching
      - placed in correct location
    Given "allValidTubes" with necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "allReagent" tube(s) has "no" errors
    And user "can" proceed with workflow

  @positive @reset_deck_layout
  Scenario: Perform validation for reagent tubes:
      - all tubes are valid
      - barcode readable
      - not expired
      - lot is matching
      - placed in correct location
    Given "allValidTubes" with necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "allReagent" tube(s) has "no" errors
    And user "can" proceed with workflow
    And user should be able to see bypassing countdown

  @positive @reset_deck_layout
  Scenario: Reagent tubes details shall be shown to the user after validation - Single batch:
      - id
      - lot ID
      - expiration date
    Given "allValidTubes" with necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show tube details for batch "1"

  @positive @reset_deck_layout
  Scenario: Reagent tubes details shall be shown to the user after validation - Double batch:
      - id
      - lot ID
      - expiration date
    Given "allValidTubes" with necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show tube details for batch "1"
    And the instrument software UI show tube details for batch "2"

  @negative @reset_deck_layout
  Scenario Outline: Perform validation for reagent tubes: expired
    Given "expired" "<tubeName>" tube(s) is loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "<tubeName>" tube(s) has "expired" errors
    And user "can not" proceed with workflow

    Examples:
      | tubeName         |
      | osmo             |
      | tagSolution      |
      | needleWash       |
      | membraneSolution |
      | allReagent       |

  @negative @reset_deck_layout
  Scenario Outline: Perform validation for reagent tubes:
    - damaged/unreadable barcode
    - no reagent cassette

    Given "unreadableBarcode" "<tubeName>" tube(s) is loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "<tubeName>" tube(s) has "missingUnreadableBarcode" errors
    And user "can not" proceed with workflow

    Examples:
      | tubeName         |
      | osmo             |
      | tagSolution      |
      | needleWash       |
      | membraneSolution |
      | allReagent       |

  @negative @reset_deck_layout
  Scenario Outline: Perform validation for reagent tubes: incompatible (invalid content type)
    Given "invalidContentType" "<tubeName>" tube(s) is loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "<tubeName>" tube(s) has "invalidContentType" errors
    And user "can not" proceed with workflow

    Examples:
      | tubeName         |
      | osmo             |
      | tagSolution      |
      | needleWash       |
      | membraneSolution |
      | allReagent       |

  @negative @reset_deck_layout
  Scenario Outline: Perform validation for reagent tubes: incompatible (invalid component type)
    Given "invalidComponentType" "<tubeName>" tube(s) is loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "<tubeName>" tube(s) has "invalidComponentType" errors
    And user "can not" proceed with workflow

    Examples:
      | tubeName         |
      | osmo             |
      | tagSolution      |
      | needleWash       |
      | membraneSolution |
      | allReagent       |

  @negative @reset_deck_layout
  Scenario Outline: Perform validation for reagent tubes: incompatible (invalid protocol type)
    Given "invalidProtocolType" "<tubeName>" tube(s) is loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "<tubeName>" tube(s) has "invalidProtocolType" errors
    And user "can not" proceed with workflow

    Examples:
      | tubeName         |
      | osmo             |
      | tagSolution      |
      | needleWash       |
      | membraneSolution |
      | allReagent       |

  @negative @reset_deck_layout
  Scenario Outline: Perform validation for reagent tubes: lot mismatch
    Given "lotMismatch" "<tubeName>" tube(s) is loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "allReagent" tube(s) has "lotMismatch" errors
    And user "can not" proceed with workflow

    Examples:
      | tubeName         |
      | osmo             |
      | tagSolution      |
      | needleWash       |
      | membraneSolution |
      | allReagent       |

  @negative @reset_deck_layout
  Scenario Outline: Perform validation for reagent tubes: invalid barcode
    Given "invalidBarcode" "<tubeName>" tube(s) is loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "<tubeName>" tube(s) has "invalidBarcode" errors
    And user "can not" proceed with workflow

    Examples:
      | tubeName         |
      | osmo             |
      | tagSolution      |
      | needleWash       |
      | membraneSolution |
      | allReagent       |
