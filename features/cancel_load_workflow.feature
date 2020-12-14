########################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for perform cancel Load Check tests                                           #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-339                                                                           #
########################################################################################################################

@all @cancel-load-check @MAUI-339 @regression
Feature: Cancel Load Workflow
  As a user I want to have the option to cancel Load Check workflow at any time, so that I can make adjustments and
  start load again when needed.

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @reset_deck_layout
  Scenario: Cancel workflow on Load Check for Load supplies page when sample tubes successfully scanned
    Given user is on screen "loadSample"
    When user performs scan sample tubes successfully
    Then user should be able to cancel Load Check workflow

  @reset_deck_layout
  Scenario: Cancel workflow on Load Check for Load supplies page when all supplies successfully scanned
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    When user performs scan for all supplies "successfully"
    Then user should be able to cancel Load Check workflow

  @reset_deck_layout
  Scenario: Cancel workflow on Load Check for Load supplies page when all supplies successfully scanned
    Given user is on screen "loadSupplies"
    When user performs scan for all supplies "not successfully"
    Then user should be able to cancel Load Check workflow

  @reset_deck_layout
  Scenario: Cancel workflow on Load Check for Load samples page when sample tubes not successfully scanned
    Given user is on screen "loadSample"
    When sample tubes not successfully scanned
    Then user should be able to cancel Load Check workflow

  @reset_deck_layout
  Scenario: User confirmation to cancel Load Check workflow on Load samples page
    Given user is on screen "loadSample"
    And sample tubes not successfully scanned
    And user selects to cancel Load Check workflow
    When user "confirming" cancellation of Load Check workflow
    Then user should stay on screen "loadSample"

  @reset_deck_layout
  Scenario: User confirmation to cancel Load Check workflow on Load supplies page
    Given user is on screen "loadSupplies"
    And user selects to cancel Load Check workflow
    When user "confirming" cancellation of Load Check workflow
    Then user should be redirected to screen "loadSample"

  @reset_deck_layout
  Scenario: User declines to cancel Load Check workflow on Load samples page
    Given user is on screen "loadSample"
    And sample tubes not successfully scanned
    And user selects to cancel Load Check workflow
    When user "declines" cancellation of Load Check workflow
    Then user should stay on screen "loadSample"

  @reset_deck_layout
  Scenario: User declines to cancel Load Check workflow for Load supplies page
    Given user is on screen "loadSupplies"
    And user selects to cancel Load Check workflow
    When user "declines" cancellation of Load Check workflow
    Then user should stay on screen "loadSupplies"

  @reset_deck_layout
  Scenario: User declines to cancel Load Check workflow and countdown timer is not stopped on Load supplies page
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    When user selects to cancel Load Check workflow
    And user "declines" cancellation of Load Check workflow
    Then countdown timer should be "not stopped"

  @reset_deck_layout
  Scenario: User cancels Load Check workflow and countdown timer is stopped on Load supplies page
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    When user selects to cancel Load Check workflow
    And user "confirming" cancellation of Load Check workflow
    Then countdown timer should be "stopped"

  @reset_deck_layout
  Scenario: User opens cancellation dialog and leave it open. Then timer will continue to countdown and start of sequencing workflow.
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    When user selects to cancel Load Check workflow
    And user leaves Load Check cancellation dialog open
    Then countdown timer should be "not stopped"

  @reset_deck_layout
  Scenario: User declines to cancel Load Check and can proceed with workflow on Load supplies page
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    When user selects to cancel Load Check workflow
    And user "declines" cancellation of Load Check workflow
    Then user should be able to proceed with Load Check workflow

  @reset_stub_responses_to_default @reset_deck_layout
  Scenario: User is presented with an error when cancellation of load check workflow is failed on Load supplies page
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    When user selects to cancel Load Check workflow
    And load check cancellation fails
    Then user should be presented with load check cancellation error dialog

  @reset_stub_responses_to_default @reset_deck_layout
  Scenario: User is redirected to the Load Samples page when load check cancellation error dialog was dismissed
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    And user selects to cancel Load Check workflow
    And load check cancellation fails
    When user dismiss load check cancellation error dialog
    Then user should be redirected to screen "loadSample"
