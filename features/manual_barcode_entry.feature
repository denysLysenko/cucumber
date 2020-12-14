# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for Manual barcode entry integration tests                                    #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-127                                                                           #
########################################################################################################################

@all @manual-barcode-entry @MAUI-127 @regression
Feature: Manual barcode entry
  As a user, I want the ability to manually enter sequencing complex barcode, so that I have a contingency plan
  in case of a damaged barcode

  Background: User is logged in and can proceed with workflow
    * instrument user successfully logged in
    * instrument is in ready state

  @positive @reset_deck_layout
  Scenario: The instrument software shall provide guidance to enter barcode manually in case it can not be read by instrument scanner:
    - load samples screen
    - single sample tube

    Given user is on screen "loadSample"
    And the "first" sample tube is determined to be present
    When sample tube barcode is not readable for "first" tube
    And the instrument software provides an error message to the user
    Then the instrument software provides guidance to enter barcode manually

  @positive @reset_deck_layout
  Scenario: The instrument software shall allow entry of the sequencing complex side barcode manually:
    - load samples screen
    - single sample tube

    Given user is on screen "loadSample"
    And the "first" sample tube is determined to be present
    When sample tube barcode is not readable for "first" tube
    And user invoke sample tube details
    Then user is able to enter barcode manually
    And user is able to submit manually entered barcode

  @positive @reset_deck_layout
  Scenario: Sample tube is marked with warning icon if sample barcode manually entered:
    - load samples screen
    - single sample tube

    Given user is on screen "loadSample"
    And the "first" sample tube is determined to be present
    When sample tube barcode is not readable for "first" tube
    And user enters barcode manually for the "first" tube
    Then the "first" sample tube "should" be marked with warning icon

  @positive @reset_deck_layout
  Scenario: Sample tube details popup has warning message if sample barcode manually entered:
    - load samples screen
    - single sample tube

    Given user is on screen "loadSample"
    And the "first" sample tube is determined to be present
    And sample tube barcode is not readable for "first" tube
    And user enters barcode manually for the "first" tube
    And sample tube is marked with warning icon
    When user invoke sample tube details
    Then user is able to see warning message

  @positive @reset_deck_layout
  Scenario: The instrument software shall not allow user to enter barcode more than 17 character length
    Given user is on screen "loadSample"
    And the "first" sample tube is determined to be present
    When sample tube barcode is not readable for "first" tube
    And user enters barcode "E200016122000646S678953453453453" manually with "more" than '17' character length
    Then user is able to see entered barcode that equal '17' characters length

  @negative @reset_deck_layout
  Scenario: The instrument software shall not allow user to enter barcode less than 17 character length
    Given user is on screen "loadSample"
    And the "first" sample tube is determined to be present
    When sample tube barcode is not readable for "first" tube
    And user enters barcode "E200016122" manually with "less" than '17' character length
    Then instrument software should show an error that barcode should be '17' characters long

  @negative @reset_deck_layout
  Scenario: Manually entered barcode allowed only for one sample tube:
    - load samples screen
    - two sample tubes
    - two barcodes not readable

    Given user is on screen "loadSample"
    And "both" run sample tube(s) are determined to be present
    When sample tubes barcode not readable
    Then user not allowed to enter barcode manually

  @positive @reset_deck_layout
  Scenario: The instrument software shall allow manual barcode entry only for one tube:
    - load samples screen
    - two sample tubes
    - first tube barcode not readable

    Given user is on screen "loadSample"
    And "both" run sample tube(s) are determined to be present
    When sample tube barcode is not readable for "first" tube
    And sample tube barcode is readable for "second" tube
    Then user is able to enter barcode manually for "first" tube
    And user is able to submit manually entered barcode

  @positive @reset_deck_layout
  Scenario: The instrument software shall allow manual barcode entry only for one tube:
    - load samples screen
    - two sample tubes
    - second tube barcode not readable

    Given user is on screen "loadSample"
    And "both" run sample tube(s) are determined to be present
    When sample tube barcode is not readable for "second" tube
    And sample tube barcode is readable for "first" tube
    Then user is able to enter barcode manually for "second" tube
    And user is able to submit manually entered barcode

  @positive @reset_deck_layout
  Scenario: The instrument software shall allow entry of the sequencing complex side barcode manually:
    - fully loaded deck

    Given user is on screen "loadSample"
    And all supplies are loaded
    And "both" run sample tube(s) are determined to be present
    When sample tube barcode is not readable for "first" tube
    And user invoke sample tube details
    Then user is able to enter barcode manually
    And user is able to submit manually entered barcode
