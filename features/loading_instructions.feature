########################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                       Feature file for load instruction tests                                        #
#                                                                                                                      #
# story link: https://jira.gene.com/jira/browse/MAUI-200                                                               #
#                                                                                                                      #
########################################################################################################################

@all @loading-instructions @MAUI-200 @regression
Feature: Loading instructions
  As a user, I want the sequencing instrument to display Load instructions

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  Scenario Outline: Instrument software shall show sample tube loading instructions when instrument is in ready state
    Given user is on screen "loadSample"
    When user invokes context sensitive help for "<sampleTube>"
    Then user should be able to see context sensitive help for "<sampleTube>"
    And all other supplies items on the deck are disabled

    Examples:
      | sampleTube   |
      | sampleBatch1 |
      | sampleBatch2 |

  @reset_deck_layout
  Scenario Outline: Instrument software shall show loading instructions on load supplies page when instrument is in ready state for deck items:
      - sequencing cassette
      - reagent cassette
      - reagent tubes
      - system reagent
      - liquid waste

    Given user is on screen "loadSupplies"
    When user invokes context sensitive help for "<loadDeckSuppliesItem>"
    And user should be able to see context sensitive help for "<loadDeckSuppliesItem>"

    Examples:
      | loadDeckSuppliesItem  |
      | sequencingCassette    |
      | membraneBatch1        |
      | needleBatch1          |
      | tagBatch1             |
      | osmoBatch1            |
      | reagentCassetteBatch1 |
      | membraneBatch2        |
      | needleBatch2          |
      | tagBatch2             |
      | osmoBatch2            |
      | reagentCassetteBatch2 |
      | systemReagent         |
      | liquidWaste           |

  Scenario: Instrument software shall show additional loading info for load sample screen in header text
    Given user is on screen "loadSample"
    Then user should see the loading information for "loadSample" in the header text

  @reset_deck_layout
  Scenario: Instrument software shall show additional loading info for load supplies screen in header text
    Given user is on screen "loadSupplies"
    Then user should see the loading information for "loadSupplies" in the header text
