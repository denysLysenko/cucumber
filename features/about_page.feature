# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                        Feature file for About Page tests                                             #
#                                                                                                                      #
#                                                                                                                      #
########################################################################################################################

@all @about-page
Feature: About page to display Sequencing Instrument details
  As a user, I want to see additional details about my sequencing instrument to track system configuration information.

  @TRQ-UID-796 @HTPS-1759 @HTPS-1978
  Scenario Outline: The instrument software shall have an about page that is viewable by all user roles.
    Given Application UI is loaded
    And User taps on instrument UI screen to unlock it
    And User logs in as "<Username>" with password "<Password>"
    And User successfully logged in the instrument
    When User selects About from side menu
    Then User navigated to About page
    And User verifies the title of page is "About"

    Examples:
      | Username | Password |
      | Genia    | 12345678 |
      | Alice    | 12345678 |
      | Bob      | 12345678 |

  @valid-login @TRQ-UID-797 @HTPS-1759 @HTPS-1978
  Scenario: The instrument software shall indicate the instrument name and serial number on the about page.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    Then User verifies "Instrument123" as the instrument name from the About page
    And User verifies "16842752" as the instrument serial number from the About page

  @valid-login @TRQ-UID-798 @TRQ-UID-799 @HTPS-1759 @HTPS-1978
  Scenario: The instrument software shall display version information in the following format (V).(I).(S).(B) where V = version, I = Index, S = Subindex, and B = Build.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    Then User verifies Software system version format

  @valid-login @TRQ-UID-798 @TRQ-UID-802 @HTPS-1759 @HTPS-1978
  Scenario: The instrument software shall display the Software system version information.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    Then User verifies "1.0.2.3" as the Software system version on the About page

  @valid-login @TRQ-UID-798 @TRQ-UID-802 @HTPS-1759 @HTPS-1978
  Scenario: The instrument software shall display the Sequencing run methods name and version information.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    Then User verifies "Method1" version "version1" is present on About page in "1" line
    And User verifies "Method2" version "version2" is present on About page in "2" line

  @valid-login @TRQ-UID-800 @TRQ-UID-803 @HTPS-1759 @HTPS-1978
  Scenario: The instrument software shall display System license information.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    And User clicks on the System license information link on About page
    Then User confirms redirection to System license information page
    And User verifies the title of page is "System license information"
    And User clicks on the go Back arrow
    And User navigated to About page

  @valid-login @TRQ-UID-800 @TRQ-UID-803 @HTPS-1759 @HTPS-1978
  Scenario: The instrument shall display Third party end user license aggrements information.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    And User clicks on the Third party end user license agreements link on About page
    Then User confirms redirection to Third party license information page
    And User verifies the title of page is "Third party license information"
    And User clicks on the go Back arrow
    And User navigated to About page

  @valid-login @TRQ-UID-801 @HTPS-1759 @HTPS-1978
  Scenario: The instrument software shall indicate the date and time of last power on date and time.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    Then User can see the date and time of the last power on

  @valid-login @TRQ-UID-798 @TRQ-UID-802 @HTPS-1759 @HTPS-1978
  Scenario: The instrument software shall display Maintenance method name and version information.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    Then User verifies Maintenance method name is "put method name here"
    And User verifies Maintenance method version is "put method version here"

  @valid-login @TRQ-UID-804 @HTPS-1759 @HTPS-1978
  Scenario: When system configuration information cannot be retrieved, the instrument software shall report each
    unretrieved system configuration item as <<Not available>>
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      |      |            |                   |             |               |             |               |
    When User selects About from side menu
    Then User verifies "Not available" as the instrument name from the About page
    And User verifies "Not available" as the instrument serial number from the About page
    And User verifies "Not available" as the software system version on the About page
    Then User verifies "Not available" version "Not available" is present on About page in "1" line
    And User verifies "Not available" version "Not available" is present on About page in "2" line

  @valid-login @TRQ-UID-804 @HTPS-1759 @HTPS-1978
  Scenario: When system configuration information cannot be retrieved, the instrument software shall display an error
    message indicating that the system configuration information cannot be retrieved
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      |      |            |                   |             |               |             |               |
    When User selects About from side menu
    And Error occurred during About page info retrieval
    Then User verifies error message indicating that the system configuration information cannot be retrieved shown

  @manual-test @TRQ-UID-795 @valid-login @HTPS-1759 @HTPS-1978
  Scenario: The instrument software shall provide the user the ability to view the about page as read only.
    Given User successfully logged in the instrument
    And About page is set to load desired details about instrument
      | Name          | Serial No. | Software System V | Seq Method1 | Seq Method1 V | Seq Method2 | Seq Method2 V |
      | Instrument123 | 16842752   | 1.0.2.3           | Method1     | version1      | Method2     | version2      |
    When User selects About from side menu
    Then About page field "Name" is read-only type
    Then About page field "Serial number" is read-only type
    Then About page field "System license information" is link text type
    Then About page field "Third party end user information" is link text type
    Then About page field "Software system version" is read-only type
    Then About page field "Sequencing methods and version" is read-only type
