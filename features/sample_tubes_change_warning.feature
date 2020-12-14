# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                        Feature file for sample tube change warning  tests                            #
#                                                                                                                      #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-417                                                                           #
########################################################################################################################

@all @sample-tubes-change-warning @MAUI-417 @regression
Feature: Sample tube change warning
  As a user I want the instrument to show me warning(s) that occurs when sample tubes are changed, so that I can
  take preventive actions.

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @positive @reset_deck_layout
  Scenario: Sample tube swap/change triggers warning message being shown on consecutive scan
    Given sample complex has been validated
    When user replaces the sample tube(s) with different sample tubes
    And user initiates scanning of load deck
    Then the instrument software shall warn the user that sample tube(s) were replaced
    And instrument software should allow user to "continue" workflow
    And instrument software should allow user to "cancel" workflow

  @positive @reset_deck_layout
  Scenario: Sample tube swap/change triggers warning message being shown on consecutive scan and user proceeds with workflow
    Given sample complex has been validated
    And user replaces the sample tube(s) with different sample tubes
    And user initiates scanning of load deck
    When the instrument software shall warn the user that sample tube(s) were replaced
    And user selects option to continue
    Then user is able to continue with sequencing workflow

  @positive @reset_deck_layout
  Scenario: Sample tube swap/change triggers warning message being shown on consecutive scan and user cancel workflow
    Given sample complex has been validated
    And user replaces the sample tube(s) with different sample tubes
    And user initiates scanning of load deck
    When the instrument software shall warn the user that sample tube(s) were replaced
    And user selects option to cancel
    Then user is redirected to Load samples screen
    And sample tubes marked like they are not present on the deck

  @positive @reset_deck_layout
  Scenario: Sample tube swap/change triggers warning message being shown on consecutive scan and user closes warning dialog
    Given sample complex has been validated
    And user replaces the sample tube(s) with different sample tubes
    And user initiates scanning of load deck
    When the instrument software shall warn the user that sample tube(s) were replaced
    And user selects option to close warning message dialog
    Then user is redirected to Load samples screen
