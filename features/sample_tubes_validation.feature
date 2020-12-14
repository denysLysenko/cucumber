# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                Feature file for sample tubes validation tests                                        #
#                                                                                                                      #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-201                                                                           #
########################################################################################################################

@all @sample-tubes-validation @MAUI-201 @regression
Feature: Sample tubes validation

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @positive @reset_deck_layout @set_sensors_to_their_thresholds
  Scenario: The user is be able to start Load Check after the sample tubes where loaded and the cover was closed
    Given user is on screen "loadSample"
    And instrument cover is open
    And sample tubes have been placed on the deck
    When user closes the instrument cover
    Then user should be able to start Load Check

  @positive @reset_deck_layout
  Scenario: The sequence protocol shall be determined after scanning the sample tubes
    Given user is on screen "loadSample"
    And sample tubes have been placed on the deck
    When user starts Load Check
    Then protocol associated with the sample barcodes should be determined

  @positive @reset_sample_related_orders_to_default
  Scenario Outline: The instrument shall display an error message if the complex protocol is not supported
    Given user is on screen "loadSample"
    And the "<tubeRunNumber>" sample tube with not supported by the instrument protocol have been placed on the deck
    When user starts Load Check
    Then "not supported protocol" error message should be displayed

    Examples:
      | tubeRunNumber |
      | first         |
      | second        |

  @positive @reset_deck_layout
  Scenario Outline: In case if sample tube was successfully scanned the instrument shall display tube details if user clicks on it:
    - assay name
    - sample tube ID
    - sample creation date
    - sample expiration date

    Given user is on screen "loadSupplies"
    When user invokes the "<tubeRunNumber>" sample tube details
    Then user should be able to see the "<tubeRunNumber>" sample tube details

    Examples:
      | tubeRunNumber |
      | first         |
      | second        |

  @positive @reset_sample_related_orders_to_default
  Scenario Outline: The instrument shall display an error message during Load Check if the complex has been already used
    Given user is on screen "loadSample"
    And the "<tubeRunNumber>" already used sample tube have been placed on the deck
    And user starts Load Check
    When the "<tubeRunNumber>" sample tube determined to be used
    And user invokes the "<tubeRunNumber>" sample tube details
    Then the instrument software should provide "sample tube was used" error message

    Examples:
      | tubeRunNumber |
      | first         |
      | second        |

  @positive @reset_sample_related_orders_to_default
  Scenario Outline: The instrument shall display a warning message during Load Check if the complex has exceeded onboard stability
    Given user is on screen "loadSample"
    And the "<tubeRunNumber>" not stable sample tube have been placed on the deck
    And user starts Load Check
    When the "<tubeRunNumber>" sample tube determined to be exceeding onboard stability
    Then the instrument software should warn the user that the "<tubeRunNumber>" sample tube is not stable
    And instrument software should allow user to "continue" workflow
    And instrument software should allow user to "cancel" workflow

    Examples:
      | tubeRunNumber |
      | first         |
      | second        |
