/// <reference types="@testing-library/cypress" />
import '../../../support/commands';
import { DataTable, When } from '@badeball/cypress-cucumber-preprocessor';
import { convertToCamelCase, convertTestDate, convertToKebabCase } from "../../../support/utils";

When(`'{}' {} is pressed`, (text: string, type: string) => {
  switch (type.toLowerCase()) {
    case 'company':
      cy.get(`img[alt='${text}'])`).click();
      break;
    case 'action':
      cy.get(`li:contains('${text}')`).click();
      break
    case 'button': case 'tab': case 'Log In':
      cy.get(`button:contains('${text}')`).click();
      break
    case 'link':
      cy.get(`a:contains("${text}")`).click();
      break
    case 'video':
      cy.get(`div[title="${text}"]`).parent(`div[data-field="url"]`).click();
      break;
    case 'back to':
      cy.get(`h2`).contains(new RegExp("^" + text + "$", "g")).prev(`button`).scrollIntoView().click({ force: true });
      break
    default:
      throw new Error(type + ' type is not defined');
  }
});

When(`in {}, {} tile is pressed`, (type: string, text: string) => {
  switch (type.toLowerCase()) {
    case 'company view':
      cy.get(`img[alt='${text}']`).click();
      break;
    case 'my holdings':
        cy.get(`img[alt='${text}']`).click();
        break;
    case 'esop':
      cy.get(`h5:contains('${text}')`).first().click({force: true});
      break;
    case 'esop plan':
      cy.get('p').contains(new RegExp("^" + text + "$", "g"), { timeout: 10000 }).scrollIntoView().click();
      break;
    case 'my wallets':
      cy.get(`h4:contains('${text.toUpperCase()}')`).click();
      break;
    default:
      throw new Error(text + " type is not found");
  }
});

When(
  `in {}, {} Menuitem {} is pressed`,
  (type: string, text: string, operation: string) => {
    switch (type.toLowerCase()) {
      case "esop":
        cy.get(`[role="menuitem"]:contains('${operation}')`).click();
        break;
      default:
        throw new Error(text + " type is not found");
    }
  }
);

When(`in {}, {} Threedots is pressed`, (type: string, text: string) => {
  switch (type.toLowerCase()) {
    case "esop":
      cy.get(`h5:contains('${text}')`).next(`[data-testid="esop-plan-menu-button"]`).click();
      break;
    default:
      throw new Error(text + " type is not found");
  }
});

When(`{} menu '{}' is pressed`, (menu: string, text: string) => {
  switch (menu.toLowerCase()) {
    case 'company':
      switch (text.toLowerCase()) {
        case "company":
        case "cap table":
        case "investors":
          cy.get(`span:contains('${text}')`).click();
          break;
        case "users":
          cy.get(`span:contains('${text}')`).eq(0).click();
          break;
        case "securities":
        case "esop":
          cy.get(`span:contains('${text}')`).eq(0).click();
          cy.get(`span:contains("ESOP Dashboard")`).eq(0).click();
          break;
        default:
           throw new Error(text + " menu item is not found");
      }
      break;
    case 'fcx concierge':
      switch (text) {
        case 'ESOP': case 'Communications':  case 'Wallets': case 'Cap-Raises':
          cy.get(`a[href='/${text.toLowerCase()}']`).click();
          break;
        case 'Dashboard':
          cy.get(`a[href='/${text.toLowerCase()}']:contains('${text}')`).click();
          break;
        default:
          throw new Error(text + ' menu item is not found');
      }
      break;
    case 'main':
      switch (text) {
        case 'Investor':
          cy.get(`a[href='/${text.toLowerCase()}/dashboard']`).click();
          break;
        case 'User Profile':
          cy.get(`a[href='/user/profile']`).click();
          break;
        default:
          throw new Error(text + ' menu item is not found');
      }
      break;
    case 'investor':
      switch (text) {
        case 'Wallets':
          cy.intercept('**/investor/wallet**').as('wallets');
          cy.get(`[href="/investor/${text.toLowerCase()}"]`).click();
          cy.wait('@wallets');
          break;
        case "My ESOP Offers":
          cy.get(`span:contains('${text}')`).eq(0).click();
          break;
        default:
          throw new Error(text + ' menu item is not found');
      }
      break;
    case 'my account':
      switch (text) {
        case 'Security':
          cy.get(`[href="/user/${text.toLowerCase()}"]`).click();
          break;
        default:
          throw new Error(text + ' menu item is not found');
      }
      break;
    case 'cap table':
      switch (text.toLowerCase()) {
        case "investors":  case "requests":
          cy.get((`[role="button"]:contains('Cap Table')`))
            .next().find(`span:contains('${text}')`).eq(0).click();
          break;
        default:
           throw new Error(text + " menu item is not found");
      }
      break;
    default:
      throw new Error(menu + ' menu is not found');
  }
});

When(`actions for {} is pressed`, (user: string) => {
  const userFixture: string = Cypress.env('ENV') + '/users/' + user.toLowerCase()
  cy.fixture(userFixture)
    .then((userDetails) => {
    // const name: string = userDetails.firstName + (userDetails.middleName ? (' ' + userDetails.middleName): '' ) + ' ' + userDetails.lastName;
      const name: string = userDetails.firstName + ' ' + userDetails.lastName;
    // BUG?: not showing middle name
      cy.log('name: ', name);
    // Anchor
    // cy.get(`div[data-field=name]:contains('${name}')`).should('be.visible')
      cy.get(`div[data-field=name]:contains('${name}')`).parent().find(`[aria-label=user-actions]`).click();
  });
});

When(`more actions '{}' is selected`, (selection: string) => {
  cy.get(`#esop-plan-menu-button`).click()
    .then(() => {
      cy.get(`div[data-testid="sentinelStart"]`).next().find(`li:contains('${selection}')`).click();
    })
});

When(`'{}' {} is set to enabled`, (title: string, attrib: string) => {
  switch (attrib.toLowerCase()) {
    case 'checkbox':
      cy.get(`p:contains('${title}')`).first()
        .parents('label')
        .find(`input[type=checkbox][name=${title.toLowerCase()}]`)
        .should('exist').check();
      break;
    default:
      throw new Error(attrib + ' is not defined');
  }
});

When(`{} '{}' is entered`, (item: string, text: string) => {
  cy.get(`label:contains('${item}')`).next().find(`input`).type(text);
});

When(`in 'Search', search for '{}'`, (searchText: string) => {
  // cy.get(`[role="row"]`).should('be.visible');
  cy.get(`[data-testid="search-box"]`).click()
    // .parent().click().within(() => {
    // cy.get(`input`).clear()
    .type(searchText);
  // })
});

/* Pattern: in {title} pop-up, {text} is entered into {field} */
When(`in '{}' pop-up, '{}' is entered into {}`, (dialogLabel: string, text: string, item: string) => {
    const itemName: string = item.toLowerCase();

    switch (dialogLabel.toLowerCase()) {
    case 'two-factor authentication':
        switch (item) {
        case 'Password':
            cy.get(`[name="${item.toLowerCase()}"]`).click().clear().type(text);
      };
        break;
    case 'create company':
        switch (item) {
        case 'Company Name': case 'Phone Number': case 'Address Line 1': case 'Suburb': case 'Postcode': case 'State':
          text != '' ? cy.get(`input[name=${convertToCamelCase(item)}]`).clear().type(text) : null;
            break;
        case 'ACN':
          text != '' ? cy.get(`input[name=${item.toLowerCase()}]`).clear().type(text) : null;
            break;
        case 'Description':
            cy.get(`[role="textbox"]`).children(`p`).clear().type(text);

            break;
          default:
          throw new Error(item + ' label not defined.');
        }
        break;
      // Plan
    case 'create plan':
        switch (itemName) {
        case 'description':
          cy.get(`[data-testid="field-description"]`).find(`textarea[name=${itemName}]`).clear().type(text);
            break;
        case 'plan name':
            cy.get(`[data-testid="field-planName"]`).clear().type(text);
            break;
        case 'vesting':
          if(text)
           {
            cy.get(`[data-testid="field-daysBeforeVesting"]`).clear().type(text);
            }
            break;
          default:
          throw new Error(itemName + ' item label not defined.');
          // cy.get(`label:contains('${item}')`).next().find(`input`).clear().type(text);
        }
        break;
      // ESOP
    case 'create esop': case 'esop pool': case 'edit esop':
        switch (itemName) {
        case 'description':
            cy.get(`textarea[name="planDescription"]`).clear().type(text);
            break;
        case 'amount':
            cy.get(`input[name="amount"]`).clear().type(text);
            break;
        case 'percentage':
            cy.get(`input[name="percentage"]`).clear().type(text);
            break;
          default:
          cy.get(`label:contains('${item}')`).next().find(`input`).clear().type(text);
        }
        break;
      // ESOP Offer
    case 'create offer': case 'edit offer': case 'clone offer':
        switch (itemName.toLowerCase()) {
        case 'offer name':
            cy.get(`input[name="offerName"]`).clear().type(text);
            break;
        case 'description':
            cy.get(`textarea[name="description"]`).clear().type(text);
            break;
        case 'vesting description':
          cy.get(`[data-testid="field-vestingDescription"]`).clear().type(text)
            break;
        case 'grant date': case 'expiry date': case 'close date': case 'vesting date':
            if (text != "") {
            cy.get(`label:contains('${item}')`).next(`div`).children(`input[placeholder="dd/mm/yyyy"]`).click()
                .then(() => {
                cy.get(`label:contains('${item}')`).next(`div`).children(`input[placeholder="dd/mm/yyyy"]`).clear().type(convertTestDate(text));
                });
            }
            break;
        case 'vesting amount (%)': case 'vesting amount(%)':
            // // Sigh ... this is for Auto
            // cy.get(`[name="vestingData.auto.amount"]`).clear().type(text);
            // // This is for Manual
            // cy.get(`[name="vestingAmount"]`).clear().type(text);
            // // So solution becomes:
          cy.get(`label:contains('${item}')`).next(`div`).children(`input`).clear().type(text);
            break;
        case 'issue price':
            cy.get(`[name="issuePrice"]`).clear().type(text);
            break;
        case 'exercise price':
            cy.get(`[name="exercisePrice"]`).clear().type(text);
            break;
          default:
          throw new Error(itemName + ' item label not defined.');
        }
        break;
      // Documents
    case 'upload new document': case 'edit document':
        switch (item) {
        case 'Document Name':
          cy.get(`label:contains('${item}')`).next(`div`).children(`input`).clear().type(text);
            break;
          default:
          throw new Error(item + ' label not defined.');
        }
        break;
      // Q & A
    case 'create q&a': case 'update q&a':
        switch (item) {
        case 'Question':
          cy.get(`label:contains('${item}')`).next(`div`).children(`input`).clear().type(text);
            break;
        case 'Answer':
          cy.get(`span:contains('${item.toUpperCase()}')`).next(`div`)
              // .find(`div:contains('Enter your answer here...')`)
              .find('div[role="textbox"]')
            .clear().type(text);
            break;
          default:
          throw new Error(item + ' label not defined.');
        }
        break;
    case 'add participant': case 'edit participant': case 'add investor':
        switch (item) {
        case 'First Name':
        case 'Middle Names': case 'Middle Name':
        case 'Last Name':
        case 'Position': case 'Department': case 'Work Number': case 'Email': case 'Address Line 1': case 'Address Line 2':
        case 'Suburb': case 'State': case 'Postcode': case 'Country': case 'No. of securities':
        case 'Contact Number': case 'Email Address':
          text != '' ? cy.get(`label:contains('${item}')`).next().children(`input`).clear().type(text) : null;
            break;
        case 'Employee First Name':
            cy.get(`input[name="employee.firstName"]`).clear().type(text);
            break;
        case 'Employee Last Name':
            cy.get(`input[name="employee.lastName"]`).clear().type(text);
            break;
          default:
          throw new Error(item + ' label not defined.');
        }
        break;
    case 'add video link': case 'update video link':
        switch (item) {
        case 'Title': case 'URL':
          text != '' ? cy.get(`label:contains('${item}')`).next().children(`input`).clear().type(text) : null;
            break;
          default:
          throw new Error(item + ' label not defined.');
        }
        break;
    case 'designate a bank account':
        switch (item) {
        case 'Account Name': case 'BSB': case 'Account Number':
          text != '' ? cy.get(`label:contains('${item}')`).next().children(`input`).clear().type(text) : null;
            break;
          default:
          throw new Error(item + ' label not defined.');
        }
        break;
    case 'send email preview':
        switch (itemName) {
            case 'email': case 'subject':
                cy.get(`input[name=${itemName}]`).clear().type(text);
                break;
            default:
                cy.get(`label:contains('${item}')`).next().find(`input`).clear().type(text);
        }
        break;
      default:
      throw new Error(dialogLabel + ' dialog label not defined.');
    }
});

When(`in '{}' pop-up, '{}' {} is pressed`, (dialogLabel: string, text: string, type: string) => {
    switch (dialogLabel.toLowerCase()) {
    case 'create plan':
        switch (text.toLowerCase()) {
        case 'create':
          cy.get(`[data-testid="save-plan-button"]`, { timeout: Cypress.env('MAX_TIMEOUT') }).click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
      };
        break;
    case 'create esop': case 'edit esop':
        switch (text.toLowerCase()) {
        case 'create':
            cy.get(`[data-testid="create-button"]`).click();
            break;
        case 'save':
            cy.get(`[data-testid="edit-button"]`).click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
      };
        break;
    case 'esop pool':
        switch (text.toLowerCase()) {
        case 'save':
            cy.get(`[data-testid="update-button"]`).click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
      };
        break;
    case 'archive plan': case 'delete plan':
    case 'edit document': case 'unpublish document': case 'archive document': case 'delete document': case 'delete q & a': case 'delete video':
    case 'remove participant': case 'edit participant': case 'add participants (bulk import)':
        switch (text.toLowerCase()) {
        case 'unpublish':
            cy.get(`[data-testid="button-remove"]`).click();
            break;
        case 'cancel': case 'update': case 'archive': case 'delete': case 'download template': case 'upload': case 'confirm':
            cy.get(`button:contains('${text}')`).click();
            break;
        case 'close':
            cy.get(`[data-testid="button-closeDialog"]`).click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
      };
        break;
    case 'create security class':
        switch (text.toLowerCase()) {
        case 'create':
            cy.get(`[data-testid="button-invite"]`).click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
      };
        break;
    case 'create offer': case 'edit offer': case 'clone offer': case 'create q&a': case 'add participant': case 'update q&a':
        switch (text.toLowerCase()) {
        case 'create':
          cy.get(`#create-offer`).find(`button:contains('Create')`)
            .click();
            break;
        case 'save': case 'clone': case 'cancel':
          cy.get(`button:contains('${text}')`)
            .click();
            break;
        case 'add':
          cy.get(`button[data-testid="add-button"]:contains('${text}')`)
            .click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
      };
        break;
    case 'upload new document':
        switch (text.toLowerCase()) {
        case 'upload':
          switch (type) {
            case 'button':
              cy.get(`#upload-new-document`).find(`button:contains('${text}')`).click();
              cy.intercept('POST','**/api/v1/esop/**').as('docUpload');
              cy.wait(['@docUpload']);
                break;
            case 'validation':
              cy.get(`#upload-new-document`).find(`button:contains('${text}')`).click();
              break;
            default:
              throw new Error(text + ' ' + type + ' not defined.');
          }
      };
        break;
    case 'add video link': case 'update video link':
      cy.log('convertToKebabCase: ' + convertToKebabCase(dialogLabel.toLowerCase()));
        switch (text.toLowerCase()) {
        case 'add': case 'update':
          cy.get(`#${convertToKebabCase(dialogLabel.toLowerCase())}`)
            .within(() => {
              cy.get(`button`).contains((new RegExp("^" + text + "$", "g"))).click();
            });
            break;
          // case 'update':
          //   cy.get(`#update-video-link`)
          //     .within(() => {
          //       cy.get(`button`).contains((new RegExp("^" + text + "$", "g"))).click();
          //     });
          //   break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
      };
        break;
    case 'publish document':
        switch (text.toLowerCase()) {
        case 'publish':
          cy.get("#publish-document")
            .within(() => {
              cy.get(`button`).contains((new RegExp("^" + text + "$", "g"))).click();
            });
            break;
        case 'cancel':
            cy.get(`button:contains('${text}')`).click();
            break;

          default:
          throw new Error(text + ' ' + type + ' not defined.');
      };
        break;
    case 'add existing participants':
        switch (text.toLowerCase()) {
        case 'add':
            cy.get(`[data-testid="transfer-add"]`).click();
            break;
        case 'remove':
            cy.get(`[data-testid="transfer-remove"]`).click();
            break;
        case 'submit':
            cy.get(`[data-testid="add-button"]`).click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
        }
        break;
    case 'add investor': case 'two-factor authentication': case 'designate a bank account': case 'edit investor':
        switch (text.toLowerCase()) {
        case 'save': case 'next': case 'submit': case 'verify': case 'disable': case 'confirm':
            cy.get(`button:contains('${text}')`).click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
        }
        break;
    case 'close offer confirmation':
        switch (text.toLowerCase()) {
        case 'confirm': /*case 'delete':*/ case 'unpublish': case 'cancel': case 'update': case 'archive': case 'delete': case 'download template': case 'upload':
            cy.get(`button:contains('${text}')`).click();
            break;
          default:
          throw new Error(text + ' ' + type + ' not defined.');
        }
        break;
      default:
      throw new Error(dialogLabel + ' dialog label not defined.');
    }
});

When(`in '{}' pop-up, '{}' is selected for {}`, (dialogLabel: string, selection: string, item: string) => {
    switch (dialogLabel.toLowerCase()) {
    case 'create esop':
      cy.get(`span:contains('${item}')`).parent().parent().siblings(`div`).find('button').click();
        // cy.get(`[data-testid="ArrowDropDownIcon"]`).click();
      cy.get(`span:contains('${item}')`).parent().parent().siblings(`input`).clear().type(selection)
          .then(() => {
            cy.get(`li:contains('${selection}')`).click();
          });
        break;
    case 'create offer': case 'edit offer':
        // Security ID
        switch (item) {
        case 'Security ID':
            cy.get(`#security-label`).next(`div`).click();
          cy.get(`div[data-testid="sentinelStart"]`).next(`div`).find(`li:contains('${selection}')`).click();
            break;
        case 'Frequency':
            cy.get(`#vesting-frequency-label`).next(`div`).click();
          cy.get(`div[data-testid="sentinelStart"]`).next(`div`).find(`li:contains('${selection}')`).click();
            break;
        case 'Rounding':
            cy.get(`#rounding-label`).next(`div`).click();
          cy.get(`div[data-testid="sentinelStart"]`).next(`div`).find(`li:contains('${selection}')`).click();
            break;
          default:
          throw new Error(item + ' item label not defined.');
        }
        break;
    case 'create q&a': case 'update q&a':
        // Link documents
      cy.get(`label:contains('Search Document')`).next().children(`input`).click().type(selection).then(() => {
            // cy.get(`li[role="option"]:contains('${selection}')`).click();
        cy.get(`[role="presentation"]`).find(`li[role="option"]`)
              // cy.get(`li[role="option"]`).contains(new RegExp("^" + selection + "$", "g"), {includeShadowDom :false})
              .contains(selection)
              .click({ waitForAnimations: false, force: true });
          });
        break;
    case 'add participant': case 'edit participant':
        switch (item) {
        case 'Country':
          cy.get(`label:contains('${item}')`).next().children(`input`).click().clear().type(selection).then(() => {
            selection.trim() != "" ? cy.get(`li[role="option"]:contains('${selection.toUpperCase()}')`).click() : cy.get(`button[title="Clear"] > svg[data-testid="CloseIcon"]`).click();
              });
            break;
          // Different action sequence
        case 'State':
          cy.get(`label:contains('${item}')`).next().children(`div`).click().then(() => {
            cy.get(`li[role="option"]:contains('${selection.toUpperCase()}')`).click();
              });
            break;
          default:
          throw new Error(item + ' item label not defined.');
      };
        break;
    case 'create company':
        switch (item) {
        case 'Country':
          cy.get(`label:contains('${item}')`).next().children(`input`).click().clear().type(selection) //.then(() => {
            cy.get(`li[role="option"]:contains('${selection}')`).click();
            break;
        case 'State':
          cy.get(`label:contains('${item}')`).next().children(`div`).click().then(() => {
                cy.get(`li[role="option"]:contains('${selection}')`).click();
              });
            break;
          default:
          throw new Error(item + ' item label not defined.');
        }
        break;
    case 'add investor': case 'edit investor':
        switch (item) {
        case 'Shareholder Type': case 'State':
          cy.get(`label:contains('${item}')`).next().children(`div`).click().then(() => {
                cy.get(`li[role="option"]:contains('${selection}')`).click();
              });
            break;
        case 'Country':
          cy.get(`label:contains('${item}')`).next().children(`input`).click().clear().type(selection).then(() => {
                cy.get(`li[role="option"]:contains('${selection}')`).click();
              });
            break;
          default:
          throw new Error(item + ' item label not defined.');
        }
        break;
      default:
      throw new Error(dialogLabel + ' dialog label not defined.');
    }
});

When(`in '{}' table, '{}' action for row detail is selected`, (tableName: string, selection: string, dataTable: DataTable) => {
    let row = {};
    let propValue;
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
        // cy.log(propName, propValue, row[propName]);
      }
    });

    switch (tableName.toLowerCase()) {
    case 'esop':
        switch (selection) {
        case 'Edit':
        case 'Archive':
        case 'Delete':
          cy.get(`*:contains('${row['Plan Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
              .parent(`div[data-field="name"]`)
            .siblings(`div[data-field="actions"]`).find(`button`).click()
              .then(() => {
              cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
              });
            break;
          default:
          throw new Error(selection + ' action for table ' + tableName + ' is not defined.');
        }
        break;
    case 'past plans':
        switch (selection) {
        case 'Delete':
          cy.get(`*:contains('${row['Plan Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
              .parent(`div[data-field="planName"]`)
            .siblings(`div[data-field="actions"]`).find(`button`).click()
              .then(() => {
              cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
              });
            break;
          default:
          throw new Error(selection + ' action for table ' + tableName + ' is not defined.');
        }
        break;
    case 'general documents':
        switch (selection) {
        case 'Edit Document': case 'Publish Document': case 'Unpublish Document': case 'Delete Document': case 'Archive Document':
            /* all unchecked */
          if (row['Linked to Q&A'] == '' && row['Published'] == '' && row['Archived'] == '') {
            cy.get(`div[data-field="documentName"]`).contains((new RegExp("^" + row['Document Name'] + "$", "g")), { timeout: Cypress.env('MAX_TIMEOUT') })
                .next(`div[data-field="linked"]`)
                .next(`div[data-field="published"]`)
                .next(`div[data-field="archived"]`)
              .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
              .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
          } else /* linked  */
            if (row['Linked to Q&A'] !== '' && row['Published'] == '' && row['Archived'] == '') {
              cy.get(`div[data-field="documentName"]`).contains((new RegExp("^" + row['Document Name'] + "$", "g")), { timeout: Cypress.env('MAX_TIMEOUT') })
                .next(`div[data-field="linked"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="published"]`)
                .next(`div[data-field="archived"]`)
                .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                  cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
            } else /* linked and published */
              if (row['Linked to Q&A'] !== '' && row['Published'] !== '' && row['Archived'] == '') {
                cy.get(`div[data-field="documentName"]`).contains((new RegExp("^" + row['Document Name'] + "$", "g")), { timeout: Cypress.env('MAX_TIMEOUT') })
                  .next(`div[data-field="linked"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                  .next(`div[data-field="published"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="archived"]`)
                  .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                  .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                    cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
              } else  /* published */
                if (row['Linked to Q&A'] == '' && row['Published'] !== '' && row['Archived'] == '') {
                  cy.get(`div[data-field="documentName"]`).contains((new RegExp("^" + row['Document Name'] + "$", "g")), { timeout: Cypress.env('MAX_TIMEOUT') })
                .next(`div[data-field="linked"]`)
                    .next(`div[data-field="published"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="archived"]`)
                    .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                    .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                      cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
                } else /* Published and Archived */
                  if (row['Linked to Q&A'] == '' && row['Published'] !== '' && row['Archived'] !== '') {
                    cy.get(`div[data-field="documentName"]`).contains((new RegExp("^" + row['Document Name'] + "$", "g")), { timeout: Cypress.env('MAX_TIMEOUT') })
                .next(`div[data-field="linked"]`)
                      .next(`div[data-field="published"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                      .next(`div[data-field="archived"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                      .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                      .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                        cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
                  } else /* Linked, Published and Archived */
                    if (row['Linked to Q&A'] !== '' && row['Published'] !== '' && row['Archived'] !== '') {
                      cy.get(`div[data-field="documentName"]`).contains((new RegExp("^" + row['Document Name'] + "$", "g")), { timeout: Cypress.env('MAX_TIMEOUT') })
                        .next(`div[data-field="linked"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                        .next(`div[data-field="published"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                        .next(`div[data-field="archived"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                        .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                        .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                          cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
            } else {
                      throw new Error('Row details combination for table ' + tableName + ' is not yet defined.');
            }
            break;
          default:
          throw new Error(selection + ' action for table ' + tableName + ' is not defined.');
        }
        break;
    case 'legal documents':
        switch (selection) {
        case 'Publish Document': case 'Edit Document': case 'Unpublish Document': case 'Archive Document': case 'Delete Document':
          cy.log('Signature Required: "' + row['Signature Required'] + '", Linked to Q&A: "' + row['Linked to Q&A'] + '", Published: "' + row['Published'] + '", Archived: "' + row['Archived'] + '"');
            // Just doc name
          if (row['Signature Required'] == '' && row['Linked to Q&A'] == '' && row['Published'] == '' && row['Archived'] == '') {
            cy.get(`div[data-field="documentName"]:contains('${row['Document Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
                .next(`div[data-field="agreementRequired"]`)
                .next(`div[data-field="linked"]`)
                .next(`div[data-field="published"]`)
                .next(`div[data-field="archived"]`)
              .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
              .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
          } else /* Signature, Linked and published to is checked */
            if (row['Signature Required'] !== '' && row['Linked to Q&A'] !== '' && row['Published'] !== '' && row['Archived'] == '') {
              cy.get(`div[data-field="documentName"]:contains('${row['Document Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
                .next(`div[data-field="agreementRequired"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="linked"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="published"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="archived"]`)
                .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                  cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
            } else /* Signature and Linked required is checked */
              if (row['Signature Required'] !== '' && row['Linked to Q&A'] !== '' && row['Published'] == '' && row['Archived'] == '') {
                cy.get(`div[data-field="documentName"]:contains('${row['Document Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
                  .next(`div[data-field="agreementRequired"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                  .next(`div[data-field="linked"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="published"]`)
                .next(`div[data-field="archived"]`)
                  .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                  .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                    cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
              } else /* Signature and Published required is checked */
                if (row['Signature Required'] !== '' && row['Linked to Q&A'] == '' && row['Published'] !== '' && row['Archived'] == '') {
                  cy.get(`div[data-field="documentName"]:contains('${row['Document Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
                    .next(`div[data-field="agreementRequired"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="linked"]`)
                    .next(`div[data-field="published"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="archived"]`)
                    .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                    .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                      cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
                } else /* signature, published and archived required is checked */
                  if (row['Signature Required'] !== '' && row['Linked to Q&A'] == '' && row['Published'] !== '' && row['Archived'] !== '') {
                    cy.get(`div[data-field="documentName"]:contains('${row['Document Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
                      .next(`div[data-field="agreementRequired"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="linked"]`)
                      .next(`div[data-field="published"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                      .next(`div[data-field="archived"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                      .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                      .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                        cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
                  } else /* Signature required is checked */
                    if (row['Signature Required'] !== '' && row['Linked to Q&A'] == '' && row['Published'] == '' && row['Archived'] == '') {
                      cy.get(`div[data-field="documentName"]:contains('${row['Document Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
                        .next(`div[data-field="agreementRequired"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="linked"]`)
                .next(`div[data-field="published"]`)
                .next(`div[data-field="archived"]`)
                        .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                        .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                          cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                        })
                    } else /* Linked and published required is checked */
                      if (row['Signature Required'] == '' && row['Linked to Q&A'] !== '' && row['Published'] !== '' && row['Archived'] == '') {
                        cy.get(`div[data-field="documentName"]:contains('${row['Document Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
                .next(`div[data-field="agreementRequired"]`)
                          .next(`div[data-field="linked"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                          .next(`div[data-field="published"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="archived"]`)
                          .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                          .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                            cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
                      } else /* Linked required is checked */
                        if (row['Signature Required'] == '' && row['Linked to Q&A'] !== '' && row['Published'] == '' && row['Archived'] == '') {
                          cy.get(`div[data-field="documentName"]:contains('${row['Document Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
                .next(`div[data-field="agreementRequired"]`)
                            .next(`div[data-field="linked"]`).children(`svg[data-testid="CheckIcon"]`).parent()
                .next(`div[data-field="published"]`)
                .next(`div[data-field="archived"]`)
                            .next(`div[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`)
                            .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
                .then(() => {
                              cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
                });
            } else {
                          throw new Error('Row details combination for table ' + tableName + ' is not yet defined.');
            }

            break;

          default:
          throw new Error(selection + ' action for table ' + tableName + ' is not defined.');
        }
        break;
    case 'media':
        switch (selection) {
        case 'Update Video': case 'Delete Video':
          cy.get(`div[data-field="title"]:contains('${row['Title']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
            .next(`div[data-field="url"]`).children(`div:contains('${row['URL Link']}')`).parent()
            .next(`div[data-field="dateAdded"]`).children(`div`).contains(convertTestDate(row['Date Uploaded'])).parent()
            .next(`div[data-field="action"]`).find(`button`).scrollIntoView().click()
              .then(() => {
              cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
              });
            break;
          default:
          throw new Error(selection + ' action for table ' + tableName + ' is not defined.');
      };
        break;
    case 'participants':
        switch (selection) {
        case 'Remove Participant': case 'Update Participant':
          cy.get(`*:contains('${row['Participant']}')`)
            .parent().next().children(`*:contains('${row['Department']}')`)
            .parent().next().children(`*:contains('${row['Email']}')`)
            .parent().next().children(`*:contains('${row['Invite Date']}')`)
            .parent().next().find(`*:contains('${row['Invite Status']}')`)
            .parent().next().children(`*:contains('${row['No. of Securities']}')`)
            .parent().next(`*:contains('${row['Accepted']}')`)
            .next(`*:contains('${row['Issued']}')`)
              .next(`[data-field="actions"]`)
            .scrollIntoView().should('be.visible').click()
              .then(() => {
              cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
              });
            break;
          default:
          throw new Error(selection + ' action for table ' + tableName + ' is not defined.');
        }
        break;
    case 'holdings summary table':
        switch (selection) {
        case 'Edit Investor':
          cy.get(`*:contains('${row['Shareholder Name']}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
            .next(`*:contains('${row['Shareholder Name 2']}')`)
            .next(`*:contains('${row['Group Name']}')`)
            .next(`*:contains('${row['Employee']}')`)
            .next(`*:contains('${row['Primary Email Address']}')`)
            .next(`*:contains('${row['Total Securities']}')`)
              .next()
            .next(`*:contains('${row['In Wallet']}')`)
            .next(`div[data-field="action"]`).find(`button`).first().scrollIntoView().click()
              .then(() => {
              cy.get(`ul[role="menu"]`).children(`li[role="menuitem"]:contains('${selection}')`).click();
              });
            break;
          default:
          throw new Error(selection + ' action for table ' + tableName + ' is not defined.');
        }
        break;
      default:
      throw new Error(tableName + ' table is not defined.');
    }
});

When(`in '{}' page, '{}' tab, '{}' action for '{}' question is selected`, (pageName: string, tabName: string, action: string, question: string) => {
  cy.get(`*:contains('${question}')`).next(`#q-and-a-menu-button`).click().then(() => {
        cy.get(`li[role="menuitem"]:contains('${action}')`).click();
  })
      });

When(`in '{}' table, '{}' is pressed`, (tableName: string, selection: string) => {
    switch (tableName) {
    case 'General Documents':
      cy.get('h4:contains("General Documents")').parent().within(() => {
        cy.get(`div[data-field="documentName"]:contains('${selection}')`).click();
      })
        break;
    case 'Legal Documents':
      cy.get('h4:contains("Legal Documents")').parent().within(() => {
        cy.get(`div[data-field="documentName"]:contains('${selection}')`).click();
      })
        break;
      default:
      throw new Error(tableName + ' table is not defined.');
    }
});

// Not sure why the / or expression stopped working, splitting the step definition
When(`in '{}' page, '{}' section, '{}' button is pressed`, (pageName: string, sectionName: string, button: string) => {
    const section = sectionName;
    switch (pageName.toLowerCase()) {
    case 'esop': // ESOP page / ESOP Pool section
        cy.get(`button:contains('${button}')`).click();
        break;
      default:
      throw new Error(pageName + ' page is not defined.');
  };
});

When(`in '{}' page, '{}' tab, '{}' button has mouse over`, (pageName: string, sectionName: string, button: string) => {
    const section = sectionName;
    switch (pageName.toLowerCase()) {
    case 'esop offer':
      cy.get(`button:contains('${button}')`).parent('span').invoke('show').click({ force: true });
        break;
      default:
      throw new Error(pageName + ' page is not defined.');
  };
});

When(`in '{}' page, '{}' tab, '{}' {} is pressed`, (pageName: string, sectionName: string, button: string) => {
    const section = sectionName;
    switch (pageName.toLowerCase()) {
    case 'esop offer':  // ESOP Offer page / Documents & Media tab
        cy.get(`button:contains('${button}')`).click();
        break;
    case 'my wallets':
        cy.get(`span:contains('${button}')`).click();
        break;
      default:
      throw new Error(pageName + ' page is not defined.');
  };
});

When(`in '{}' page, '{}' tab, '{}' action is selected`, (pageName: string, sectionName: string, selection: string) => {
    const section = sectionName;
    switch (pageName.toLowerCase()) {
     case 'esop offer':  // ESOP Offer page / Details tab
      cy.get(`button[aria-label="bid-table-actions"]:contains('Action')`).click();
      cy.get(`div[data-testid="sentinelStart"]`).next().find(`li:contains('${selection}')`).eq(0).click();
        break;
     default:
      throw new Error(pageName + ' page is not defined.');
  };
});

When(`in '{}' tab, '{}' is pressed`, (tabName: string, selection: string) => {
  switch (tabName.toLowerCase()) {
   case 'participants':  
    switch(selection.toLowerCase()){
     case 'issue securities':
       cy.get(`span:contains('${selection}')`).click();
       break;
    }
    break;
   default:
    throw new Error(tabName + ' tab is not defined.');
};
});

When(`in '{}' page, '{}' tab, '{}' action should not be displayed`, (pageName: string, sectionName: string, selection: string) => {
    const section = sectionName;
    switch (pageName.toLowerCase()) {
    case 'esop offer':  // ESOP Offer page / Details tab
      cy.get(`button[aria-label="bid-table-actions"]:contains('Action')`).click();
      cy.get(`div[data-testid="sentinelStart"]`).next().find(`li:contains('${selection}')`).should('not.exist');
        break;
      default:
      throw new Error(pageName + ' page is not defined.');
  };
});

When(`in '{}' pop-up, '{}' checkbox is {}`, (dialogLabel: string, checkLabel: string, state: string) => {

    // Do nothing if nothing entered
  if (state == '') { return; }
  else {
      let checked: boolean;
      switch (state.toLowerCase()) {
      case 'checked': case 'enabled':
          checked = true;
        break
      case 'unchecked': case 'disabled':
          checked = false;
        break
        default:
        throw new Error(state + ' for checkbox is invalid.');

      }
      switch (dialogLabel.toLowerCase()) {
      case 'create offer': case 'edit offer':
          // Security ID
          switch (checkLabel) {
          case 'Grant Date not Applicable':
              if (checked) {
                cy.get(`[name="grantDateNotApplicable"]`).check();
              } else {
                cy.get(`[name="grantDateNotApplicable"]`).uncheck();
              }
              break;
          case 'Expiry Date not Applicable':
              if (checked) {
                cy.get(`[name="expiryDateNotApplicable"]`).check();
              } else {
                cy.get(`[name="expiryDateNotApplicable"]`).uncheck();
              }
              break;
          case 'Issue Price not Applicable':
            if (state.toLowerCase() === 'disabled') {
              cy.get(`input[name="issuePriceNotApplicable"]`).should('be.disabled');
              } else if (checked) {
                cy.get(`input[name="issuePriceNotApplicable"]`).click().check();
              } else {
              cy.get(`input[name="issuePriceNotApplicable"]`).click().uncheck();
              }
              break;
          case 'Exercise Price not Applicable':
            if (state.toLowerCase() === 'disabled') {
              cy.get(`[name="exercisePriceNotApplicable"]`).should('be.disabled');
              } else if (checked) {
                cy.get(`[name="exercisePriceNotApplicable"]`).check();
              } else {
                cy.get(`[name="exercisePriceNotApplicable"]`).uncheck();
              }
              break;
            default:
            throw new Error(checkLabel + ' checkbox label not defined.');
          }
          break;
      case 'upload new document': case 'edit document': case 'add investor': case 'edit investor':
          if (checked) {
          cy.get(`*:contains('${checkLabel}')`).prev('span').children('input').check();
          } else {
          cy.get(`*:contains('${checkLabel}')`).prev('span').children('input').uncheck();
          }
          break;
      case 'two-factor authentication':
          if (checked) {
          cy.get(`h4:contains('${checkLabel}')`).parent(`div`).prev(`div`).children('svg').click()
          }
          break;
        default:
        throw new Error(dialogLabel + ' dialog label not defined.');
      }
    } //if
});

When(`in '{}' pop-up, {} radio is selected for '{}'`, (dialogLable: string, option: string, label: string) => {
    switch (label) {
    case 'Include Vesting Schedule':
      cy.get(`#radio-include-vesting-schedule`).next(`div`).find(`span:contains('${option}')`).click()
        break;
    case 'Employees nominates a different entity to recieve security':
      cy.get(`#radio-raiseType`).next(`div`).find(`span:contains('${option}')`).click()
        break;
    case 'Document Type':
      cy.get(`label:contains('${label}')`).next(`div`).find(`span:contains('${option}')`).click()
        break;
      default:
      throw new Error(label + ' label not defined.');
  };
});

When(`in '{}' pop-up, upload '{}' file to '{}'`, (dialogLabel: string, fileName: string, label: string) => {
    // And in  pop-up, upload file to 'UPLOAD DOCUMENT (PDF ONLY) *'

  const incFilePath: string = 'cypress/fixtures/' + fileName;
    switch (dialogLabel) {
    case 'Upload New Document':
        // if (label === 'UPLOAD DOCUMENT (PDF ONLY) *') {
      cy.fixture(
        fileName,
        null
      ).then((validFile) => {
          cy.get(`[data-testid="file-drop-zone"] div[role="presentation"]`)
            // cy.xpath(`//*[@data-testid="file-drop-zone"]`)
            .click()
            .then(() => {
            cy.get("input[type=file]")
              .selectFile(
                incFilePath
                // {
                //   contents: Cypress.Buffer.from(validFile),
                //   fileName: fileName,
                //   mimeType: "application/pdf",
                //   lastModified: Date.now(),
                // }
                , { force: true }
              );
          })
        });
        // };
        break;
    case 'Add Participants (Bulk Import)':
      cy.fixture(
        fileName,
        null
      ).then((validFile) => {
          // cy.get(`[data-testid="file-drop-zone"] div[role="presentation"]`)
          // .click()
          // .then(() => {
        cy.get(`input[title="File Upload"][type=file]`)
          .selectFile(
            incFilePath
            , { force: true }
          );
          // })
        });

        break;
      default:
      throw new Error(dialogLabel + ' dialog label not defined.');
  };
});

When(`in {} offer page, {} on status '{}'`, (pageName: string, action: string, statusName: string) => {
    switch (action) {
    case 'hover':
        cy.get(`p`)
        .contains((new RegExp("^" + statusName + "$", "g")))
        .should('be.css', 'color', 'rgb(255, 255, 255)').trigger(`mouseover`);

        break;
      default:
      throw new Error(action + ' action not defined.');
  };
});

When(`in '{}' status pop-up, '{}' button is pressed`, (statusName: string, buttonText: string) => {
    switch (statusName) {
    case 'Setup':
    case 'Open':
        cy.get(`button:contains('${buttonText}')`)
          // .parent()
          // .parent()
          // .find(`p`)
          // .contains((new RegExp("^" + statusName + "$", "g")))
          // .and('have.css','color', 'rgb(50, 161, 66)')
          .click();
        break;
    case 'Closed':
        cy.get(`button:contains('${buttonText}')`).click();
        break;
      default:
      throw new Error(statusName + ' status is not yet defined.');
    }
});

When(`alert pop-up, {}, '{}' is closed`, (status: string, message: string) => {
  switch (status.toLowerCase()) {
    case 'success': case 'error':
      cy.get(`[data-testid="snackbar"][data-severity="${convertToCamelCase(status)}"]`).scrollIntoView().find(`div:contains('${message}')`).should('be.visible').next().find(`svg[data-testid="CloseIcon"]`).parent('button').click();
      break;
    default:
      throw new Error(status + ' status is not defined');
  };

});

When(`alert pop-up, {}, '{}' is pressed`, (message: string, button: string) => {
  switch (message.toLowerCase()) {
    case 'close offer':
    cy.get(`[role="dialog"][id="close-offer"]`).find(`button:contains('${button}')`).click()
      break;
    case 'close offer confirmation':
     cy.get(`[role="dialog"][id="close-offer-confirmation"]`).find(`button:contains('${button}')`).click()
     cy.intercept('POST','**/api/v1/esop/getESOPParticipants**').as('status');
     cy.wait(['@status']);
      break;
    case 'confirm security issuance':
     cy.intercept('POST','**/api/v1/esop/issueESOP**').as('issue');
     cy.get(`[data-testid="button-next"]:contains('${button}')`).click();
     cy.wait(['@issue']);
     break;
    case 'congratulations!':
      cy.get(`span:contains('${message}')`)
        .parent().parent().find(`button:contains('${button}')`).click()
      break;
    case "delete offer":
      cy.get(`[data-testid="button-remove"]:contains('${button}')`).click();
      break;
    case "delete plan":
      cy.get(`[data-testid="button-remove"]:contains('${button}')`).click();
      break;
    case "accept":
      cy.get(`[data-testid="button-remove"]:contains('${button}')`).click();
      break;
    case "save template confirmation":
        if (button.toLowerCase() === "save") {
            cy.intercept('POST','**/api/v1/admin**',(req) => {
                req.alias = req.body.method;
                console.log();
            });
        }
        cy.get(`[role="dialog"][id="save-template"]`).find(`button:contains('${button}')`).click();
        if (button.toLowerCase() === "save") {
            cy.wait('@createEmailTemplate');
        }
      break;
    case "remove template confirmation":
        cy.get(`[role="dialog"][id="remove-template"]`).find(`button:contains('${button}')`).click();
        break;
    case "send email preview":
        cy.get(`[role="dialog"][id="send-email-preview"]`).find(`button:contains('${button}')`).click();
        break;
    default:
      throw new Error(message + 'message is not defined');
  };

});

When(`in '{}' pop-up, '{}' data is entered`, (dialogLabel: string, investor: string) => {
  const investorFixture: string = 'users/' + investor.toLowerCase();
    switch (dialogLabel) {
    case 'Edit Investor':
    case 'Add Investor':
      cy.fixture(investorFixture)
        .then((investor) => {
          const investorType = investor.type.toLowerCase();
          cy.get(`label:contains('Shareholder Type')`).next().children(`div`).click().then(() => {
            cy.get(`li[role="option"]:contains('${investorType.toUpperCase()}')`).click();
            });

          if (investorType != 'company') {
            cy.get(`input[name="firstName"]`).clear().type(investor.firstName);
            if (investor.middleName) cy.get(`input[name="middleName"]`).clear().type(investor.middleName);
            cy.get(`input[name="lastName"]`).clear().type(investor.lastName);
            if (investorType == 'joint') {
              cy.get(`input[name="additionalShareholders[0].firstName"]`).clear().type(investor.addShareholderFirstName);
              if (investor.addShareholderMiddleName) cy.get(`input[name="additionalShareholders[0].middleName"]`).clear().type(investor.addShareholderMiddleName);
              cy.get(`input[name="additionalShareholders[0].lastName"]`).clear().type(investor.addShareholderLastName);
            }
          } else {
            cy.get(`input[name="companyName"]`).clear().type(investor.companyName);
            cy.get(`label:contains('Company Identifier Number')`).next().children(`input`).clear().type(investor.companyAcn);
            cy.get(`label:contains('Company Identifier Type')`).next().children(`div`).click().then(() => {
                cy.get(`li[role="option"]:contains('ACN')`).click();
              });
            cy.get(`label:contains('Company Contact Person')`).next().children(`input`).clear().type(investor.contactPerson);
          }
          cy.get(`label:contains('Contact Number')`).next().children(`input`).clear().type(investor.contactNumber);
          cy.get(`label:contains('Email Address')`).next().children(`input`).clear().type(investor.email);
          const country = investor.country.toUpperCase();
          cy.get(`label:contains('Country')`).next().children(`input`).click().clear().type(country).then(() => {
              cy.get(`li[role="option"]:contains('${country}')`).click();
            });
          cy.get(`label:contains('State')`).next().children(`div`).click().then(() => {
            cy.get(`li[role="option"]:contains('${investor.state.toUpperCase()}')`).click();
            });
          cy.get(`label:contains('Address Line 1')`).next().children(`input`).clear().type(investor.addressLine1);
          cy.get(`label:contains('Address Line 2')`).next().children(`input`).clear().type(investor.addressLine2);
          cy.get(`label:contains('Suburb')`).next().children(`input`).clear().type(investor.suburb);
          cy.get(`label:contains('Postcode')`).next().children(`input`).clear().type(investor.postcode);
          if (investor.hasEmployeeHolding) {
            cy.get("[type=\"checkbox\"]").get("input[name=\"employee.enabled\"]").check({ force: true });
            if (investorType.toLowerCase() == 'individual') {
              const elem = cy.get("[type=\"checkbox\"]").get("input[name=\"employee.sameAsHolderName\"]");
              investor.employeeNameSameAsAbove ? elem.check() : elem.uncheck();
            }
            if (!investor.employeeNameSameAsAbove) {
              cy.get(`input[name="employee.firstName"]`).clear().type(investor.employeeFirstName);
              if (investor.employeeMiddleName) cy.get(`input[name="employee.middleName"]`).clear().type(investor.employeeMiddleName);
              cy.get(`input[name="employee.lastName"]`).clear().type(investor.employeeLastName);
            }
          }
        })
        break;
      default:
      throw new Error(dialogLabel + ' dialog label not defined.');
    }
})

When(`in '{}' pop-up, {} is selected in '{}' list`, (dialogLabel: string, itemName: string, listName: string) => {
    switch (listName.toLowerCase()) {
    case 'all existing employee': case 'employees selected to participate':
      cy.get(`h4:contains('${listName}')`).parent().parent().within(() => {
            if (itemName.toLowerCase() === "all employees") {
              cy.get(`input[aria-label="all items selected"]`).check();
            } else {
          cy.get(`span:contains('${itemName}')`).parent().parent().find(`input[type=checkbox]`).check();
            }
          });
        break;
      default:
      throw new Error(listName + ' list is not defined');
    }
});

When(`in 'Investor' table, '{}' data is archived`, (investor: string) => {
  const investorFixture: string = 'users/' + investor.toLowerCase();
  cy.fixture(investorFixture)
    .then((investor) => {
      cy.get("input[placeholder=\"Search…\"]")
        .focus()
        .clear();
      cy.intercept(
        "POST",
        'api/v1/issuer',
        (request) => {
      if (request.body.method === "getIssuerHolders") {
        request.alias = "getIssuerHolders";
      }
        }
      );
      cy.get("input[placeholder=\"Search…\"]")
      .focus()
        .type(
          investor.email,
          { delay: 0 }
        );
      cy.get(".MuiDataGrid-virtualScroller").scrollTo(
        "right",
        { duration: 0 }
      );
    cy.wait("@getIssuerHolders");
      cy.get(`[role="cell"][data-field="emailAddress"]`).first().contains(investor.email.toUpperCase());
      cy.get(`[role="cell"][data-field="action"]`).first().trigger("mouseover").click();
      cy.contains(
        "li",
        "Edit Investor"
      ).trigger("mouseover").click();
      cy.get("[type=\"checkbox\"]").get("input[name=\"employee.enabled\"]").uncheck();
    const archivedEmail = "fcx.tester+archived@fcx.com.au";
      cy.get(`label:contains('Email Address')`).next().children(`input`).clear().type(archivedEmail);
    cy.get(`button:contains('Save')`).click();
  });
});

When(`in '{}' pop-up, get, store and enter OTP for {}`, (dialogLabel: string, userName: string) => {
  cy.get(`img[alt="TOTP"]`).should('be.visible');

  cy.get(`img[alt="TOTP"]`).invoke('attr', 'src')
      .then((src) => {
        cy.log(src);
      let url = src?.split('secret%3D');
        cy.log(url[1]);
        let secret: string = url[1];

        // Store secret to user
      const userFixture: string = Cypress.env('ENV') + '/users/' + userName.toLowerCase()
      cy.fixture(userFixture)
        .then((userDetails) => {
          cy.log(JSON.stringify(userDetails));
          userDetails.secret = secret;
          cy.log(JSON.stringify(userDetails));
          cy.writeFile(('cypress/fixtures/' + userFixture + 'OTP.json'), JSON.stringify(userDetails), 'ascii');
        });

        // Generate and enter OTP
      cy.task("generateOTP", secret).then(token => {
        cy.get(`[data-testid="action"]`).find(`input[type="number"]`).eq(0).type(token[0]);
        cy.get(`[data-testid="action"]`).find(`input[type="number"]`).eq(1).type(token[1]);
        cy.get(`[data-testid="action"]`).find(`input[type="number"]`).eq(2).type(token[2]);
        cy.get(`[data-testid="action"]`).find(`input[type="number"]`).eq(3).type(token[3]);
        cy.get(`[data-testid="action"]`).find(`input[type="number"]`).eq(4).type(token[4]);
        cy.get(`[data-testid="action"]`).find(`input[type="number"]`).eq(5).type(token[5]);
        });
      });


  cy.intercept('GET', `/chart?**`).as('googleOTP');
    // cy.wait('@googleOTP')
    cy.intercept(`/chart?**`, (res) => {
      cy.log(res.body);
    });
});

When(`in {}, '{}' tab is pressed`, (loc: string, text: string) => {
  switch (text.toLowerCase()) {
    case 'participants':
       cy.get(`[role="tab"][id="esop-offer-tab-2"]`).should('be.visible');
       cy.get(`[role="tab"][id="esop-offer-tab-2"]:contains('${text}')`).click();
     break;
   default:
      cy.get(`button:contains('${text}')`).click(); }
});


When(`in ESOP offer, {} section, more '{}' is pressed for {}`, (text: string, operation: string,offer: string) => {
   
    switch (operation) {
       case 'Publish Document':
         cy.get(`[role="cell"][data-field="documentName"]`).contains(text).parent().find(`[data-testid="MoreVertIcon"]`).click()
         cy.get(`[role="menuitem"]`).contains(operation).click();
         cy.get(`[data-testid="button-remove"]`).click()
        break;
      case 'Send Invite':
         cy.get(`[role="cell"][data-field="name"]:contains('${text}')`).parent().parent().find(`[data-testid="MoreVertIcon"]`).click()
         cy.get(`[role="menuitem"]`).contains("Send Invite").click();
         cy.intercept('POST','**/api/v1/invite**',(req) =>{
             req.alias = req.body.method;
         });
         cy.get(`[data-testid="button-remove"]`).click();
         cy.wait('@sendInvite').then((intercept) => {
         let token = ''
         cy.log(intercept.response?.body.result.token)
         token = intercept.response?.body.result.token
         Cypress.env('INVITE_TOKEN' + offer ,token)
         cy.log(Cypress.env('INVITE_TOKEN' + offer))

        })
        break;
      default:
         throw new Error(operation + ' operation is not defined');
    }
});


When(`in '{}' pop-up, enter 6-digit code from Authentication app for {}`, (dialogLabel: string, userName: string) => {
  const userFixture: string = Cypress.env('ENV') + '/users/' + userName.toLowerCase()
  cy.fixture(userFixture)
    .then((userDetails) => {
      // Generate and enter OTP
      cy.task("generateOTP", userDetails.secret).then(token => {
        cy.get(`p:contains('Please enter the 6-digit code from your authenticator app.')`).next().find(`input[type="number"]`).eq(0).type(token[0]);
        cy.get(`p:contains('Please enter the 6-digit code from your authenticator app.')`).next().find(`input[type="number"]`).eq(1).type(token[1]);
        cy.get(`p:contains('Please enter the 6-digit code from your authenticator app.')`).next().find(`input[type="number"]`).eq(2).type(token[2]);
        cy.get(`p:contains('Please enter the 6-digit code from your authenticator app.')`).next().find(`input[type="number"]`).eq(3).type(token[3]);
        cy.get(`p:contains('Please enter the 6-digit code from your authenticator app.')`).next().find(`input[type="number"]`).eq(4).type(token[4]);
        cy.get(`p:contains('Please enter the 6-digit code from your authenticator app.')`).next().find(`input[type="number"]`).eq(5).type(token[5]);
      });
      });
    });
