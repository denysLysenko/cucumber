# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                 Feature file for manually entered barcode checksum verification integration tests                    #
#                                                                                                                      #
# User story: https://jira.gene.com/jira/browse/MAUI-126                                                               #
########################################################################################################################

@all @mb-checksum-verification @MAUI-126 @regression
Feature: Manual barcode checksum verification
  As a user, I want the verify checksum for manually entered sample tube barcode

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @positive @negative @reset_deck_layout
  Scenario Outline: The instrument software shall verify checksum according to the algorithm.
    Given user is on screen "LoadSamples"
    And the "first" sample tube is determined to be present
    And sample tube barcode is not readable for "first" tube
    When user enters barcode "<barcode>" manually for the "first" tube
    Then instrument software verifies barcode as "<result>"

    Examples:
      | barcode           | result   |
      | E200016152000625S |  valid   |
      | E200016152500625N |  valid   |
      | E206016152500625H |  valid   |
      | E2000161520006253 |  invalid |
      | E236016152500625H |  invalid |

  @negative @reset_deck_layout
  Scenario Outline: Manually entered barcode fails validation. Error is shown to the instrument user.
    Given user is on screen "LoadSamples"
    And the "first" sample tube is determined to be present
    And sample tube barcode is not readable for "first" tube
    When user enters barcode "<barcode>" manually for the "first" tube
    Then instrument software should show an error that barcode is not valid

    Examples:
      | barcode           |
      | E2000161520006253 |
      | E236016152500625H |
      | **&)youy97*&(^&*t |
