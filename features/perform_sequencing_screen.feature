# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for perform sequencing and flags during run tests                             #
#   https://jira.gene.com/jira/browse/MAUI-97                                                                          #
#   https://jira.gene.com/jira/browse/MAUI-152                                                                         #
#                                                                                                                      #
########################################################################################################################


@all @perform-sequencing-screen
Feature: The instrument software shall display the following run information on the sequencing status screen:
          - Run ID
          - Run status (Stopped, Failed, Completed, Cancelled, Performing Sequencing, Pending)
          - Run started by
          - Run protocol
          - Sequencing Complex ID
          - End of run completion date and time/Expected End of run completion Date and Time
          - Any Flags associated with a run

  @MAUI-97
  Scenario: All items are shown on sequencing screen. Without flags.
    Given Sequencing run successfully started
    Then All run information items are shown on the sequencing status screen
      | run_info_item         |
      | run_id                |
      | run_status            |
      | started_by            |
      | run_protocol          |
      | sequencing_complex_id |
      | eor_completion_date   |

  @MAUI-152
  Scenario Outline: Sequencing status screen should show flags if any. Warning flags.
    Given Sequencing run successfully started
    And "<Flaggable_warning_event>" occurred in the instrument
    When Sequencing run is finished
    Then Sequencing status screen should show "<Flaggable_warning_events>"

    Examples:
      | Flaggable_warning_event                                                                 |
      | {event_have_to_be_determined, event_have_to_be_determined}                              |
      | {event_have_to_be_determined, event_have_to_be_determined, event_have_to_be_determined} |
      | {event_have_to_be_determined}                                                           |

  @MAUI-152
  Scenario Outline: Sequencing status screen should show flags if any. Error flags.
    Given Sequencing run successfully started
    And "<Flaggable_error_event>" occurred in the instrument
    When Sequencing run is failed
    Then Sequencing status screen should show "<Flaggable_error_event>"

    Examples:
      | Flaggable_error_event         |
      | {event_have_to_be_determined} |
      | {event_have_to_be_determined} |
      | {event_have_to_be_determined} |
      | {event_have_to_be_determined} |
      | {event_have_to_be_determined} |

  @MAUI-97
  Scenario: Sequencing status screen should show run statuses as "Run stopped"
    Given Sequencing run successfully started
    And User stops the run
    When Sequencing run is stopped
    Then Sequencing status screen should show "Run stopped"

  @MAUI-97
  Scenario: Sequencing status screen should show run statuses as "Run failed"
    Given Sequencing run successfully started
    When Sequencing run is failed
    Then Sequencing status screen should show "Run failed"

  @MAUI-97
  Scenario: Sequencing status screen should show run statuses as "Run complete"
    Given Sequencing run successfully started
    When Sequencing run is finished
    Then Sequencing status screen should show "Run complete"

  @MAUI-97
  Scenario: Sequencing status screen should show run statuses as "Run cancelled"
            - Performing Sequencing
            - Pending
    Given Sequencing run successfully started
    When Sequencing run is cancelled
    Then Sequencing status screen should show "Run cancelled"

  @MAUI-97
  Scenario: Sequencing status screen should show run statuses as "Performing Sequencing" and "Pending".
            Pre-requisite: Should be tested with two runs in the batch.
    Given Two sequencing runs started back to back
    When First sequencing run successfully started
    Then Sequencing status screen should show "Performing Sequencing" for "first" run
    And Sequencing status screen should show "Pending" for "second" run

  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct name of user who started the run. Manually started.
    When Sequencing run successfully started by "<user_name>"
    Then Perform sequencing screen show correct username as "<user_name>"

    Examples:
      | user_name |
      | Alice     |
      | Genia     |
      | Bob       |

  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct name of user who started the run. Auto-start.
    Given User logged in with "<user_name>" username
    And All loaded items passed scanning
    And Auto-start timer tarted
    And User is logged out
    When Sequencing run successfully started
    Then Perform sequencing screen show correct username as "<user_name>"

    Examples:
      | user_name |
      | Alice     |
      | Genia     |
      | Bob       |

  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct name of user who started the run. Auto-start.
    Given User logged in with "<user_name>" username
    And All loaded items passed scanning
    And Auto-start timer tarted
    When Sequencing run successfully started
    Then Perform sequencing screen show correct username as "<user_name>"

    Examples:
      | user_name |
      | Alice     |
      | Genia     |
      | Bob       |

  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct name of user who started the run. Auto-start.
    Given All loaded items passed scanning
    And Auto-start timer tarted
    And User is logged out
    And New user logged in as <user_name>
    When Sequencing run successfully started
    Then Perform sequencing screen show correct username as "<user_name>"

    Examples:
      | user_name |
      | George    |
      | Dania     |
      | Alena     |

  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct protocol name
    When Sequencing run successfully started with complex that uses "<protocol_name>"
    Then Perform sequencing screen show correct username as "<protocol_name>"

    Examples:
      | protocol_name |
      | NIPT          |
      | CS            |


  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct estimated EOR time
    When Sequencing run successfully started with complex that uses "<protocol_name>"
    Then Perform sequencing screen shall show correct estimated EOR time for "<protocol_name>"

    Examples:
      | protocol_name |
      | NIPT          |
      | CS            |

  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct EOR time
    Given Sequencing run successfully started with complex that uses "<protocol_name>"
    When Sequencing run is finished
    Then Perform sequencing screen shall show correct EOR time for "<protocol_name>"

    Examples:
      | protocol_name |
      | NIPT          |
      | CS            |


  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct run ID
    When Sequencing run successfully started with complex tube ID "<complex_id>"
    Then Perform sequencing screen shall show correct run ID for "<complex_id>" complex tube

    Examples:
      | complex_id |
      | 1234_abc   |
      | 5678_def   |

  @MAUI-97
  Scenario Outline: Perform sequencing screen shall show correct run ID
    When Sequencing run successfully started with complex tube ID "<complex_id>"
    Then Perform sequencing screen shall show correct complex ID for complex tube "<complex_id>"

    Examples:
      | complex_id |
      | 1234_abc   |
      | 5678_def   |
      | abc_1234   |
      | def_5678   |

