# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for complex valid combination check                                           #
#                                                                                                                      #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-125                                                                           #
########################################################################################################################

@all @complex-valid-combination-check @MAUI-125 @regression
Feature: Complex valid combination check

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @wait_both_runs_to_be_completed
  Scenario: The instrument software shall perform two runs if two sample tubes were loaded to the instrument
    Given user is on screen "LoadSamples"
    And "both" run sample tube(s) are determined to be present
    And all supplies are loaded
    When user performs scan for all supplies "successfully"
    And user starts Sequencing
    Then "two runs" should be performed by the instrument

  @reset_stub_responses_to_default @wait_first_run_to_be_completed
  Scenario: The instrument software shall perform only one run if only first run sample tube was loaded to the instrument
    Given user is on screen "LoadSamples"
    And "first" run sample tube(s) are determined to be present
    And "second" run tube are determined to be not present
    And all supplies are loaded
    When user performs scan for all supplies "successfully"
    And user starts Sequencing
    Then "one run" should be performed by the instrument

  @reset_stub_responses_to_default
  Scenario: The instrument software shall not scan second run reagents if only first run sample tube was loaded to the instrument
    Given user is on screen "LoadSamples"
    And "first" run sample tube(s) are determined to be present
    And "second" run tube are determined to be not present
    And all supplies are loaded
    When user performs scan for all supplies "successfully"
    Then user should verify that second run reagents were not scanned by the instrument
