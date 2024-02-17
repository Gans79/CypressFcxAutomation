/// <reference types="@cypress/xpath" />
import { DataTable, When, Then } from "@badeball/cypress-cucumber-preprocessor";
import { convertTestDate, convertToCamelCase } from '../../../support/utils';
import '../../../support/commands'
import { replaceDateExpression, convertDateToDD_Mon_YYYY } from "../../../support/utils";


Then(`in {} view table, display details`, (view: string, dataTable: DataTable) => {
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

  switch (view.toLowerCase()) {
    case "fcx admin cap raises": 
      cy.get(`[role="cell"][data-field="issuerName"]:contains('${row['Issuer']}')`)
        .next(`[role="cell"][data-field="raiseType"]:contains('${row['Raise Type']}')`)
        .next(`[role="cell"][data-field="label"]:contains('${row['Label']}')`)
        .next(`[role="cell"][data-field="s708Required"]:contains('${row['S708']}')`)
        .next(`[role="cell"][data-field="createdDateTime"]:contains('${convertTestDate(row['Creation Date'])}')`)
        .next(`[role="cell"][data-field="status"]:contains('${row['Status']}')`)
     break;
    default:
      throw new Error(view + ' view is not found');
    }
});

