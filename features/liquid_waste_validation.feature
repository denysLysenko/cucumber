# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                Feature file for liquid waste validation tests                                        #
#                                                                                                                      #
#   https://jira.gene.com/jira/browse/MAUI-338                                                                         #
#                                                                                                                      #
########################################################################################################################

@all @liquid-waste-validation @MAUI-338
Feature: As a user, I want the system to check the validity of loaded waste container, so that I can take corrective
  actions before starting a run.

  Scenario: Pre-conditions
    * instrument user successfully logged in
    * assay specific method determined
    * user is on load supplies screen


  @positive
  Scenario: Perform validation for liquid waste container:
    valid bottle:
      - sufficient volume
      - compatible
      - readable barcode
    Given "valid" liquid waste container and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "liquid_waste_container" has "no" errors
    And user can proceed with workflow

  @positive
  Scenario: System shall show status of the available volume for liquid waste container:
    valid bottle:
      - sufficient volume
      - compatible
      - readable barcode
    Given "valid" liquid waste container and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "liquid_waste_container" status of the available volume relative to the estimated usage

  @negative
  Scenario: Perform validation for liquid waste container:
      - not readable barcode
    Given "not_readable_barcode" liquid waste container and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "liquid_waste_container" has "barcode" errors
    And user can not proceed with workflow

  @negative
  Scenario: Perform validation for liquid waste container:
      - incorrect type
    Given "not_compatible" liquid waste container and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "liquid_waste_container" has "incorrect_type" errors
    And user can not proceed with workflow

  @negative
  Scenario: Perform validation for liquid waste container:
      - not enough volume
    Given "not_enough_volume" liquid waste container and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "liquid_waste_container" has "not_enough_volume" errors
    And user can not proceed with workflow

  @negative
  Scenario: Perform validation for liquid waste container:
      - no liquid waste container present
    Given "no" liquid waste container and necessary supplies are loaded
    When scanning of the deck is triggered and finished
    Then the instrument software UI show "liquid_waste_container" has to be loaded error
    And user can not proceed with workflow

  @negative
  Scenario: Perform live monitoring for liquid waste container:
    Given "valid" liquid waste container is loaded
    And the instrument software UI show "liquid_waste_container" is loaded
    When liquid container is removed
    Then the instrument software UI show "liquid_waste_container" has to be loaded
    And user can not proceed with workflow
