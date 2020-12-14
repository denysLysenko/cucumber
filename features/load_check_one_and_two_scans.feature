########################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for Load Check one and two scans                                              #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-401                                                                           #
# https://jira.gene.com/jira/browse/MAUI-400                                                                           #
########################################################################################################################

@all @load-check-one-and-two-scans @regression
Feature: Load Check: one and two scans
  As a user I want to load instrument with all required supplies at once, so that instrument is ready for the sequencing run.
  As a user I want to load instrument with sample(s) first and load the rest of required supplies based on sample(s) scanning results,
    so that instrument is ready for the sequencing run.

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @MAUI-401
  Scenario: Perform Load Check with all required supplies at once
    Given user is on screen "loadSamples"
    When user loads "valid" samples tube(s) along with all supplies
    And user starts Load Check
    Then the instrument software should perform validation of all loaded supplies "successfully"
    And user should "be" able to start Sequencing Run

  @MAUI-400
  Scenario: Perform Load Check for supplies when sample tubes have been scanned successfully
    Given user is on screen "loadSupplies"
    And validation of sample tubes successfully passed
    When user loads "valid" supplies
    And user starts Load Check
    Then the instrument software should perform validation of all loaded supplies "successfully"
    And user should "be" able to start Sequencing Run
