# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                           Feature file for Generic Login integration tests                                           #
#                                                                                                                      #
#  HTPS-335 -> User story                                                                                              #
#  PRQ-162                                                                                                             #
#  PRQ-167                                                                                                             #
#  PRQ-168                                                                                                             #
#  PRQ-169                                                                                                             #
#  PRQ-170                                                                                                             #
########################################################################################################################

@all
@login

Feature: As a user, I want to authenticate my user credentials in order to access the system

  @TRQ-UID-774
  Scenario: The instrument software shall prompt the user to enter a username and password on the login screen.
    Given Application UI is loaded
    When User taps on instrument UI screen to unlock it
    Then User is prompted with login dialog to input username and password

  @TRQ-UID-775
  Scenario: When the user submits authentication credentials, the instrument software shall provide authentication credentials to the Connecting Software for verification.
    Given Application UI is loaded
    And User taps on instrument UI screen to unlock it
    When User logs in as "Genia" with password "12345678"
    Then User should be "logged in"

  @TRQ-UID-777 @TRQ-UID-778 @TRQ-UID-780
  Scenario Outline: When a user with a Lab Operator/Lab Manager/RSR role is authenticated, the instrument software shall provide access to
                    workflow and permissions to the user as defined by the instrument configuration.
    Given Application UI is loaded
    And User taps on instrument UI screen to unlock it
    When User logs in as "<username>" with password "<password>"
    Then User should be "logged in"
    And User will have permission "<permission_type>"

    Examples:
     | username | password | permission_type      |
     | Alice    | 12345678 | operator permissions |
     | Genia    | 12345678 | manager permissions  |
     | Bob      | 12345678 | RSR permissions      |

  @TRQ-UID-779
  Scenario Outline: While a user is successfully authenticated, the instrument software shall display the username of the authenticated user.
    Given Application UI is loaded
    And User taps on instrument UI screen to unlock it
    When User logs in as "<username>" with password "<password>"
    Then Instrument software shall display the "<Username>" as authenticated user

    Examples:
      | username | password |
      | Genia    | 12345678 |
      | Alice    | 12345678 |

  @TRQ-UID-781
  Scenario Outline: When an invalid authentication credentials message is received from the Connecting software, the instrument software shall:
                    - Provide the user an error indicating the credential is invalid
                    - Require the user to re-enter the username and password
    Given Application UI is loaded
    And User taps on instrument UI screen to unlock it
    When User logs in as "<username>" with password "<password>"
    Then Instrument software shall provide error "You have entered an invalid username or password"
    And Input fields gets reset to blank for new input
    # DO WE HAVE REQUIREMENTS FOR LOGIN NAME AND PASSWORD (LENGTH, CHARACTERS, ALPHANUMERIC, SPECIAL CHARS)?
    Examples:
      | username   | password   |
      | Genia      | wrong_pass |
      | wrong_name | 12345678   |

  @TRQ-UID-782
  Scenario Outline: The instrument software shall capture all attempted logins and the results of these attempts in the audit log.
    Given Application UI is loaded
    And User taps on instrument UI screen to unlock it
    When User logs in as "<username>" with password "<password>"
    Then User last activity that is written to Audit log is "<audit_log_entry>"

    Examples:
      | username           | password         | audit_log_entry       |
      | Genia              | 12345678         | Authenticated         |
      | Alice              | 12345678         | Authenticated         |
      | Genia              | Invalid Password | Failed authentication |
      | Invalid login name | 12345678         | Failed authentication |

  @TRQ-UID-782 @valid-login
  Scenario: The instrument software shall capture all attempted logouts and the results of these attempts in the audit log.
            - As a user, I want to logout from the system when work is finished

    Given User should be "logged in"
    When User selects logout
    Then User should be "logged out"
    And User last activity that is written to Audit log is "Logged out"

  @TRQ-UID-782 @valid-login @auto-logout
  Scenario: The instrument software shall capture all attempted logins and the results of these attempts in the audit log.
            - auto logout

    Given User should be "logged in"
    When Wait for "25" minutes
    Then User should be "logged out"
    And User last activity that is written to Audit log is "Logged out due to inactivity"

  @TRQ-UID-784 @valid-login @re-establish-connection
  Scenario: The instrument software shall capture connection errors while authenticating in the system log
            - No user can login when network connectivity is lost and credential data is not cached
    Given User should be "logged in"
    And Connection with connect is "off"
    And Instrument software indicator show connection is lost
    And User selects logout
    And User should be "logged out"
    When User taps on instrument UI screen to unlock it
    And User logs in as "Alice" with password "12345678"
    Then Instrument software shall provide error "No network connectivity. Try again or contact your system administrator for support"
    And Last activity that is written to System log is "Network connectivity error"

#  @turn_on_connect_stub
#  @TRQ-UID-784
#  @valid-login
#  Scenario: The instrument software shall capture connection errors while authenticating in the system log
#    - Authenticate credentials against cached user credentials.
#    (Using credentials that were cached in the beginning of test and not purged yet)
#
#    Given User should be "logged in"
#    And User checks instrument health status is "healthy"
#
#    When Connect stub is turned "off"
#    And User waits for health status button to be in "warning" state
#    And Wait for "5" minutes
#    And User selects logout
#    Then User should be "logged out"
#    When User taps on instrument UI screen to unlock it
#    And User logs in as "Genia" with password "12345678"
#    Then User should be "logged in"
#    And Last activity that is written to System log is "Network connectivity error"
#




#  TRQ UID {3293} (Authentication.SupportUserRoles) The instrument software shall support the following user account roles: > S6
#
#  Lab Operator
#  Lab Manager
#  Roche Service Representative * > S6
