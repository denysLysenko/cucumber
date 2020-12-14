# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                Feature file for system reagent validation tests                                      #
#                                                                                                                      #
#   https://jira.gene.com/jira/browse/MAUI-305                                                                         #
#                                                                                                                      #
########################################################################################################################

@all @system-reagent-validation @MAUI-305
Feature: As a user, I want the system to check the validity of loaded system reagent container,
         so that I can take corrective actions before starting a run.

  Scenario: Pre-conditions
    * instrument user successfully logged in
    * assay specific method determined


  @positive
  Scenario: Perform validation for system reagent:
    valid bottle:
      - sufficient volume
      - compatible
      - not expired
      - readable barcode
    Given "valid" system reagent and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "system_reagent" has "no" errors
    And user can proceed with workflow

  @positive
  Scenario: System shall show status of the available volume for system reagent:
    valid bottle:
      - sufficient volume
      - compatible
      - not expired
      - readable barcode
    Given "valid" system reagent and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "system_reagent" status of the available volume relative to the estimated fluid usage

  @positive
  Scenario: System shall set on-board stability expiration for system reagent:
    valid bottle:
      - sufficient volume
      - compatible
      - not expired
      - readable barcode
      - new, never used bottle
    Given "new" system reagent and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then system shall record first used date and set on-board stability expiration

  @negative
  Scenario: Perform validation for system reagent:
      - not readable barcode
    Given "not_readable_barcode" system reagent and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "system_reagent" has "barcode" errors
    And user can not proceed with workflow

  @negative
  Scenario: Perform validation for system reagent:
      - not compatible
    Given "not_compatible" system reagent and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "system_reagent" has "not_compatible" errors
    And user can not proceed with workflow

  @negative
  Scenario: Perform validation for system reagent:
      - expired(shelf and on-board)
    Given "expired" system reagent and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "system_reagent" has "expired" errors
    And user can not proceed with workflow

  @negative
  Scenario: Perform validation for system reagent:
      - not enough volume
    Given "not_enough_volume" system reagent and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "system_reagent" has "not_enough_volume" errors
    And user can not proceed with workflow

  @negative
  Scenario: Perform validation for system reagent:
     - no system reagent bottle present
    Given "no" system reagent and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "system_reagent" has to be loaded
    And user can not proceed with workflow
    
  @negative
  Scenario: Perform live monitoring for system reagent container:
    Given "valid" system reagent container is loaded
    And the instrument software UI show "system_reagent" is loaded
    When system reagent container is removed
    Then the instrument software UI show "system_reagent" has to be loaded
    And user can not proceed with workflow
