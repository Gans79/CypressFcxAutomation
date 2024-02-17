import { DataTable, When, Then } from '@badeball/cypress-cucumber-preprocessor';
import { convertTestDate } from '../../../support/utils';

When(`in {}, '{}' section, shows row details`, (pageName: string, sectionName: string, dataTable: DataTable) => {
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

  cy.get(`*:contains('${sectionName}')`, { timeout: Cypress.env('MAX_TIMEOUT') })
    .find(`*:contains('${row['Plan Name']}')`)
    .parent().find(`*:contains('${convertTestDate(row['Created'])}')`)
    .parent().find(`*:contains('${convertTestDate(row['Archived'])}')`)
    .should('be.visible');
});

Then(`in ESOP, '{}', '{}' is displayed`, (planName: string, text: string) => {
  cy.get(`*:contains('${text}')`).should('be.visible');
});

Then(`in ESOP, '{}' is not displayed for '{}`, (planName: string, text: string) => {
  cy.get(`*:contains('${text}')`).should('not.exist');
});

Then(`in ESOP, {} is not displayed`, (planName: string) => {
  cy.get(`*:contains('${planName}')`).should("not.exist");
});

Then(`'ESOP' table, does not display row [with plan name]`,(dataTable: DataTable) => {
    // switch (section.toLowerCase()) {
    //   case 'esop':
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

    // TODO: Fix cy.xpath not working (https://github.com/cypress-io/cypress/issues/24764)
    /* validate table data */
    /* Note: Limitation of CSS of parent C=Cascading */
    // cy.get(`div[role=row] > div[data-field="issuerName"] div:contains('${row['Company']}')
    //         , div[data-field="poolAllocation"] > div:contains('${row['ESOP Pool']}')
    //         , div[data-field="name"] > div:contains('${row['Plan Name']}')
    //         , div[data-field="createdDateTime"] > div:contains('${row['Created']}')
    //         , div[data-field="status"] > div:contains('${row['Status']}')
    //         `)
    /* previous */
  cy.get(`div[data-field="issuerName"] > div:contains('${row['Company']}')`).should('be.visible');
    // .get(`div[data-field="issuerName"]`).find(`*:contains('${row['Company']}')`).should('be.visible');
    // .parent().next(`[data-field="poolAllocation"]`).find(`*:contains('${row['ESOP Pool']}')`)
    // .parent().next(`[data-field="name"]`).find(`*:contains('${row['Plan Name']}')`)
  cy.get(`div[data-field="name"] > div:contains('${row['Plan Name']}')`)
      // .parent().next(`[data-field="createdDateTime"]`)
      // .next(`[data-field="status"]`).find(`*:contains('${row['Status']}')`)
    .should('not.exist');
    //     break;
    //   default:
    //     throw new Error(section + ' section table is not defined.');
    // }
});

Then(`in ESOP, '{}' section, does not show row [with plan name]`, (section: string, dataTable: DataTable) => {
    switch (section.toLowerCase()) {
    case 'past plans':
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
        // Check column headers displayed
      cy.get(`[data-field="planName"]`).find(`*:contains('Plan Name')`).should('be.visible');
        // Check Past Plans is displayed
      cy.get(`div[data-field="planName"][data-colindex="0"]`).should('be.visible');
        // Check ESOP has been deleted
      cy.get(`div[data-field="planName"][data-colindex="0"] > div:contains('${row['Plan Name']}')`)
        .should('not.exist');
        break;
      default:
      throw new Error(section + ' section table is not defined.');
    }
});

When(`in ESOP offer, status is '{}', '{}' section securities updated to {}`, (status:string,type:string, text: string) => {
  switch (type.toLowerCase()) {
    case "participants": 
      switch(status.toLowerCase()){
       case "setup": 
          cy.get(`[role="cell"][data-field="totalSecurities"]`).click();
          cy.get(`label:contains('No. of Securities')`).next().clear().type(text.replace(',',''))
          cy.get(`button:contains('Save')`).click();
          break;
       case "open":
          cy.get(`[role="cell"][data-field="totalSecurities"]`).click();
          cy.get(`label:contains('No. of Securities')`).next().clear().type(text.replace(',',''))
          cy.get(`button:contains('Save')`).click();
          cy.get(`button:contains('Confirm')`).click();
          break;
      }
      break;
      default:
        throw new Error(type + ' type label not defined.');

    }
});