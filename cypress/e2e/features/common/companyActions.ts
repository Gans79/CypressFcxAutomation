/// <reference types="@testing-library/cypress" />
import '../../../support/commands';
import { When } from '@badeball/cypress-cucumber-preprocessor';

When(`company user actions for {} is pressed`, (user: string) => {
    const userFixture: string = Cypress.env('ENV') + '/users/' + user.toLowerCase()
    cy.fixture(userFixture)
      .then((userDetails) => {
        const name: string = userDetails.firstName + ' ' + userDetails.lastName;
        cy.log('name: ', name);
        cy.get("[role=\"grid\"]").first().within(() => {
          cy.get(`div[data-field=name]:contains('${name}')`).parent().find(`[aria-label=user-actions]`).click();
        })
      });
  });


  When(`in {} screen, '{}' is entered into {}`, (screenName: string, text: string, item: string) => {
    switch (screenName.toLowerCase()) {
        case 'fcx admin communications':
            switch (item.toLowerCase()) {
                case 'template name':
                    cy.get(`label:contains('${item}')`).next(`div`).children(`input`).clear().type(text);
                    break;
                case 'template body':
                    console.log("Setting Template Body: ", text);
                    cy.get(`span:contains('BODY')`).next(`div`).find('div[role="textbox"]')
                        .clear().type(text);
                    break;
                case 'template footer':
                    cy.get(`span:contains('FOOTER')`).next(`div`).find('div[role="textbox"]')
                        .clear().type(text);
                    break;
                default:
                    throw new Error(screenName + ' screen name not defined.');
            }
            break;
        case 'fcx admin dashboard':
           switch (item.toLowerCase()) {
              case 'search':
                    cy.intercept('POST','**/api/v1/admin**').as('search');
                    cy.get(`[placeholder="Search…"]`).type(text).type('{enter}');
                    cy.wait(['@search']);
                  break;
              default:
                  throw new Error(item + ' screen item not defined.');
           }

    }
});

When(`in {} screen, '{}' action is selected`, (screenName: string, selection: string) => {
    switch (screenName.toLowerCase()) {
        case 'fcx admin communications':
            cy.get(`button[aria-label="bid-table-actions"]:contains('Action')`).click();
            cy.get(`div[data-testid="sentinelStart"]`).next().find(`li:contains('${selection}')`).eq(0).click();
            break;
        default:
            throw new Error(screenName + ' screen name is not defined.');
    }
});


When(`in {} screen, '{}' is pressed`, (screenName: string, action: string) => {
  switch (screenName.toLowerCase()) {
      case 'fcx admin dashboard':
          switch (action.toLowerCase()) {
              case 'create company':
                cy.get(`[data-testid="ArrowForwardIcon"]`).click();
                break;
              case '3 dots':
                cy.get(`[data-rowindex="0"]`).find(`svg[data-testid="MoreVertIcon"]`).click();
                break;
              case 'upload investors':
                cy.intercept('POST','**/api/v1/admin**').as('uploadInvestor');
                cy.get(`[role="menuitem"]:contains('Upload Investor & Transaction Data')`).click();
                cy.wait(['@uploadInvestor']);
                break;
              case 'review and approve data':
                cy.get(`[role="menuitem"]:contains('Review & Approve Data')`).click();
                break;
              case 'invite owner':
                cy.get(`[role="menuitem"]:contains('Invite Owner')`).click();
                break;
              default:
                  throw new Error(action + ' screen action not defined.');
          }
          break;
      case 'fcx admin wallets':
            switch (action.toLowerCase()) {
                case 'create wallet':
               //   cy.intercept('POST','**/api/getFeature**').as('createWallet');
                  cy.get(`button:contains('${action}')`).click();
               //   cy.wait('@createWallet');
                  break;
                default:
                    throw new Error(action + ' screen action not defined.');
            }
            break;
      case 'issuer requests':
            switch (action.toLowerCase()) {
                case 'review request':
                  cy.get(`[role="menuitem"]:contains('Review')`).click();
                  break;
                default:
                    throw new Error(action + ' screen action not defined.');
            }
            break;
  }
});


When(`in {} screen, 3 dots is pressed next to '{}'`, (screenName: string, item: string) => {
  switch (screenName.toLowerCase()) {
      case 'issuer requests':
            cy.get(`[role="cell"][data-field="requestedByName"]:contains('${item}')`).next().next().next().find(`svg[data-testid="MoreVertIcon"]`).click();
            break;
      default:
            throw new Error(screenName + ' screen name not defined.');
    
  }
});


When(`in {} screen pop-up, '{}' is entered into {}`, (screenName: string, text: string, item: string) => {
  switch (screenName.toLowerCase()) {
      case 'create company':
          switch (item.toLowerCase()) {
              case 'company name':
                  cy.get(`[data-testid="field-companyName"]`).clear().type(text);
                  break;
              case 'acn':
                  cy.get(`[data-testid="field-acn"]`).clear().type(text);
                  break;
              case 'phone number':
                  cy.get(`[data-testid="field-phoneNumber"]`).clear().type(text);
                  break;
              case 'address line 1':
                  cy.get(`[data-testid="field-addressLine1"]`).clear().type(text);
                  break;
              case 'suburb':
                  cy.get(`[data-testid="field-suburb"]`).clear().type(text);
                  break;
              case 'postcode':
                  cy.get(`[data-testid="field-postcode"]`).clear().type(text);
                  break;
              case 'state':
                  cy.get(`label:contains('${item}')`).next().children(`div`).click().then(() => {
                     cy.get(`li[role="option"]:contains('${text}')`).click();
                     });
                  break;
              case 'country':
                    cy.get(`li[role="option"]:contains('${text}')`).click();
                    break;
              case 'description':
                  cy.get(`[role="textbox"]`).clear().type(text);
                  break;
              default:
                  throw new Error(item + ' item not defined.');
          }
          break;
      case 'create new wallet':
          switch (item.toLowerCase()) {
              case 'issuer':
                  cy.get(`[role="combobox"]`).eq(0).type(text).type('{enter}')
                  cy.get(`[role="option"][data-option-index="0"]`,{ timeout: Cypress.env('MAX_TIMEOUT') }).click()
                  break;
              case 'investor':
                  cy.intercept('POST','**/api/v1/issuer**').as('getIssuer');
                  cy.get(`[role="combobox"]`).eq(1).type(text).type('{enter}')
                  cy.get(`[role="option"][data-option-index="0"]`,{ timeout: Cypress.env('MAX_TIMEOUT') }).click()
                  cy.wait('@getIssuer');
                  break;
              case 'date of birth':
                  cy.get(`[data-testid="individual1.dob"]`).type(text)
                  break;
              case 'date of birth for individual2':
                  cy.get(`[data-testid="individual2.dob"]`).type(text)
                  break;
              case 'mobile number for individual2':
                  cy.get(`[name="individual2.mobileNumber"]`).type(text)
                  break;
              case 'email address for individual2':
                  cy.get(`[name="individual2.emailAddress"]`).type(text)
                  break;
              case 'confirm email address for individual2':
                  cy.get(`[name="individual2.confirmEmailAddress"]`).type(text)
                  break;
              case 'address line1 for individual2':
                  cy.get(`[name="individual2.address.addressLine1"]`).type(text)
                  break;
              case 'suburb for individual2':
                  cy.get(`[name="individual2.address.suburb"]`).type(text)
                  break;
              case 'state for individual2':
                  cy.get(`[name="individual2.address.state"]`).type(text)
                  break;
              case 'postcode for individual2':
                  cy.get(`[name="individual2.address.postcode"]`).type(text)
                  break;
              case 'country for individual2':
                  cy.get(`[name="individual2.address.country"][role="combobox"]`).type(text)
                  cy.get(`[role="option"][data-option-index="0"]`,{ timeout: Cypress.env('MAX_TIMEOUT') }).click()
                  break;
              case 'firstname for company':
                  cy.get(`[name="firstName"]`).type(text)
                  break;
              case 'lastname for company':
                  cy.get(`[name="lastName"]`).type(text)
                  break;
              case 'position for company':
                  cy.get(`label:contains('Position')`)
                    .next().find(`[role="button"]`).click({ force: true })
                  cy.get(`[role="option"][data-value="1"]`).click()
                  break;
              case 'email for company':
                  cy.get(`[name="emailAddress"]`).type(text)
                  break;
              default:
                  throw new Error(item + ' item not defined.');
          }
          break;
  }
});



When(`in {} screen pop-up, '{}' is pressed`, (screenName: string, action: string) => {
  switch (screenName.toLowerCase()) {
      case 'create company':
          switch (action.toLowerCase()) {
              case 'add next to company directors':
                cy.get(`span:contains('COMPANY DIRECTORS')`).next(`[data-testid="add-director"]`).click()
                break;
              case 'add next to security classes':
                cy.get(`span:contains('SECURITY CLASSES')`).next(`[data-testid="add-security-class"]`).click()
                break;
              case 'save':
                cy.intercept('POST','**/api/v1/admin**').as('saveCompany');
                cy.get(`[data-testid="button-submit"]`).click();
                cy.wait(['@saveCompany']);
                break;
              default:
                  throw new Error(action + ' screen action not defined.');
          }
          break;
      case 'upload investor':
           switch (action.toLowerCase()) {
            case 'save':
                cy.intercept('POST','**/api/v1/admin**').as('saveInvestor');
                cy.get(`[data-testid="button-submit"]`).click();
                cy.wait(['@saveInvestor']);
                break;
              default:
                  throw new Error(action + ' screen action not defined.');
           }
          break;
       case 'review investor':
            switch (action.toLowerCase()) {
             case 'approve':
                 cy.intercept('POST','**/api/v1/admin**').as('approveInvestor');
                 cy.get(`[data-testid="button-submit"]`).click();
                 cy.wait(['@approveInvestor']);
                 break;
               default:
                   throw new Error(action + ' screen action not defined.');
            }
           break;
       case 'create new wallet':
            switch (action.toLowerCase()) {
             case 'create':
                cy.intercept('POST','**/api/v1/invite**').as('walletInvite');
                cy.get(`h2:contains('Create New Wallet')`)
                  .parent().find(`button:contains('Create')`).click();
                break;
             case 'check':
                  cy.get(`[data-testid="CheckIcon"]`).click();
                  break;
             case 'individual 2 details':
                cy.get(`span:contains('INDIVIDUAL 2 DETAILS')`).click()
                break;
             default:
                   throw new Error(action + ' screen action not defined.');
            }
           break;
        case 'add holding to a wallet':
            switch (action.toLowerCase()) {
             case 'next':
               cy.get('[role="dialog"][id="reminder"]')
                 .find(`button:contains('Next')`).click()
                break;
             case 'confirm':
               cy.intercept('POST','**/api/v1/transfer**').as('walletTransfer');
               cy.get('[role="dialog"][id="add-your-holding-to-wallet"]')
                  .find(`button:contains('Confirm')`).click()
               cy.wait(['@walletTransfer']);
                break;
             default:
                   throw new Error(action + ' screen action not defined.');
            }
           break;
        case 'request sent':
            switch (action.toLowerCase()) {
             case 'close':
              cy.get('[role="dialog"][id="request-sent"]')
                .find(`button:contains('Close')`).click()
              break;
             default:
                   throw new Error(action + ' screen action not defined.');
            }
           break;
        case 'review request':
            switch (action.toLowerCase()) {
             case 'authorise':
              cy.intercept('POST','**/api/v1/transfer**').as('walletTransfer');
              cy.get(`button:contains('Authorise')`).click()
              cy.wait('@walletTransfer');
              break;
            default:
                   throw new Error(action + ' screen action not defined.');
            }
           break;
        }
});


When(`in {} screen pop-up, '{}' is pressed next to '{}'`, (screenName: string, action: string, section: string) => {
    switch (screenName.toLowerCase()) {
        case 'create company':
            switch (section.toLowerCase()) {
                case 'save':
                  cy.intercept('POST','**/api/v1/admin**').as('saveCompany');
                  cy.get(`[data-testid="button-submit"]`).click();
                  cy.wait(['@saveCompany']);
                  break;
                default:
                    throw new Error(action + ' screen action not defined.');
            }
    }
  });


When(`in {} screen pop-up, upload {} as '{}'`, (screenName: string, action: string, fileName: string) => {
    switch (screenName.toLowerCase()) {
      case 'create company':
           const logoFilePath: string = 'cypress/fixtures/' + fileName;
           cy.get(`[data-testid="CloudUploadIcon"]`).click()
           cy.get("input[type=file]").selectFile(logoFilePath, { force: true });
           cy.get(`button:contains('Confirm')`).click();
          break;
      case 'upload investor':
          const investorFilePath: string = 'cypress/fixtures/' + fileName;
        //    cy.fixture(fileName,null).then((validFile) => {
        //      cy.get(`span:contains('Upload investors and transactions data')`).next().find(`[data-testid="CloudUploadIcon"]`).click().then(() => {
        //        cy.get(`input[type=file]`).selectFile(investorFilePath, { force: true });
        //      })
        //     });
         cy.get(`span:contains('Upload investors and transactions data')`).next().find(`[data-testid="CloudUploadIcon"]`).click().then(() => {
              cy.get(`span:contains('Investor Summary')`).should('be.visible')
              cy.get("input[type=file]").selectFile(investorFilePath, { force: true })
               });
          break;
      default:
         throw new Error(screenName + ' screenName not defined.');
        }
  });


When(`in Add Company Directors screen pop-up, '{}' , '{}' and '{}' entered and save is pressed`, (itemName: string, itemRole: string, itemSign: string) => {
   
    const incFilePath: string = 'cypress/fixtures/' + itemSign;
    cy.get(`[name="fullName"]`).clear().type(itemName);
    cy.get(`[name="role"]`).clear().type(itemRole);
    cy.get(`h4:contains('Upload Signature')`).next(`[data-testid="CloudUploadIcon"]`).click().then(() => {
        cy.get("input[type=file]").eq(1).selectFile(incFilePath, { force: true}) 
        });
    cy.get(`button:contains('Confirm')`).click();
    cy.get('div[role="dialog"][id="add-company-director-/-secretary"]').find(`button:contains('Save')`).click();

  });


  When(`in Invite owner screen pop-up, '{}' , '{}' entered and send invite is pressed for '{}'`, (itemName: string, itemEmail: string, companyName: string) => {
   
    cy.get(`span:contains('ENTER NAME AND EMAIL')`).next().find(`[data-testid="field-name"]`).clear().type(itemName)
      .next(`[data-testid="field-email"]`).clear().type(itemEmail);
    cy.intercept('POST','**/api/v1/invite**',(req) =>{
        req.alias = req.body.method;
    });
    cy.get(`button[data-testid="button-invite"]`).click();
    cy.wait('@sendInvite').then((intercept) => {
    let token = ''
    cy.log(intercept.response?.body.result.token)
    token = intercept.response?.body.result.token
    Cypress.env('INVITE_TOKEN_OWNER' + companyName ,token)
    cy.log(Cypress.env('INVITE_TOKEN_OWNER' + companyName))

    })

  });



  When(`in New Wallet Created screen pop-up, '{}' is pressed for '{}'`, (itemName: string, investorName: string) => {
   
    cy.get(`button:contains('Done')`).click();
    cy.wait('@walletInvite').then((intercept) => {
    let token = ''
    cy.log(intercept.response?.body.result.token)
    token = intercept.response?.body.result.token
    Cypress.env('INVITE_TOKEN_WALLET' + investorName ,token)
    cy.log(Cypress.env('INVITE_TOKEN_WALLET' + investorName))})

  });



When(`in Add Security Class screen pop-up, '{}' , '{}' and '{}' entered and save is pressed`, (itemType: string, itemIdentifier: string, itemDesc: string) => {
  
    cy.get(`[name="type"]`).clear().type(itemType);
    cy.get(`[name="identifier"]`).clear().type(itemIdentifier);
    cy.get(`[role="dialog"][id="add-security-class"]`).find(`[name="description"]`).type(itemDesc);
    cy.get(`[role="dialog"][id="add-security-class"]`).find(`button:contains('Save')`).click();

});


When(`in {} screen pop-up, {} checkbox is '{}'`, (screenName: string, itemName: string, itemState: string) => {
        switch (screenName.toLowerCase()) {
          case 'create company':
            switch (itemName.toLowerCase()) {
                case 'enable online shares certificate':
                    if (itemState.toLowerCase() === 'checked')
                        {cy.get(`[name="shareCertificateEnabled"]`).find(`[type="checkbox"]`).check();}
                    break;
                case 'certificate signatory':
                    if (itemState.toLowerCase() === 'checked')
                    {cy.get(`[data-field="signatory"]`).find(`[type="checkbox"]`).check();}
                break;
                default:
                  throw new Error(itemName + ' Field not defined.');
                }
                break;
            default:
                throw new Error(screenName + ' screenName not defined.');
            }
});


When(`'{}' clicks login in to FCX '{}'`, (user: string, app: string) => {
  const userFixture: string = Cypress.env('ENV') + '/users/' + user.toLowerCase()
  cy.fixture(userFixture)
    .then((userDetails) => {
      switch (app.toLowerCase()) {
        case "app":
          cy.get(`button:contains('Log In')`).click();
          cy.get(`input[name=email]`).type(userDetails.email);
          cy.get(`input[name=password]`).type(userDetails.password);
          cy.get(`button[data-testid=button-login]`).click();
          cy.get(`h1:contains('Welcome to FCX')`,{ timeout: Cypress.env('MAX_TIMEOUT') }).should('be.visible')
          break;
        default:
          throw new Error(app + " web app is not defined");
      }
    });
});