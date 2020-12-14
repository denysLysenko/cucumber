# ######################################################################################################################
#                                                                                                                      #
#                                                                                                                      #
#                                        Feature file for smoke check tests                                            #
#                                                                                                                      #
#                                                                                                                      #
########################################################################################################################

@smoke-check
Feature: Quick check for build to determine all components work well as integrated
  Scenario: Run through main pages to verify expected workflow
    * application UI is loaded
    * user logs in with valid credentials
    * instrument software UI shall display the "Genia" as authenticated user
    * user should be "logged in"

    * user selects About from user menu
    * user navigated to About page
    * user verifies the title of page is "About"
    * user clicks on the go back arrow
    * user navigated to Load samples page

    * instrument is in ready state
    * user clicks on Scan button
    * user waits for scanning to complete
    * user clicks on Start sequencing button
    * user verifies relocation to sequencing run start page
    * wait for "first" sequencing run step status changed to "Performing sequencing"
    * wait for "first" sequencing run step status changed to "Run complete"
    * wait for "second" sequencing run step status changed to "Performing sequencing"
    * wait for "second" sequencing run step status changed to "Run complete"
    * user clicks on Next button to proceed to unload page
    * user navigated to Unload page
    * user clicks on Done button at unload instrument page
    * user navigated to Load samples page
