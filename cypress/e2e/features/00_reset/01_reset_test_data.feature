@PLX-3062
Feature: Test Data Management - Cleanup and reset test data for testing

  @PLX-3688
  Scenario Outline: reset test data

    @CompanySmoke @CompanyRegression @DEV @TEST @run  
    Scenario: To validate cleanup Company data 
     Given I initiate a "POST" cleanup request with the following data 
     | status_code | req_body | 
     | 200         | {"method": "cleanupData","params":[{"types":["1"], "namePattern":"CYPRESS-FCX Trading"}]} | 

    @WalletSmoke @WalletRegression  @DEV @TEST @run  
    Scenario: To validate cleanup Wallet data 
     Given I initiate a "POST" cleanup request with the following data 
     | status_code | req_body | 
     | 200         | {"method": "cleanupData","params":[{"types":["3"], "namePattern":"FCX INVESTOR"}]} | 

    @ESOPSmoke @ESOPRegression @DEV @TEST @run
    Scenario: To validate cleanup ESOP documents
      Given I initiate a "POST" cleanup request with the following data
      |	status_code | req_body			                                                                  |
      |	200	        |	{"method": "deleteCypressUploadedESOPDocuments","params":[{"label":"CYPRESS"}]}	|

    @ESOPSmoke @ESOPRegression @DEV @TEST @run 
    Scenario: To validate cleanup ESOP data
      Given I initiate a "POST" cleanup request with the following data
      | status_code | req_body                                                                |
      |	200         | {"method": "cleanupESOPData","params":[{"planNamePattern":"CYPRESS"}]}	|

    @CompanySmoke @ESOPRegression @TEST @DEV @run
    Scenario: To validate cleanup Investor data
      Given I initiate a "POST" cleanup request with the following data
      |	status_code |	req_body	                                                                                                                                                                                                              |
      |	200     	  |	{"method": "cleanupInvestorData","params":[{"emails":["fcx.dev.tester+owner@finclear.com.au@fcx.com.au"]}]}	|


    @CapRaiseSmoke @CapRaiseRegression @DEV @TEST @run  
    Scenario: To validate cleanup Cap Raise data 
     Given I initiate a "POST" cleanup request with the following data 
     | status_code | req_body | 
     | 200         | {"method": "cleanupData","params":[{"types":["4"], "name":"Primary Cap Raise"}]} | 