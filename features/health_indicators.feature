# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for Health indicator tests                                                    #
#                                                                                                                      #
# https://jira.gene.com/jira/browse/MAUI-228                                                                           #
# https://jira.gene.com/jira/browse/MAUI-1212                                                                          #
########################################################################################################################

@all @health-indicators @MAUI-228 @MAUI-1212 @regression
Feature: Instrument Health Indicators
  As a user, I want an at-a-glance view of instrument health indicators, so that I can assess overall instrument health.
  As a lab operator, I want to see the status of the instrument so that I can troubleshoot and prevent instrument from failing.

  Background: User is logged in to the instrument
    * instrument user successfully logged in

  @TRQ-UID-833
  Scenario: The instrument software shall display a Summary Health Indicator reflecting the overall status of the four Health Indicators in healthy state.
    Given instrument is in ready state
    Then user should verify a Summary Health Indicator status is "healthy"

  @TRQ-UID-833 @set_sensors_to_their_thresholds
  Scenario Outline: The instrument software shall display a Summary Health Indicator reflecting the status of the Instrument Health Indicator
    Given instrument is in ready state
    When "instrument" health indicator is set to "<state>" state
    Then user should verify a Summary Health Indicator status is "<state>"
    And user verifies "instrument" health indicator is in "<state>" state

    Examples:
      | state   |
      | error   |
      | warning |
      | healthy |

  @TRQ-UID-833 @turn_on_connect_stub
  Scenario Outline: The instrument software shall display a Summary Health Indicator reflecting the status of the Connectivity Health Indicator
    Given instrument is in ready state
    When "connectivity" health indicator is set to "<state>" state
    Then user should verify a Summary Health Indicator status is "<state>"
    And user verifies "connectivity" health indicator is in "<state>" state

    Examples:
      | state   |
      | error   |
      | healthy |

  @TRQ-UID-833 @turn_on_connect_stub @wait_both_runs_to_be_completed
  Scenario: The instrument software shall display a Summary Health Indicator reflecting the status of the Connectivity Health Indicator
    Given instrument is in ready state
    And user starts Load Check
    And user starts Sequencing
    And instrument is in processing state
    When "connectivity" health indicator is set to "warning" state
    Then user should verify a Summary Health Indicator status is "warning"
    And user verifies "connectivity" health indicator is in "warning" state

  @TRQ-UID-833
  Scenario Outline: The instrument software shall display a Summary Health Indicator reflecting the status of the Maintenance Health Indicator
    Given instrument is in ready state
    When "maintenance" health indicator is set to "<state>" state
    Then user should verify a Summary Health Indicator status is "<state>"
    And user verifies "maintenance" health indicator is in "<state>" state

    Examples:
      | state   |
      | healthy |

  @TRQ-UID-833 @set_sensors_to_their_thresholds
  Scenario Outline: The instrument software shall display a Summary Health Indicator reflecting the status of the Storage Health Indicator
    Given instrument is in ready state
    When "storage" health indicator is set to "<state>" state
    Then user should verify a Summary Health Indicator status is "<state>"
    And user verifies "storage" health indicator is in "<state>" state

    Examples:
      | state   |
      | error   |
      | warning |
      | healthy |

  @TRQ-UID-835 @set_sensors_to_their_thresholds
  Scenario Outline: The instrument software shall have precedence of Errors over the Warning for displaying detail Health Indicator
    Given "<healthIndicatorName>" health indicator is set to "warning" state
    When "<healthIndicatorName>" health indicator is set to "error" state
    Then user verifies "<healthIndicatorName>" health indicator is in "error" state

    Examples:
      | healthIndicatorName |
      | instrument          |
      | storage             |

  @TRQ-UID-835 @set_sensors_to_their_thresholds
  Scenario Outline: The instrument software shall provide the ability to access additional information for Instrument Health Indicator
    Given "instrument" health indicator is set to "<state>" state
    When user invokes "instrument" health indicator details
    Then user verifies the health indicator details message is "<message>"
    And health indicator details message states is "<state>"

    Examples:
      | state   |                                      message                                        |
      | warning | Reagent cold block temperature is in warning state Temperature is in warning state. |
      | error   | Reagent cold block temperature is in error state Temperature is in error state.     |

  @TRQ-UID-835 @turn_on_connect_stub
  Scenario: The instrument software shall provide the ability to access additional information for Connectivity Health Indicator
    Given "connectivity" health indicator is set to "error" state
    When user invokes "connectivity" health indicator details
    Then user verifies the health indicator details message is "Network connectivity error."
    And health indicator details message states is "error"

  @TRQ-UID-833 @turn_on_connect_stub @wait_both_runs_to_be_completed
  Scenario: The instrument software shall provide the ability to access additional information for Connectivity Health Indicator
    Given instrument is in ready state
    And user starts Load Check
    And user starts Sequencing
    And instrument is in processing state
    Given "connectivity" health indicator is set to "warning" state
    When user invokes "connectivity" health indicator details
    Then user verifies the health indicator details message is "Network connectivity error."
    And health indicator details message states is "warning"

  @TRQ-UID-835 @set_sensors_to_their_thresholds
  Scenario Outline: The instrument software shall provide the ability to access additional information for Storage Health Indicator
    Given "storage" health indicator is set to "<state>" state
    When user invokes "storage" health indicator details
    Then user verifies the health indicator details message is "<message>"
    And health indicator details message states is "<state>"

    Examples:
      | state   |                                                   message                                                               |
      | warning | Storage is almost full.                                                                                                 |
      | error   | Storage is either full or inaccessible. Please try after some time. If you continue to see this, contact administrator. |
