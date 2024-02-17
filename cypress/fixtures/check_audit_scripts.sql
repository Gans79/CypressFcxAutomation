/*  
 *  Get Cap raise details
 */
select cra.item_type , u.first_name , u.last_name, cr."label", cra."action"  
from cap_raise_audit cra
 join users u on u.id = cra.user_id
 join cap_raise cr on cr.id = cra.item_id
--where u.first_name = 'Ian'
 where
 item_type = 'CAP_RAISE'
and  label like 'Ordinary Shares - Raise #%'
;	

/*  
 *  Get Cap raise documents details
 */
select /*distinct*/ cra.item_type , u.first_name , u.last_name, cr.label, crd.cap_raise_document_type, d.filename, d.description, crd."version" , d.storage_id 
from cap_raise_audit cra
 join users u on u.id = cra.user_id
 join cap_raise_document crd on crd.id = cra.item_id
 join cap_raise cr on cr.id = crd.cap_raise_id
 join "document" d on crd.document_id =d.id
where
 item_type = 'CAP_RAISE_DOCUMENT'
and	u.id in (select u.id  
from legal_entity le 
left outer join users u on u.id = le.id
where email_address like 'fcx.tester%'
or email_address like 'ian.chew%' 
or name like 'IC%')
--where u.first_name = 'Ian'
-- where 
-- label like 'Ordinary Shares - Raise #%'
;	


/*  
 *  Get Cap raise media details
 */
select /*distinct*/ cra.item_type , u.first_name , u.last_name, cr.label, crm.cap_raise_media_type, crm.title, crm.url, crm."version" 
from cap_raise_audit cra
 join users u on u.id = cra.user_id
 join cap_raise_media crm on crm.id = cra.item_id
 join cap_raise cr on cr.id = crm.cap_raise_id
where
 item_type = 'CAP_RAISE_MEDIA'
and	u.id in (select u.id  
from legal_entity le 
left outer join users u on u.id = le.id
where email_address like 'fcx.tester%'
or email_address like 'ian.chew%' 
or name like 'IC%')
;	

/*  
 *  Get Cap raise media details
 */
select /*distinct*/ cra.item_type , u.first_name , u.last_name, cr.label, crqaa.*,crqaad.*
from cap_raise_audit cra
 join users u on u.id = cra.user_id
 join cap_raise_q_and_a crqaa on crqaa.id = cra.item_id
 left outer join cap_raise_q_and_a_document crqaad on crqaad.cap_raise_q_and_a_id = crqaa.id
 join cap_raise cr on cr.id = crqaa.cap_raise_id
where
 item_type = 'CAP_RAISE_Q_AND_A'
and	u.id in (select u.id  
from legal_entity le 
left outer join users u on u.id = le.id
where email_address like 'fcx.tester%'
or email_address like 'ian.chew%' 
or name like 'IC%')
;	

select * from cap_raise_q_and_a_document crqaad 
;


select distinct item_type 
from cap_raise_audit cra;
/* 
 * Results
 */
/*
CAP_RAISE
CAP_RAISE_Q_AND_A
CAP_RAISE_BIDS
CAP_RAISE_DOCUMENT
CAP_RAISE_MEDIA
*/

/*  
 *  Get Cap raise details
 */
select cra.item_type , u.first_name , u.last_name 
from cap_raise_audit cra
left outer join users u on u.id = cra.user_id
-- where 
-- label like 'Ordinary Shares - Raise #%'
;	

select * from issuer i 
join users u on u.id = i.user_id
where u.email_address_verified like 'fcx.test%';

select le.id, le.name, le.email_address, u.first_name, u.last_name  
from legal_entity le 
left outer join users u on u.id = le.id
where email_address like 'fcx.tester%'
or email_address like 'ian.chew%' 
or name like 'IC%';

select * from legal_entity le 
where name like 'IC%';

select * from users u
where first_name like 'Ian' or first_name like 'Test';


select * from entity_member_company emc ;

select * from entity_member_individual emi ;


/*
 * 
 */
u3dl545meok6m1ijklg9c2dam6
ju7gnv31bk60jfelorh30989o5
hal9jtid50arogne6g824us254
3qcgie5db71u4anlkob499ehp7
*/