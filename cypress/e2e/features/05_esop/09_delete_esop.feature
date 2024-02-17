@PLX-3154
Feature: Delete ESOP Plan

  @ESOPSmoke @ESOPRegression
  Scenario Outline: Delete plan when no current offer created

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    And in ESOP, <Plan Name> Threedots is pressed
    And in ESOP, <Plan Name> Menuitem <Operation> is pressed
	And alert pop-up, Delete Plan, 'Confirm' is pressed
	And in ESOP, <Plan Name> is not displayed

    @TestCaseKey=PLX-T496 @DEV @TEST @run
    Examples:
      | Issuer | Company       | Plan Name           | Operation  | 
      | Owner  | IC Trading Co | CYPRESS-ESOP Delete | Delete     | 

  
  @PLX-3136
  Scenario Outline: FCX: Delete Plan - as Issuer
    Note: delete as issuer first because no rows in Past Plans table to validate
    # AC1: As an FCX admin/Issuer user with ESOP access, I should be able to delete ESOP plan if below validation are met
    # Validations:
    # * Plan status is archived
    # AC2: As an FCX admin/Issuer user with ESOP access, once plan is deleted it will not be visible anymore

    Given '<Issuer>' is logged in to FCX 'App'
    And in Company View, <Company> tile is pressed
    And company menu 'ESOP' is pressed
    When in 'Past Plans' table, 'Delete' action for row detail is selected
      | Company   | Plan Name   | Created | Archived |
      | <Company> | <Plan Name> | <Date>  | <Date>   |
    And in 'Delete Plan' pop-up, 'Confirm' button is pressed
    And alert pop-up, success, 'Plan deleted successfully' is displayed
    And progress is complete
    Then in ESOP, 'Past Plans' section, does not show row [with plan name]
      | Company   | Plan Name   | Created | Archived |
      | <Company> | <Plan Name> | <Date>  | <Date>   |

    @TestCaseKey=PLX-T289 @DEV @TEST 
    Examples:
      | Issuer | Company       | Plan Name             | Date    |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1#2 | [Today] |


  @PLX-2739
  Scenario Outline: PXAdmin: Delete Plan
    # AC1: As an FCX admin/Issuer user with ESOP access, I should be able to delete ESOP plan if below validation are met
    # Validations:
    # * Plan status is archived
    # AC2: As an FCX admin/Issuer user with ESOP access, once plan is deleted it will not be visible anymore

    Given '<Admin>' is logged in to FCX 'PXAdmin'
    And FCX Concierge menu 'ESOP' is pressed
    When in 'ESOP' table, 'Delete' action for row detail is selected
      | Company   | ESOP Pool | Plan Name   | Created | Status   |
      | <Company> |           | <Plan Name> |         | Archived |
    And  in 'Delete Plan' pop-up, 'Delete' button is pressed
    And 'ESOP' main Header is displayed
    And in 'Search', search for '<Company>'
    Then 'ESOP' table, does not display row [with plan name]
      | Company   | ESOP Pool | Plan Name   | Created | Status |
      | <Company> |           | <Plan Name> |         |        |

    @TestCaseKey=PLX-T280 @DEV @TEST 
    Examples:
      | Admin   | Company       | Plan Name                    |
      | PXAdmin | IC Trading Co | CYPRESS-ESOP 2023Q1#1updated |


  Scenario Outline: Cleanup test data
    Manual Clean up - PGSQL

	# "/* 
	# * Declarations
	# */
	# @set planName = 'CYPRESS-ESOP 2023Q1'
	# @set companyName = 'IC Trading Co'
	# @set issuerID = '5E7DAC6B-4F4D-46E9-AF80-2B403F802F44'

	# /* 
	# * Clean up
	# */
	# delete from esop_participant_offer_history 
	# where esop_participant_id in (
	# 	select id from esop_participant
	# 	--where invite_email_address like 'fcx.tester%'
	# 	where esop_offer_model_id in (
	# 		select id from esop_offer_model eom
	# 		where esop_id in ( 
	# 			select id from esop e where name like :planName  || '%' 
	# 		)
	# 	)
	# );

	# delete from esop_participant
	# -- where invite_email_address like 'fcx.tester%'
	# where esop_offer_model_id in (
	# 	select id from esop_offer_model eom
	# 	where esop_id in ( 
	# 		select id from esop e where name like :planName  || '%' 
	# 	)
	# ); 

	# delete from esop_q_and_a_document eqaad
	# where esop_document_id in (
	# 	select id from esop_document ed 
	# 	where esop_offer_model_id in (
	# 		select id from esop_offer_model eom
	# 		where esop_id in ( 
	# 			select id from esop e where name like :planName  || '%' 
	# 		)
	# 	)
	# );

	# delete from esop_document ed 
	# where esop_offer_model_id in (
	# 	select id from esop_offer_model eom
	# 	where esop_id in ( 
	# 		select id from esop e where name like :planName  || '%' 
	# 	)
	# );

	# delete from esop_document
	# where esop_offer_model_id in (
	# 	select id from esop_offer_model eom
	# 	where esop_id in ( 
	# 		select id from esop e where name like :planName  || '%' 
	# 	)
	# );

	# delete from document d 
	# where id in (select document_id from esop_document
	# 	where esop_offer_model_id in (
	# 		select id from esop_offer_model eom
	# 		where esop_id in ( 
	# 			select id from esop e where name like :planName  || '%' 
	# 		)
	# 	)
	# );

	# delete from esop_media em 
	# where esop_offer_model_id in (
	# 	select id from esop_offer_model eom
	# 	where esop_id in ( 
	# 		select id from esop e where name like :planName  || '%' 
	# 	)
	# ); 

	# delete from esop_q_and_a eqaa
	# where esop_offer_model_id in (
	# 	select id from esop_offer_model eom
	# 	where esop_id in ( 
	# 		select id from esop e where name like :planName  || '%' 
	# 	)
	# );

	# delete from esop_option 
	# where esop_offer_model_id in (
	# 	select id from esop_offer_model eom
	# 	where esop_id in ( 
	# 		select id from esop e where name like :planName  || '%' 
	# 	)
	# );

	# delete from custom_vesting_event cve 
	# where custom_vesting_strategy_id in (
	# 	select id from vesting_strategy vs 
	# 	where vs.id in (
	# 		select vesting_strategy_id from esop_offer_model eom
	# 		where esop_id in ( 
	# 			select id from esop e where name like :planName  || '%' 
	# 		)
	# 	)
	# );

	# delete from vesting_strategy vs 
	# where vs.id in (
	# 	select vesting_strategy_id from esop_offer_model eom
	# 	where esop_id in ( 
	# 		select id from esop e where name like :planName  || '%' 
	# 	)
	# );

	# delete from esop_offer_model eom
	# where esop_id in ( 
	# 	select id from esop e where name like :planName  || '%' 
	# );

	# --select *  from esop e where name like :planName || '%' ;
	# delete from esop e where name like :planName  || '%'  ; 
	# -- delete from esop e where name = '<Plan Name>';

	# update issuer
	# set esop_pool_size = null
	# --select * 
	# --from issuer i
	# --left join users u on u.id = i.user_id
	# where esop_pool_size = 9000
	# and user_id = :issuerID;
	# "

    Examples:
      | Issuer | Company       | Plan Name           | Description              |
      | Owner  | IC Trading Co | CYPRESS-ESOP 2023Q1 | CYPRESS-ESOP 2023Q1 - #1 |
