# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for Manual barcode entry flag integration tests                               #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-347                                                                           #
########################################################################################################################

@all @manual-barcode-entry-flag @MAUI-347 @regression
Feature: Manual barcode entry flag

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @positive @reset_deck_layout
  Scenario Outline: Sample tube shall be marked with warning icon flag if sample tube barcode manually entered
    Given user is on screen "loadSample"
    And the "<runNumber>" sample tube is determined to be present
    When sample tube barcode is not readable for "<runNumber>" tube
    And user enters barcode manually for the "<runNumber>" tube
    Then the "<runNumber>" sample tube "should" be marked with warning icon

    Examples:
      | runNumber |
      | first     |
      | second    |

  @positive @reset_deck_layout @wait_both_runs_to_be_completed
  Scenario Outline: The <runNumber> Sequencing Run shall be marked with warning flag if sample tube barcode manually entered
    Given user is on screen "loadSample"
    And the "<runNumber>" sample tube is determined to be present
    And sample tube barcode is not readable for "<runNumber>" tube
    And user enters barcode manually for the "<runNumber>" tube
    When user starts Sequencing using tube with manually entered barcode
    Then the "<runNumber>" sequencing Run should be marked with warning flag

    Examples:
      | runNumber |
      | first     |
      | second    |

  @positive @reset_deck_layout
  Scenario Outline: Sample tube shouldn't be marked with warning icon flag if scanned barcode matches manually entered barcode
    Given user is on screen "loadSample"
    And the "<runNumber>" sample tube is determined to be present
    And sample tube barcode is not readable for "<runNumber>" tube
    And user enters barcode manually for the "<runNumber>" tube
    When sequencing instrument scans the "<runNumber>" tube barcode and it "matches" the manually entered barcode
    Then instrument software "shouldn't" warn a user that the "<runNumber>" sample tube were replaced
    And the "<runNumber>" sample tube "shouldn't" be marked with warning icon

    Examples:
      | runNumber |
      | first     |
      | second    |

  @positive @reset_deck_layout
  Scenario Outline: The instrument software shall warn a user that sample tube were replaced in case if scanned barcode doesn't match manually entered barcode
    Given user is on screen "loadSample"
    And the "<runNumber>" sample tube is determined to be present
    And sample tube barcode is not readable for "<runNumber>" tube
    And user enters barcode manually for the "<runNumber>" tube
    When sequencing instrument scans the "<runNumber>" tube barcode and it "doesn't match" the manually entered barcode
    Then instrument software "should" warn a user that the "<runNumber>" sample tube were replaced
    And allow user to 'Continue' or 'Cancel' workflow
    And the "<runNumber>" sample tube "shouldn't" be marked with warning icon

    Examples:
      | runNumber |
      | first     |
      | second    |
