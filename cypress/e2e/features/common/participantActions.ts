import { DataTable, When, Then } from "@badeball/cypress-cucumber-preprocessor";
import { convertTestDate, convertToCamelCase } from '../../../support/utils';
import '../../../support/commands'
import { replaceDateExpression, convertDateToDD_Mon_YYYY } from "../../../support/utils";

When(`inside Participant Offers, {} tile is pressed`, (text: string) => {
  cy.get(`label:contains('${text}')`).first().click();
});

When(`inside Participant Offer, '{}' tab is pressed`, (text: string) => {
  switch (text.toLowerCase()) {
    case "my offer":
      cy.get(`[role="tab"][id="esop-offer-tab-0"]:contains('${text}')`).click()
      break;
    case "details":
      cy.get(`[role="tab"][id="esop-offer-tab-1"]:contains('${text}')`).click()
      break;
    case "documents & media":
        cy.get(`[role="tab"][id="esop-offer-tab-2"]:contains('${text}')`).click()
        break;
    case "q & a":
        cy.get(`[role="tab"][id="esop-offer-tab-3"]:contains('${text}')`).click()
        break;
    default:
      throw new Error(text + " type is not found");
  }
});

When(`inside My Wallets, '{}' tab is pressed`, (text: string) => {
  switch (text.toLowerCase()) {
    case "holdings in wallet":
      cy.get(`[role="tab"][id="holding-tab-0"]:contains('${text}')`).click()
      break;
    default:
      throw new Error(text + " type is not found");
  }
});


When(`{}, click on view your invite from email for {}`, (user:string, identifier: string) => {
  switch (user.toLowerCase()) {
    case 'esop participant':
      cy.intercept('POST','**/api/v1/invite**').as('invite');
      cy.visit(`${Cypress.env("APP_DOMAIN")}api/invite?token=${Cypress.env("INVITE_TOKEN" + identifier)}`);
      cy.wait('@invite')
      break;
    case 'company owner' :
      cy.log(Cypress.env("INVITE_TOKEN_OWNER" + identifier))
      cy.visit(`${Cypress.env("APP_DOMAIN")}api/invite?token=${Cypress.env("INVITE_TOKEN_OWNER" + identifier)}`);
      break; 
    case 'wallet owner' :
        cy.intercept('POST','**/api/v1/invite**').as('invite');
        cy.visit(`${Cypress.env("APP_DOMAIN")}api/invite?token=${Cypress.env("INVITE_TOKEN_WALLET"+ identifier)}`);
        cy.wait('@invite')
        break; 
    default:
        throw new Error(user + " user is not found");
    }

});

When(`inside {}, Accept the invite`, (invitations:string) => {
  switch (invitations.toLowerCase()) {
    case 'participant offers':
      cy.intercept('POST','**/api/v1/esop/getESOPParticipant**').as('legalText');
      cy.get(`[role="cell"][data-field="inviteType"]:contains('ESOP')`).next().next().find(`button:contains('Accept')`).click()
      cy.wait(['@legalText']);
      cy.get(`[role="dialog"][id="accept-esop-invite-disclaimer"]`).find(`button:contains('Accept')`).click();
      break;
    case 'company owner invitations' :
      cy.intercept('POST','**/api/v1/invite**').as('invite');
      cy.get(`[role="cell"][data-field="inviteType"]:contains('Company Owner')`).next().next().find(`button:contains('Accept')`).click()
      cy.wait('@invite')
      break; 
    case 'wallet invitations' :
      cy.intercept('POST','**/api/v1/invite**').as('invite');
      cy.get(`[role="cell"][data-field="inviteType"]:contains('Wallet')`).next().next().find(`button:contains('Accept')`).click()
      cy.wait('@invite')
      break; 
    default:
        throw new Error(invitations + " invite is not found");
    }

});


When(`inside '{}' tab, '{}' is pressed`, (tab: string, button: string) => {
  switch (tab.toLowerCase()) {
    case "my offer":
      switch (button.toLowerCase()) {
        case "accept":  
         cy.get(`[type="button"]:contains('${button}')`).click()
         break;
      }
     break;
    default:
      throw new Error(tab + " tab is not found");
  }
});


When(`inside alert pop-up, {}, '{}' is pressed`, (message: string, button: string) => {
  switch (message.toLowerCase()) {
    case 'confirm offer acceptance':
      cy.intercept('POST','**/api/v1/esop/participant/**').as('acceptOffer');
      cy.get(`[role="dialog"][id="confirm-offer-acceptance"]`).find(`button:contains('${button}')`).click()
      cy.wait(['@acceptOffer']);
      break;
    case 'email sent':
      cy.get(`[role="dialog"][id="email-sent"]`).find(`button:contains('${button}')`).click()
      break;
    case 'create new wallet':
        cy.get(`[role="dialog"][id="create-new-wallet"]`).find(`button:contains('${button}')`).click()
        break;
    default:
      throw new Error(message + 'message is not defined');
  };
});

When(`inside {}, '{}' tile is pressed`, (screenName: string, item: string) => {
  switch (screenName.toLowerCase()) {
    case 'participant holdings':
      cy.get(`h5:contains('${item}')`).parent(`[data-color="GREEN"]`).click()
      break;
    case 'my wallets':
      cy.get(`h4:contains('${item}')`).click()
      break;
    default:
      throw new Error(screenName + 'screen is not defined');
  };
});



