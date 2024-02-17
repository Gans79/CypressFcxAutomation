import { DataTable, When, Then } from '@badeball/cypress-cucumber-preprocessor';
import { convertTestDate } from '../../../../support/utils';

When(`in 'Create/'Edit/'Clone Offer' pop-up, add/update {} vesting cycle`, (cycleNumber: string, dataTable: DataTable) => {
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

  switch (cycleNumber) {
    case 'first':
      // Vesting Date
      cy.get(`label:contains('Vesting Date')`).eq(0).next(`div`).children(`input[placeholder="dd/mm/yyyy"]`).click()
        .then(() => {
          cy.get(`label:contains('Vesting Date')`).eq(0).next(`div`).children(`input[placeholder="dd/mm/yyyy"]`).clear().type(convertTestDate(row['Vesting Date']));
        });
      // Vesting Amount
      cy.get(`label:contains('Vesting Amount (%)')`).eq(0).next(`div`).children(`input`).clear().type(row['Vesting Amount (%)']);
      break;
    case 'second':
      // Vesting Date
      cy.get(`label:contains('Vesting Date')`).eq(1).next(`div`).children(`input[placeholder="dd/mm/yyyy"]`).click()
        .then(() => {
          cy.get(`label:contains('Vesting Date')`).eq(1).next(`div`).children(`input[placeholder="dd/mm/yyyy"]`).clear().type(convertTestDate(row['Vesting Date']));
        });
      // Vesting Amount
      cy.get(`label:contains('Vesting Amount (%)')`).eq(1).next(`div`).children(`input`).clear().type(row['Vesting Amount (%)']);
      break;
    case 'third':
      // Vesting Date
      cy.get(`label:contains('Vesting Date')`).eq(2).next(`div`).children(`input[placeholder="dd/mm/yyyy"]`).click()
        .then(() => {
          cy.get(`label:contains('Vesting Date')`).eq(2).next(`div`).children(`input[placeholder="dd/mm/yyyy"]`).clear().type(convertTestDate(row['Vesting Date']));
        });
      // Vesting Amount
      cy.get(`label:contains('Vesting Amount (%)')`).eq(2).next(`div`).children(`input`).clear().type(row['Vesting Amount (%)']);

      break;
    default:
      throw new Error(cycleNumber + ' vesting cycle not defined.');
  }
});

// When(`in ESOP offer, '{}' tab is pressed`, (text: string) => {
//   cy.get(`button:contains('${text}')`).click();
// });

When(`in 'ESOP Offer' page, 'Documents & Media' tab, 'Upload' {int} documents of {}`, (numDocs: number, docType: string) => {
  let docNum: number = 1;
  cy.log(docNum.toString(), ':', numDocs.toString());
  let documentName: string;
  for (docNum; docNum <= numDocs; docNum++) {
    cy.log('Doc Num:', docNum.toString());
    cy.get(`h3:contains('Documents')`).scrollIntoView();
    cy.get(`button:contains('Upload')`).should('be.visible').scrollIntoView().click();
    documentName = 'Clone ' + docType + ' doc ' + docNum.toString();
    cy.get(`label:contains('Document Name')`).next(`div`).children(`input`).clear().type(documentName);

    cy.get(`label:contains('Document Type')`).next(`div`).find(`span:contains('${docType}')`).click()

    const fileName = docType.toLowerCase() + '_document.pdf'
    const incFilePath: string = 'cypress/fixtures/' + fileName;
    cy.fixture(
      fileName,
      null
    ).then((validFile) => {
      cy.get(`[data-testid="file-drop-zone"] div[role="presentation"]`)
        .click()
        .then(() => {
          cy.get("input[type=file]")
            .selectFile(incFilePath, { force: true }
            );
        })
    });
    cy.get(`#upload-new-document`).find(`button:contains('Upload')`).click()
      .then(() => {
        // Close status alert
        cy.get(`[data-testid="snackbar"][data-severity="success"]`).scrollIntoView().find(`div:contains('Document uploaded')`).should('be.visible').next().find(`svg[data-testid="CloseIcon"]`).parent('button').click();
        // cy.get(`[data-testid="snackbar"][data-severity="success"]`).find(`*:contains('Document uploaded')`).should('be.visible');
      })
      .then(() => {
        cy.get(`#upload-new-document`).should('not.exist');
      });

  }
});

// When(`in 'Edit Offer' pop-up, '<Plan Name>' is displayed

When(`in 'Create Offer' pop-up, enter details`, (dialogLabel: string, dataTable: DataTable) => {
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

  // | ESOP Plan   | Offer Name   | Description   | Security ID   | Grant Date   | Grant Date same as Issue Date   | Close Date   | Expiry Date   | Expiry Date not Applicable   | Vesting Schedule   | Vesting Date   | Frequency of vesting   | Vesting Amount   | Rounding   | Issue Price   | Issue Price Not Applicable   | Exercise Price   | Exercise Price not Applicable   | Employee Wallet   |
  row['Offer Name'] ? cy.get(`input[name="offerName"]`).clear().type(row['Offer Name']) : null;
  row['Description'] ? cy.get(`textarea[name="description"]`).clear().type(row['Description']) : null;

  row['Security ID'] ? cy.get(`#security-label`).next(`div`).click() : null;

  //   row['Grant Date'] ?
  //   row['Grant date is same as Issue Date'] ?
  //   row['Expiry Date'] ?
  //   row['Vesting Schedule'] ?
  //   /* Vesting Schedule: Auto */
  //   row['Frequency'] ?
  //   row['Vesting Amount(%) *'] ?
  //   row['Rounding'] ?
  //   /* Vesting Schedule: Manual */
  //   row['Vesting Date'] ?
  //   row['Vesting Amount(%) *'] ?
  //   /* Add vesting cycle */
  //   row['Add Vesting Cycle'] ?
  //   row['Vesting Date'] ?
  //   row['Vesting Amount(%) *'] ?

  //   row['Rounding'] ?
  // /* Price */
  // row['Issue Price'] ?
  // row['Issue Price not Applicable'] ?
  // row['Exercice Price'] ?
  // row['Exercice Price not Applicable'] ?
  // row['Close Date'] ?
  // /* Employee Wallet */
  // row['mployee Wallet'] ?

});
