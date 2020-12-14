# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                        Feature file for Initiate Sequencing Run                                      #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-402                                                                           #
########################################################################################################################

@all @initiate-sequencing-run @MAUI-402 @regression
Feature: Run Initiation options
  As a user, I want to have options to initiate my sequencing run.

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @TRQ-UID-907
  Scenario: The instrument software shall provide the following run batch initiation option: start sequencing
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    When user performs scan for all supplies "successfully"
    Then user should "be" able to start Sequencing Run

  @TRQ-UID-907
  Scenario: The instrument software shall provide the following run batch initiation option: cancel workflow
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    When user performs scan for all supplies "successfully"
    Then user should be able to cancel Load Check workflow

  @wait_both_runs_to_be_completed @TRQ-UID-907
  Scenario: Upon user selection to start sequencing, the instrument software shall start the sequencing run batch
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    When user starts Sequencing
    Then sequencing should be performed by the instrument

  @set_sensors_to_their_thresholds @TRQ-UID-907
  Scenario: When a health error occurs after successful Load Check, the instrument software shall terminate the countdown timer
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    And countdown timer becomes visible for the user
    When "instrument" health indicator is set to "error" state
    Then countdown timer should be "stopped"

  @set_sensors_to_their_thresholds @TRQ-UID-907
  Scenario: When a health error occurs after successful Load Check, the instrument software shall disable the start
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    And user performs scan for all supplies "successfully"
    And user is able to start Sequencing Run
    When "instrument" health indicator is set to "error" state
    Then user should "not be" able to start Sequencing Run

  @wait_both_runs_to_be_completed @TRQ-UID-907
  Scenario: The instrument software shall provide the following run batch initiation option: allow timer to expire which triggers Start sequencing
    Given user is on screen "loadSupplies"
    And all supplies are loaded
    When user performs scan for all supplies "successfully"
    Then sequencing should start after 5 min
