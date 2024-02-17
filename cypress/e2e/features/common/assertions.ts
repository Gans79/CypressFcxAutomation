/// <reference types="@cypress/xpath" />
import { DataTable, When, Then } from "@badeball/cypress-cucumber-preprocessor";
import { convertTestDate, convertToCamelCase } from '../../../support/utils';
import '../../../support/commands'
import { replaceDateExpression, convertDateToDD_Mon_YYYY } from "../../../support/utils";

When(`loading/progress is complete`, () => {
  cy.get(`span[role="progressbar"]`).should('not.be.visible');
});

When(`'{}' button is not displayed`, (buttonText: string) => {
  cy.get(`button:contains('${buttonText}')`, { timeout: Cypress.env('MAX_TIMEOUT') }).should('not.exist');
});

Then(`alert pop-up, {}, '{}' is displayed`, (status: string, message: string) => {
  switch (status.toLowerCase()) {
    case 'success':
      cy.get(`[data-testid="snackbar"][data-severity="${status.toLowerCase()}"]`).find(`*:contains('${message}')`).should('be.visible');
      break;
    case 'error':
      cy.get(`[data-testid="error"]`).find(`span:contains('${message}')`).scrollIntoView().should('be.visible');
      break;
    case 'file could not be uploaded':
      cy.get(`div[role="alert"]`).find(`p:contains('${message}')`).scrollIntoView().should('be.visible');
      break;

    default:
      throw new Error(status + ' status is not defined');
  };
});

Then(`status banner, {}, '{}' is displayed`, (status: string, message: string) => {
  switch (status.toLowerCase()) {
    case 'error':
      cy.get(`[data-testid="error"]`).children(`div`).last().find(`span:contains('${message}')`).should('be.visible');
      break;
    default:
      throw new Error(status + ' status is not defined');
  };
});

Then(`status banner, {}, '{}' is NOT/not displayed`, (status: string, message: string) => {
  switch (status.toLowerCase()) {
    case 'error':
      cy.get(`[data-testid="error"]`).children(`div`).last().find(`span:contains('${message}')`).should('not.exist');
      break;
    default:
      throw new Error(status + ' status is not defined');
  };
});

Then(`'{}' {} is displayed`, (title: string, attrib: string) => {
  switch (attrib.toLowerCase()) {
    case 'main header':
      // cy.get(`h1`).should('contain', title);
      cy.get(`h1:contains('${title}')`).should('be.visible')
      break;
    case 'tab header': case 'secondary title':
      cy.get(`h2`).should('contain', title);
      // cy.findByTitle(title).should('be.visible');
      break;
    case 'title page': case 'tab title':
      cy.get(`h3`).should('contain', title);
      // cy.findByDisplayValue(title).should('be.visible');
      break;
    case 'table content':
      cy.get(`h5`).should('contain', title);
      break;
    case 'checkbox':
      cy.get(`p:contains('${title}')`).first()
        .parents('label')
        .find(`input[type=checkbox][name=${title.toLowerCase()}]`).parent('span')
        .should('be.visible');
      break;
    case 'pop-up':
      cy.get(`h3[data-testid="dialog-labelledby"]:contains('${title}')`)
        .should('be.visible');
      break;
    case 'button':
      cy.get(`button`).should('contain', title);
      break;
    case 'info box':
      cy.get(`[aria-label="${title}"]`).should('exist');
      break;
    case 'text': case 'name':
      cy.contains(title).scrollIntoView().should('be.visible');
      break
    case 'table content':
      cy.contains(title).should('exist');
      break;
    case 'youtube video':
      let splitTitle;
      // Manage youtu.be or www.youtube.com/watch?v=
      if (title.includes('www.youtube.com/watch?v=')) {
        splitTitle = title.split('www.youtube.com/watch?v=');
        cy.log('1:', splitTitle[0], ' : ', splitTitle[splitTitle.length - 1], splitTitle.length - 1);
        cy.get(`*:contains('<iframe> placeholder for https://www.youtube.com/embed/${splitTitle[splitTitle.length - 1]}?autoplay')`).should('be.visible');

      } else if (title.includes('youtu.be')) {
        splitTitle = title.split('/youtu.be/');
        cy.log('1:', splitTitle[0], ' : ', splitTitle[1], splitTitle.length - 1);
        cy.get(`*:contains('<iframe> placeholder for https://www.youtube.com/embed/${splitTitle[splitTitle.length - 1]}?autoplay')`).should('be.visible');
      } else {
        cy.get(`video[src="${title}"]`, { timeout: Cypress.env('LOAD_VIDEO_TIMEOUT') }).should('exist').then(() => {
          cy.get(`video`).should('be.visible')
        });
      }
      break;
    case 'youtube video title':
      cy.get(`a:contains('${title}')` /*, { timeout: Cypress.env('LOAD_VIDEO_TIMEOUT') }*/).should('exist');
      break;
    default:
      throw new Error(attrib + ' page attribute is not defined');
  }
});

Then(`URL contains '{}'`, (text: string) => {
  cy.url().should('contain', text);
});

Then(`in {} menu '{}' is not visible`, (menu: string, text: string) => {
  switch (menu.toLowerCase()) {
    case "company":
      switch (text.toLowerCase()) {
        case 'esop':
          cy.get(`span:contains('${text}')`).should('not.be.exist');
          break
      }
      break;
    default:
      throw new Error(menu + ' menu is not found');
  }
});

When(`in '{}' page, '{}' tab, '{}' is displayed for {}`, (pageName: string, tabName: string, text: string, label: string) => {
  let splitLabel: {};
  switch (label) {
    case 'Plan Name': case 'Description': case 'Security ID':
    case 'Issue Price':
    case 'Exercise Price':
      cy.get(`*:contains('${text}')`).should('be.visible');
      break;
    case 'Type':
    case 'Frequency':
    case 'Vesting Amount':
      cy.get(`*:contains('${text.toUpperCase()}')`).should('be.visible');
      break;
    case 'Grant Date':
    case 'Close Date':
    case 'Expiry Date':
      cy.get(`*:contains('${convertDateToDD_Mon_YYYY(convertTestDate(text))}')`).should('be.visible');
      break;
    case 'Vesting':
      let vesting: {} = text.split(' on ');
      cy.log('convertTestDate(vesting[1]): ' + convertTestDate(vesting[1]));
      let vestingString: string = vesting[0] + ' on ' + convertDateToDD_Mon_YYYY(convertTestDate(vesting[1]));
      cy.get(`*:contains('${vestingString}')`).should('be.visible');
      break;
    // Participants tab
    case 'Total Participants':
    case 'Securities Accepted':
    case 'Securities Declined':
    case 'Securities Issued':
      cy.get(`span:contains('${label}')`)
        .prev(`p:contains('${text}')`).should('be.visible');
      break;
    case 'Total Participants - Securities':
      splitLabel = label.split(' - ')
      cy.log(splitLabel[0], '-', splitLabel[1]);
      cy.get(`span:contains('${splitLabel[0]}')`)
        .parent()
        .next(`hr`)
        .next(`div`)
        .find(`span:contains('${splitLabel[1]}')`)
        .prev(`span:contains('${text}')`).should('be.visible');
      break;
    case 'Participants Invited':
      cy.get(`span:contains('${label}')`)
        .prev(`div`)
        .children(`p:contains('${text}')`)
        .should('be.visible');
      break;
    case 'Participants Invited - Accepted':
    case 'Participants Invited - Declined':
    case 'Participants Invited - Cancelled':
      splitLabel = label.split(' - ')
      cy.log(splitLabel[0], '-', splitLabel[1]);
      cy.get(`span:contains('${splitLabel[0]}')`)
        .parent()
        .next(`div`)
        .next(`div`)
        .find(`span:contains('${splitLabel[1]}')`)
        .parent()
        .find(`span:contains('${text}')`)
        .should('be.visible');
      break;
    case 'Securities Accepted - Participants':
    case 'Securities Declined - Participants':
    case 'Securities Issued - Participants':
      splitLabel = label.split(' - ')
      cy.log(splitLabel[0], '-', splitLabel[1]);
      cy.get(`span:contains('${splitLabel[0]}')`)
        .parent()
        .next(`div`)
        .next(`span:contains('${splitLabel[1]}')`)
        .parent()
        .find(`span:contains('${text}')`)
        .should('be.visible');
      break;
    default:
      throw new Error(label + ' field label is not defined');
  }
});

Then(`in '{}' section, '{}' is displayed`, (section: string, text: string) => {
  switch (section.toLowerCase()) {
    case 'current plans':
      cy.get(`h2:contains('${section}')`).parent(`div`).parent(`div`).contains(text).should('be.visible');
      break;
    default:
      throw new Error(section + ' section is not defined');
  }
});

Then(`in '{}' pop-up, '{}' table, displays details`, (modalName: string, tableName: string, dataTable: DataTable) => {
  switch (tableName) {
    case 'File could not be uploaded':
      let count: number = 0;
      let row = dataTable.raw()
      row.forEach((elem, count) => {
        cy.get(`#bulk-participants-upload-error-dialog`).find(".MuiGrid2-container")
          .within(() => {
            cy.get(".MuiGrid2-grid-xs-5").eq(count).contains(row[count][0]);
            cy.get(".MuiGrid2-grid-xs-3").eq(count).contains(row[count][1]);
            cy.get(".MuiGrid2-grid-xs-8").eq(count).contains(row[count][2]);
          });
      });
      break;
    default:
      throw new Error(tableName + ' table is not defined');
  }
});

Then(`'{}' table, displays details`, (section: string, dataTable: DataTable) => {
  let row = {};
  let propValue;
  // let ESOProw: IESOPTa
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
        cy.log(propName, propValue, row[propName]);
      }
    });

  switch (section.toLowerCase()) {
    case 'esop':
      /* validate table data */
      cy.get(`div[data-field="issuerName"]`).find(`*:contains('${row['Company']}')`)
         .parent().parent().children(`*:contains('${row['Plan Name']}')`)
         .parent().children(`*:contains('${convertTestDate(row['Created'])}')`)
         .parent().children(`*:contains('${row['Status']}')`)
      break;
    case 'participants':
      let date = (convertTestDate(row['Invite Date']));
      cy.log(date);
      if(date)
      {
      cy.get(`[role="cell"]:contains('${row['Participant']}')`)
        .next(`[role="cell"]:contains('${row['Department']}')`)
        .next(`[role="cell"]:contains('${row['Email']}')`)
        .next(`[role="cell"]:contains('${convertDateToDD_Mon_YYYY(date)}')`)
        .next(`[role="cell"]:contains('${row['Invite Status']}')`)
      } 
      else
      {
      cy.get(`[role="cell"]:contains('${row['Participant']}')`)
       .next(`[role="cell"]:contains('${row['Department']}')`)
       .next(`[role="cell"]:contains('${row['Email']}')`)
       .next(`[role="cell"]:contains('${row['Invite Date']}')`)
       .next(`[role="cell"]:contains('${row['Invite Status']}')`)  
      }
      cy.get(`[role="cell"]:contains('${row['Participant']}')`)
        .next().next().next().next().next(`[role="cell"]:contains('${row['No. of Securities']}')`)
      if((row['Accepted'].toLowerCase()) === "dash"){
        cy.get(`[role="cell"]:contains('${row['Participant']}')`)
        .next().next().next().next().next().next(`[data-field="accepted"]`)
      } else if ((row['Accepted'].toLowerCase()) === "check"){
       cy.get(`[role="cell"]:contains('${row['Participant']}')`)
       .next().next().next().next().next().next().find(`[data-testid="CheckIcon"]`)
      }
      if((row['Issued'].toLowerCase()) === "check"){
        cy.get(`[role="cell"]:contains('${row['Participant']}')`)
        .next().next().next().next().next().next().next().find(`[data-testid="CheckIcon"]`)
      } 
      break;
    case 'media':
      cy.get(`*:contains('${row['Title']}')`)
        .parent().next().children(`*:contains('${row['URL Link']}')`)
        .parent().next(`[data-field="dateAdded"]`).find(`*:contains('${convertTestDate(row['Date Uploaded'])}')`)
        .scrollIntoView().should('be.visible');
      break;
    case 'signatories':
      cy.get(`*:contains('${row['Name']}')`)
        .parent().next().children(`*:contains('${row['Email']}')`)
        .parent().next()
        .next().should('be.visible');
      break;
    default:
      throw new Error(section + ' section table is not defined.');
  }
});


Then(`inside Participant '{}' tab, displays details for status '{}'`, (tab: string, status: string, dataTable: DataTable) => {
  let row = {};
  let propValue;
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
        cy.log(propName, propValue, row[propName]);
      }
    });

  switch (tab.toLowerCase()) {
    case 'my offer': 
      switch (status.toLowerCase()) {
        case 'open': 
          cy.get(`h3:contains('${row['Offer Name']}')`)
            .parent().next().find(`:contains('${row['Plan Name']}')`)
            .parent().next().children(`:contains('${row['Security Class']}')`)
            .parent().children(`:contains('${row['Number of Securities']}')`)
            .parent().next().children(`[type='${row['Accept']}']:contains('Accept')`)
            .parent().children(`[type='${row['Decline']}']:contains('Decline')`)
          break;
        case 'closed': 
          cy.get(`h3:contains('${row['Offer Name']}')`)
            .next().children(`:contains('Cancelled')`)
            .parent().parent().next().find(`:contains('${row['Plan Name']}')`)
            .parent().next().children(`:contains('${row['Security Class']}')`)
            .parent().children(`:contains('${row['Number of Securities']}')`)
          cy.get(`[type="button"]:contains('Accept)`).should('not.exist')
          cy.get(`[type="button"]:contains('Decline)`).should('not.exist')
          break;
        case 'open and signed': 
          cy.reload()
          cy.get(`span:contains('Signature')`)
            .parent().next().find(`[role="cell"]:contains('${row['Name']}')`)
            .next(`[role="cell"]:contains('${row['Email']}')`)
            .next().find(`svg[data-testid="MarkEmailReadIcon"]`)
            .parent().next(`[data-field="completedDateTime"]:contains('${convertTestDate(row['Date Signed'])}')`)
          break;
        default:
          cy.get(`h4:contains('Offer History')`).next().find(`[role="cell"]:contains('${row['Security Class']}')`);
          cy.get(`h4:contains('Offer History')`).next().find(`[role="cell"]:contains('${row['Securities']}')`);
          cy.get(`h4:contains('Offer History')`).next().find(`[role="cell"]:contains('${row['Status']}')`);
          break;
      }
      break;
    case 'details': 
      switch (status.toLowerCase()) {
        case 'open':  
         let date = (convertTestDate(row['Grant Date']));
         cy.get(`span:contains('Offer Overview')`).next().children(`:contains('${row['Plan Name']}')`)
           .parent().children(`:contains('${row['Offer Description']}')`)
           .parent().parent().next().children(`:contains('${row['Security']}')`)
           .parent().children(`:contains('${convertDateToDD_Mon_YYYY(date)}')`)
           .parent().next().children(`:contains('${row['Vesting Schedule']}')`)
           .parent().children(`:contains('${row['Description']}')`)
         break;
        case 'closed':
          cy.get(`span:contains('Offer Overview')`).next().children(`:contains('${row['Plan Name']}')`)
          .parent().children(`:contains('${row['Offer Description']}')`)
          .parent().parent().next().children(`:contains('${row['Security']}')`)
          .parent().children(`:contains('-')`)
          .parent().next().children(`:contains('${row['Vesting Schedule']}')`)
          .parent().children(`:contains('${row['Description']}')`)
        break;
    }
     break;
    case 'documents & media': 
      switch (status.toLowerCase()) {
        case 'open' : case 'closed': 
        cy.get(`h4:contains('Legal Documents')`)
          .next().find(`div[data-field="documentName"]:contains('${row['Document Name']}')`)
          .next().find(`svg[data-testid="CheckIcon"]`)
          .parent().next().next().find(`svg[data-testid="CheckIcon"]`)
          .parent().next().next(`:contains('${convertTestDate(row['Date Uploaded'])}')`)
        break;

  }
  break;
    default:
      throw new Error(tab + ' tab is not defined.');
  }
});


Then(`'{}' table, does not display row with {}`, (tableName: string, specificObject: string, dataTable: DataTable) => {
  let row = {};
  let propValue;
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
        cy.log(propName, propValue, row[propName]);
      }
    });

  switch (tableName) {
    case 'Participants':
      cy.get(`div[data-field="${convertToCamelCase(specificObject)}"][role="columnheader"]`).find(`[aria-label]`)
        .contains((new RegExp("^" + specificObject + "$", "g")))
        .scrollIntoView().should('be.visible');
      cy.get(`div[data-field="${convertToCamelCase(specificObject)}"][role="cell"] > div:contains('${row['Email']}')`)
        .should('not.exist');
      /* for test verify: other row exist */
      // cy.get(`div[data-field="${convertToCamelCase(specificObject)}"][role="cell"] > div:contains('fcx.tester+employee2@gmail.com')`)
      //   .should('be.visible');
      break;
    case 'General Documents': case 'Legal Documents':
      cy.get(`div[data-field="${convertToCamelCase(specificObject)}"][role="columnheader"]`).find(`[aria-label]`)
        .contains((new RegExp("^" + specificObject + "$", "g")))
        .scrollIntoView().should('be.visible');
      cy.get(`div[data-field="${convertToCamelCase(specificObject)}"][role="cell"]`)//:contains('${row[specificObject]}')`)
        .contains((new RegExp("^" + row[specificObject] + "$", "g")))
        .should('not.exist');
      /* for test verify: other row exist */
      // cy.get(`div[data-field="${convertToCamelCase(specificObject)}"][role="cell"]:contains('Clone General doc 10')`)
      //   .should('be.visible');
      break;
    default:
      throw new Error(tableName + ' table is not defined.');
  }
});

Then(`in '{}' pop-up, '{}' {} is displayed`, (dialogLabel: string, text: string, label: string) => {
  switch (dialogLabel.toLowerCase()) {
    case 'create esop': case 'esop pool': case 'edit esop':
      switch (label.toLowerCase()) {
        case 'issued capital': case 'issuer':
          cy.get(`strong:contains('${label}')`).parent().scrollIntoView().contains(text).should('be.visible');
          break;
        case 'percentage':
          cy.get(`[data-testid="field-percentage"]`).find(`input[value="${text}"]`).should('be.visible');
          break;
        case 'amount':
          cy.get(`[data-testid="field-amount"]`).find(`input[value="${text}"]`).should('be.visible');
          break;
        default:
          throw new Error(label + ' label in ' + dialogLabel + ' is not defined.');
      }
      break;
    case 'create offer': case 'edit offer':
      switch (label.toLowerCase()) {
        case 'plan':
          cy.get(`span:contains('PLAN')`).next(`p:contains('${text}')`).should('be.visible');
          break;
        default:
          throw new Error(label + ' label in ' + dialogLabel + ' is not defined.');
      }
      break;
    default:
      throw new Error(dialogLabel + ' dialog label is not defined.');
  }
});

Then(`in {}, '{}' section, displays`, (menu: string, section: string, dataTable: DataTable) => {

  let row = {};
  let propValue;
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
      }
    });

  switch (menu.toLowerCase()) {
    case 'esop':
      // TODO: check canvas ESOP Pool (Percentage)
      // TODO: verify row
      row['Total Pool'] ? cy.get(`span:contains('Total Pool')`).siblings(`div`).find(`p:contains('${row['Total Pool']}')`).should('be.visible') : null;
      row['Unallocated'] ? cy.get(`span:contains('Unallocated')`).siblings(`div`).find(`p:contains('${row['Unallocated']}')`).should('be.visible') : null;
      row['Allocated'] ? cy.get(`span:contains('Allocated')`).siblings(`div`).find(`p:contains('${row['Allocated']}')`).should('be.visible') : null;
      row['Participants'] ? cy.get(`span:contains('Participants')`).siblings(`div`).find(`p:contains('${row['Participants']}')`).should('be.visible') : null;
      break;
    case 'esop offer':
      switch (section) {
        case 'General Documents':
          /* Verify */
          // TODO: verify row
          // row['Document Name'] ? cy.get(`[data-field="documentName"]:contains('${row['Document Name']}')`).should('be.visible') : null;
          // cy.get(`[data-field="documentName"]:contains('${row['Document Name']}')`)//.should('be.visible')
          cy.get(`div[data-field="documentName"]`).contains((new RegExp("^" + row['Document Name'] + "$", "g")), { timeout: Cypress.env('MAX_TIMEOUT') })
            .scrollIntoView().parent(`div[role="row"]`).within(() => {
              ((row['Linked to Q&A'].toLowerCase() === "check") || (row['Linked to Q&A'].toLowerCase() === "checked")) ? cy.get(`[data-field="linked"] > svg[data-testid="CheckIcon"]`).should('be.visible') : cy.get(`[data-field="linked"]`).children('svg').should('not.exist');
              ((row['Published'].toLowerCase() === "check") || (row['Published'].toLowerCase() === "checked")) ? cy.get(`[data-field="published"] > svg[data-testid="CheckIcon"]`).should('be.visible') : cy.get(`[data-field="published"]`).children('svg').should('not.exist');
              ((row['Archived'].toLowerCase() === "check") || (row['Archived'].toLowerCase() === "checked")) ? cy.get(`[data-field="archived"] > svg[data-testid="CheckIcon"]`).should('be.visible') : cy.get(`[data-field="archived"]`).children('svg').should('not.exist');
              row['Date Uploaded'] ? cy.get(`[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`).should('be.visible') : null;
            })
          break;
        case 'Legal Documents':
          /* Verify */
          // TODO: verify row
          // row['Document Name'] ? cy.get(`[data-field="documentName"]:contains('${row['Document Name']}')`, {timeout: 10000}).last().scrollIntoView().should('be.visible') : null;
          // cy.get(`[data-field="documentName"]:contains('${row['Document Name']}')`)//.should('be.visible')
          cy.get(`div[data-field="documentName"]`).contains((new RegExp("^" + row['Document Name'] + "$", "g")), { timeout: Cypress.env('MAX_TIMEOUT') })
            .scrollIntoView().parent(`div[role="row"]`).within(() => {
              ((row['Signature Required'].toLowerCase() === "check") || (row['Signature Required'].toLowerCase() === "checked")) ? cy.get(`[data-field="agreementRequired"] > svg[data-testid="CheckIcon"]`).should('be.visible') : cy.get(`[data-field="agreementRequired"] > svg[data-testid="CheckIcon"]`).should('not.exist');
              ((row['Linked to Q&A'].toLowerCase() === "check") || (row['Linked to Q&A'].toLowerCase() === "checked")) ? cy.get(`[data-field="linked"] > svg[data-testid="CheckIcon"]`).should('be.visible') : cy.get(`[data-field="linked"]`).children('svg').should('not.exist');
              ((row['Published'].toLowerCase() === "check") || (row['Published'].toLowerCase() === "checked")) ? cy.get(`[data-field="published"] > svg[data-testid="CheckIcon"]`).should('be.visible') : cy.get(`[data-field="published"]`).children('svg').should('not.exist');
              ((row['Archived'].toLowerCase() === "check") || (row['Archived'].toLowerCase() === "checked")) ? cy.get(`[data-field="archived"] > svg[data-testid="CheckIcon"]`).should('be.visible') : cy.get(`[data-field="archived"]`).children('svg').should('not.exist');
              row['Date Uploaded'] ? cy.get(`[data-field="dateUploaded"]:contains('${convertTestDate(row['Date Uploaded'])}')`).should('be.visible') : null;
            });
          break;
        default:
          throw new Error(section + ' section is not defined.');
      };
      break;
    default:
      throw new Error(menu + ' menu is not defined.');
  }
});

When(`in '{}' pop-up, '{}' file is uploaded`, (dialogLabel: string, fileName: string) => {
  switch (dialogLabel) {
    case 'Upload New Document': case 'Add Participants (Bulk Import)':
      cy.get(`[data-testid="InsertDriveFileIcon"]`).next(`h4:contains('${fileName}')`).should('be.visible');
      break;
    default:
      throw new Error(dialogLabel + ' dialog label not defined.');
  };
});

When(`verify '{}' file is downloaded`, (fileName: string) => {
  cy.readFile(Cypress.env('DOWNLOAD_CYPRESS_LOCATION') + replaceDateExpression(fileName, 'DDMMYYYY')).should('exist');

});

Then(`in '{}' table, '{}' name is displayed`, (tableName: string, selection: string) => {
  switch (tableName) {
    case 'General Documents': case 'Legal Documents':
      cy.get(`div[data-field="documentName"]:contains('${selection}')`).scrollIntoView().should('be.visible');
      break;
    default:
      throw new Error(tableName + ' table is not defined.');
  }
});

Then(`in '{}' pop-up, '{}' validation error is displayed for {}`, (dialogTitle: string, errorMessage: string, fieldLabel: string) => {
  switch (fieldLabel) {
    case 'Offer Name':
      cy.get(`[data-testid="field-${convertToCamelCase(fieldLabel)}"] > p:contains('${errorMessage}')`).scrollIntoView().should('be.visible');
      break;
    // name=CamelCase(label)
    case 'First Name': case 'Last Name':
      cy.get(`input[name="${convertToCamelCase(fieldLabel)}"]`)
        .parent().next(`p:contains('${errorMessage}')`)
        .scrollIntoView().should('be.visible')
      break;
    case 'Email':
      cy.get(`input[name="emailAddress"]`)
        .parent().next(`p:contains('${errorMessage}')`)
        .scrollIntoView().should('be.visible')
      break;
    case 'Address Line 1': case 'Suburb': case 'State': case 'Country': case 'Postcode':
      cy.get(`input[name="address.${convertToCamelCase(fieldLabel)}"]`)
        .parent().next(`p:contains('${errorMessage}')`)
        .scrollIntoView().should('be.visible')
      break;
    case 'No. of securities':
      cy.get(`input[name="totalSecurities"]`)
        .parent().next(`p:contains('${errorMessage}')`)
        .scrollIntoView().should('be.visible')
      break;
    case 'Document Name': case 'Question': case 'Title': case 'URL':
      cy.get(`label:contains('${fieldLabel}')`)
        // .contains((new RegExp("^" + fieldLabel + "$", "g")))
        .siblings(`p:contains('${errorMessage}')`)
        .scrollIntoView().should('be.visible')
      break;
    default:
      throw new Error(fieldLabel + ' field label is not defined.');
  }
});

Then(`in '{}' tab, '{}' and '{}' {} is displayed`, (tabName: string, question: string, answer: string, item: string) => {
  switch (tabName) {
    case 'Q & A':
      switch (item.toLowerCase()) {
        case 'q & a box':
          cy.get(`h4:contains('${question}')`).parent().next().find(`*:contains('${answer}')`).should('be.visible');
          break;
        default:
          throw new Error(tabName + ' display object type is not defined.');
      };
      break;
    default:
      throw new Error(tabName + ' tab is not defined.');
  }
});

Then(`in '{}' tab, '{}' {} is not displayed`, (tabName: string, text: string, item: string) => {
  switch (tabName) {
    case 'Q & A':
      switch (item.toLowerCase()) {
        case 'q & a box':
          cy.get(`h4:contains('${text}')`).should('not.exist');
          break;
        default:
          throw new Error(item + ' display object type is not defined.');
      };
      break;
    case 'Documents':
      switch (item) {
        case 'URL':
          cy.get(`*:contains('${text}')`).should('not.exist');
          break;
        default:
          throw new Error(item + ' display object type is not defined.');
      };
      break;
    case 'Cash':
      switch (item) {
        case 'text':
          cy.get(`*:contains('${text}')`, { timeout: Cypress.env('MAX_TIMEOUT') }).should('not.exist');
          break;
        default:
          throw new Error(item + ' display object type is not defined.');
      };
      break;
    default:
      throw new Error(tabName + ' tab is not defined.');
  }
});


Then(`in '{}' tab, '{}' and '{}' {} is displayed with linked documents`, (tabName: string, question: string, answer: string, item: string, dataTable: DataTable) => {

  switch (tabName) {
    case 'Q & A':
      switch (item.toLowerCase()) {
        case 'q & a box':
          // let row;
          let propValue;
          dataTable.hashes()
            .forEach(elem => {
              for (var propName in elem) {
                propValue = elem[propName];
                // row[propName] = propValue;
                cy.log(propName, propValue);

                cy.get(`h4:contains('${question}')`).parent().next().find(`*:contains('${answer}')`)  //.should('be.visible');
                  .parent().parent().parent()//.parent()//.parent()
                  .next()
                  .within(($div) => {
                    // cy.log(`row:`, row['Linked Documents']);
                    cy.contains((new RegExp("^" + propValue + "$", "g")))
                      .scrollIntoView().should('be.visible');
                  });
              }
            }
            );

          break;
        default:
          throw new Error(tabName + ' display object type is not defined.');
      };
      break;
    default:
      throw new Error(tabName + ' tab is not defined.');
  }
});

When(`in '{}' status pop-up, '{}' is {}`, (statusName: string, itemText: string, tickStatus) => {
  switch (statusName) {
    case 'Setup':
      cy.get(`p:contains('${itemText}')`).next(`svg[data-testid="CheckIcon"]`).should('be.visible');
      break;
    default:
      throw new Error(statusName + ' status is not yet defined.');
  }

});

When(`in '{}' status pop-up, '{}' with '{}' description is {}`, (statusName: string, itemText: string, descriptionText: string, tickStatus: string) => {
  switch (statusName) {
    case 'Setup':
      if (tickStatus.toLowerCase() === 'ticked') {
        cy.get(`p:contains('${itemText}')`).next(`span:contains('${descriptionText}')`).parent().next(`svg[data-testid="CheckIcon"]`).should('be.visible');
      } else if (tickStatus.toLowerCase() === 'blank') {
        cy.get(`p:contains('${itemText}')`).next(`span:contains('${descriptionText}')`).parent().next(`svg[data-testid="CheckIcon"]`).should('not.exist');
      } else {
        throw new Error(tickStatus + ' tick status is not yet defined.');
      }
      break;
    default:
      throw new Error(statusName + ' status is not yet defined.');
  }
});

When(`in '{}' status pop-up, '{}' without description is {}`, (statusName: string, itemText: string, tickStatus: string) => {
  switch (statusName) {
    case 'Setup':
      if (tickStatus.toLowerCase() === 'ticked') {
        cy.get(`p:contains('${itemText}')`).parent().next(`svg[data-testid="CheckIcon"]`).should('be.visible');
      } else if (tickStatus.toLowerCase() === 'blank') {
        cy.get(`p:contains('${itemText}')`).parent().next(`svg[data-testid="CheckIcon"]`).should('not.exist');
      } else {
        throw new Error(tickStatus + ' tick status is not yet defined.');
      }
      break;
    default:
      throw new Error(statusName + ' status is not yet defined.');
  }
});

When(`in '{}' status pop-up, '{}' button is disabled`, (statusName: string, buttonText: string) => {
  switch (statusName) {
    case 'Setup':
      cy.get(`button:contains('${buttonText}')`)
        .should('be.disabled');
      break;
    default:
      throw new Error(statusName + ' status is not yet defined.');
  }
});

Then(`downloaded csv file '{}' has {} row`, (fileName: string, rowType: string, dataTable: DataTable) => {
  const fileIncludPath: string = Cypress.env('DOWNLOAD_CYPRESS_LOCATION') + replaceDateExpression(fileName, 'DDMMYYYY');
  let rowDet: any = dataTable.raw();
  cy.readFile(fileIncludPath)
    .then(txt => txt.split('\n').map(row => row.trim())) //splitting rows
    .then((rows) => {
      let dataRows = (rowType === 'header') ? rows.slice(0, 1) : rows.slice(1);
      let rowIndex = 0;
      let columnIndex = 0
      dataRows.forEach((row) => {
        columnIndex = 0;
        row.split(',').forEach((cell) => {
          expect(String(cell).trim()).to.equal(String(rowDet[rowIndex][columnIndex]).trim());
          ++columnIndex;
        });
        ++rowIndex;
      });
    });
});

When(`in '{}' table, shows row details`, (tableName: string, dataTable: DataTable) => {
  switch (tableName) {
    case 'Participants':
      let row = dataTable.raw()
      row.forEach((elem, count) => {
        /// ignore header row
        if (count > 0) {
          cy.get(`div#esop-offer-tabpanel-2`).find(`[role="row"]`).eq(count).within(() => {
            // Transverse row
            row[count][0] != '' ? cy.get(`[data-field="name"]`).find(`div:contains('${row[count][0]}')`).should('exist').scrollIntoView() : null;
            row[count][1] != '' ? cy.get(`[data-field="department"]`).find(`div:contains('${row[count][1]}')`).should('be.visible') : cy.get(`[data-field="department"]`).children(`div:contains('')`).should('exist');
            row[count][2] != '' ? cy.get(`[data-field="email"]`).find(`div:contains('${row[count][2]}')`).should('be.visible') : cy.get(`[data-field="email"]`).find(`div:contains('${row[count][2]}')`).should('exist');
            row[count][3] != '' ? cy.get(`[data-field="inviteDate"]`).find(`div:contains('${row[count][3]}')`).should('be.visible') : cy.get(`[data-field="inviteDate"]`).find(`div:contains('${row[count][3]}')`).should('exist');
            row[count][4] != '' ? cy.get(`[data-field="status"]`).find(`div:contains('${row[count][4]}')`).should('be.visible') : cy.get(`[data-field="status"]`).find(`div:contains('${row[count][4]}')`).should('exist');
            row[count][5] != '' ? cy.get(`[data-field="totalSecurities"]`).find(`div:contains('${row[count][5]}')`).should('be.visible') : cy.get(`[data-field="totalSecurities"]`).find(`div:contains('${row[count][5]}')`).should('be.exist');
            row[count][6] != '' ? cy.get(`[data-field="accepted"]`).find(`div:contains('${row[count][6]}')`).should('be.visible') : cy.get(`[data-field="accepted"]`).should('exist');
            row[count][7] != '' ? cy.get(`[data-field="issued"]`).find(`div:contains('${row[count][7]}')`).should('be.visible') : cy.get(`[data-field="issued"]`).should('exist');
          });
        };
      });
      break;
    default:
      throw new Error(tableName + ' table is not defined');
  }
});

Then(`in '{}' pop-up, '{}' list displays details`, (modalName: string, listName: string, dataTable: DataTable) => {
  switch (listName.toLowerCase()) {
    case 'all existing employee': case 'employees selected to participate':
      let row = dataTable.raw()
      cy.get(`h4:contains('${listName}')`).parent().parent().within(() => {
        row.forEach((elem, count) => {
          /// ignore header row
          if (count > 0) {
            cy.get(`*:contains('${row[count][0]}')`).should('exist');
            cy.get(`*:contains('${row[count][1]}')`).should('exist');
          }
        });
      });
      break;
    default:
      throw new Error(listName + ' list is not defined');
  }
});

Then(`in '{}' tab, '{}' section, displays details`, (tabName: string, sectionName: string, dataTable: DataTable) => {
  switch (sectionName) {
    case 'Designated Bank Account':
      let row = dataTable.raw();
      cy.get(`span:contains('${sectionName}')`).scrollIntoView().parent().next('div').within((tab) => {
        row.forEach((elem, count) => {
          /// ignore header row
          if (count > 0) {
            cy.get(`p:contains('${row[count][0]}')`).should('exist');
            cy.get(`p:contains('${row[count][1]}')`).should('exist');
          }
        });
      });
      break;
    default:
      throw new Error(sectionName + ' list is not defined');
  }
});

Then(`{} is not blank`, (item: string) => {
  cy.get(`span:contains('${item}')`).prev('h2').should('exist')
});


When(`in ESOP offer, {}, status show`, (offerName: string, dataTable: DataTable) => {
  cy.log('rows' + dataTable.raw());
  let row = dataTable.raw()
  row.forEach(elem => {
    for (let propNum in elem) {
      cy.log('' + row[0][propNum]);
    }
    cy.get(`h2:contains('${offerName}')`).next(`div`).children(`div`).children(`span`).children(`p:contains('${row[0][0]}')`)
      .parent(`span`).parent(`div`).next(`svg`).next(`div`).children(`span`).children(`p:contains('${row[0][1]}')`)
      .parent(`span`).parent(`div`).next(`svg`).next(`div`).children(`span`).children(`p:contains('${row[0][2]}')`)
      .should('be.visible')
  });
});

When(`in ESOP offer, current status is {}`, (currStatus: string) => {
  cy.get(`p`)
    .contains((new RegExp("^" + currStatus + "$", "g")))
    .should('be.css', 'color', 'rgb(255, 255, 255)');
});


Then(`inside Participant Offers, ESOP invitation is not displayed`, () => {
  cy.get(`h5:contains('ESOP Invitations')`).should('not.exist')
});


Then(`inside Company owner invitations, Company invitation is not displayed`, () => {
  cy.get(`h5:contains('Company Owner')`).should('not.exist')
});

Then(`inside Wallet Invitations, Wallet invitation is not displayed`, () => {
  cy.get(`h5:contains('Wallet')`).should('not.exist')
});


Then(`inside Participant '{}' tab, '{}' option is not available`, () => {
  cy.get(`svg[data-testid="AddIcon"]`).should('not.exist')
});



When(`in ESOP offer, '{}' section securities is non editable`, (type:string) => {
  switch (type.toLowerCase()) {
    case "participants": 
       cy.get(`div[class*="editable"][role="cell"][data-field="totalSecurities"]`).should('not.exist');
       break;}
})


When(`in {}, {} display details`, (type:string, section:string, dataTable: DataTable) => {
  let row = {};
  let propValue;
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
        cy.log(propName, propValue, row[propName]);
      }
    });

  switch (type.toLowerCase()) {
    case 'esop dashboard': 
      switch (section.toLowerCase()) {
        case 'top esop participants':
          let row = dataTable.raw();
          row.forEach((elem, count) => {
            /// ignore header row
            if (count > 0) {
              cy.get(`h2:contains('${section}')`).next().find(`[role="cell"][data-colindex=0]:contains('${row[count][0]}')`)
                .next(`[role="cell"][data-colindex=1]:contains('${row[count][1]}')`)
            }
          });
          break
        }
    case 'upload investor screen pop-up':
      switch(section.toLowerCase()){
        case 'summary table':
          cy.get(`span:contains('Summary')`).eq(2)
            .next().find(`[role="cell"][data-field="security_id"]:contains('${row['Security ID']}')`)
            .next(`[role="cell"][data-field="total_units"]:contains('${row['Total Units']}')`)
            .next(`[role="cell"][data-field="total_investors"]:contains('${row['Total Investors']}')`)
            break;
        case 'investor summary table':
          let row2 = dataTable.raw();
          row2.forEach((elem, count) => {
          /// ignore header row
          if (count > 0) {
            cy.get(`span:contains('Investor Summary')`)
              .next().find(`[role="cell"][data-field="shareholder_type"]:contains('${row2[count][0]}')`)
              .next(`[role="cell"][data-field="company_name"]:contains('${row2[count][1]}')`)
              .next(`[role="cell"][data-field="shareholder_first_name"]:contains('${row2[count][2]}')`)
              .next(`[role="cell"][data-field="shareholder_middle_name"]:contains('${row2[count][3]}')`)
              .next(`[role="cell"][data-field="shareholder_last_name"]:contains('${row2[count][4]}')`)
          }
        });
      }
     break;
    case 'review investor screen pop-up':
      switch(section.toLowerCase()){
        case 'summary table':
          cy.get(`span:contains('Summary')`).eq(2)
            .next().find(`[role="cell"][data-field="security_id"]:contains('${row['Security ID']}')`)
            .next(`[role="cell"][data-field="total_units"]:contains('${row['Total Units']}')`)
            .next(`[role="cell"][data-field="total_investors"]:contains('${row['Total Investors']}')`)
            break;
        case 'investor summary table':
          let row2 = dataTable.raw();
          row2.forEach((elem, count) => {
          /// ignore header row
          if (count > 0) {
            cy.get(`span:contains('Investor Summary')`)
              .next().find(`[role="cell"][data-field="shareholder_type"]:contains('${row2[count][0]}')`)
              .next(`[role="cell"][data-field="company_name"]:contains('${row2[count][1]}')`)
              .next(`[role="cell"][data-field="shareholder_first_name"]:contains('${row2[count][2]}')`)
              .next(`[role="cell"][data-field="shareholder_middle_name"]:contains('${row2[count][3]}')`)
              .next(`[role="cell"][data-field="shareholder_last_name"]:contains('${row2[count][4]}')`)
          }
        });
      }
     break; 
    case 'investors tab':
      switch(section.toLowerCase()){
        case 'holdings summary table':
          let row2 = dataTable.raw();
          row2.forEach((elem, count) => {
          /// ignore header row
          if (count > 0) {
            cy.get(`h2:contains('Holdings Summary Table')`)
              .parent().next().find(`[role="cell"][data-field="name"]:contains('${row2[count][0]}')`)
              .next(`[role="cell"][data-field="additionalName"]:contains('${row2[count][1]}')`)
              .next(`[role="cell"][data-field="groupName"]:contains('${row2[count][2]}')`)
              .next(`[role="cell"][data-field="employee"]:contains('${row2[count][3]}')`)
              .next(`[role="cell"][data-field="emailAddress"]:contains('${row2[count][4]}')`)
              .next(`[role="cell"][data-field="totalUnits"]:contains('${row2[count][5]}')`)
          }
        });
      }
     break;
    default:
      throw new Error(type + ' menu is not found');
    }
});


Then(`inside Participant {} tab, display details`, (tab: string, dataTable: DataTable) => {
  let row = {};
  let propValue;
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
        cy.log(propName, propValue, row[propName]);
      }
    });

  switch (tab.toLowerCase()) {
    case "esop": 
      cy.get(`h6:contains('Employee Details')`).parent().next().find(`:contains('${row['Employee Name']}')`)
      cy.get(`p:contains('Total Securities')`).parent().next().find(`span:contains('Unvested')`).parent().next(`:contains('${row['Unvested']}')`)
      cy.get(`p:contains('Total Securities')`).parent().next().find(`span:contains('Vested')`).parent().next(`:contains('${row['Vested']}')`)
      cy.get(`p:contains('Total Securities')`).parent().next().find(`span:contains('Total')`).next(`:contains('${row['Vested']}')`)
     break;
    default:
      throw new Error(tab + ' tab is not found');
    }
});

Then(`inside Investor {} tab, display details`, (tab: string, dataTable: DataTable) => {
  let row = {};
  let propValue;
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
        cy.log(propName, propValue, row[propName]);
      }
    });

  switch (tab.toLowerCase()) {
    case "holdings in wallet": 
      cy.get(`[role="cell"][data-field=issuerName]:contains('${row['Company Name']}')`)
        .next(`[role="cell"][data-field=totalSecurities]:contains('${row['Total Securities']}')`)
      break;
    default:
      throw new Error(tab + ' tab is not found');
    }
});

Then(`in Communications, '{}', '{}' is displayed`, (labelName: string, text: string) => {
  cy.get(`*:contains('${text}')`).should('be.visible');
});

Then(`in {} screen, '{}' is not visible`, (screenName: string, item: string) => {
  switch (screenName.toLowerCase()) {
    case "issuer requests": 
       cy.get(`[role="cell"][data-field="requestedByName"]:contains('${item}')`).should('not.exist')
       break;}
});


Then(`in {} screen table, display details`, (screenName: string, dataTable: DataTable) => {
  let row = {};
  let propValue;
  dataTable.hashes()
    .forEach(elem => {
      for (var propName in elem) {
        propValue = elem[propName];
        row[propName] = propValue;
        cy.log(propName, propValue, row[propName]);
      }
    });

  switch (screenName.toLowerCase()) {
      case 'fcx admin dashboard':
        cy.get(`[role="cell"][data-field=name]:contains('${row['Name']}')`)
          .next(`[role="cell"][data-field=ownerEmailAddress]:contains('${row['Owner']}')`)
          .next(`[role="cell"][data-field=createdTimestamp]:contains('${convertTestDate(row['Date Created'])}')`)
          .next(`[role="cell"][data-field=status]:contains('${row['Status']}')`)
        break;
      case 'fcx admin wallet':
          cy.get(`[role="row"][data-rowindex=0]`)
            .find(`[role="cell"][data-field=walletType]:contains('${row['Wallet Type']}')`)
            .next(`[role="cell"][data-field=walletName]:contains('${row['Wallet Name']}')`)
            .next(`[role="cell"][data-field=accountDesignation]:contains('${row['Account Designation']}')`)
            .next(`[role="cell"][data-field=walletOwner]:contains('${row['Users']}')`)
            .next(`[role="cell"][data-field=dateCreated]:contains('${convertTestDate(row['Date Created'])}')`)
            .next(`[role="cell"][data-field=status]:contains('${row['Status']}')`)
          break;
      default:
        throw new Error(screenName + ' screenname is not found');
       
      
  }
});


