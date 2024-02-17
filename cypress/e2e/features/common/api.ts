import '../../../support/commands';
import { DataTable, Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Given('I initiate a {string} cleanup request with the following data', (reqType: string, dataTable: DataTable) => {
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

	cy.request({
        method: reqType,
        url: `${Cypress.env("APP_DOMAIN")}api/v1/cypress`,
        headers: {
            'Content-Type': 'application/json'
        },
        failOnStatusCode: false,
        body: row["req_body"]
    }).then((resp) => {
        expect(resp.status).to.eq(parseInt(row["status_code"]))
    })
});

When(`participant review and signs Docusign for {} and {}`, (offer: string, email: string) => {
	cy.request({
        method: "POST",
        url: `${Cypress.env("APP_DOMAIN")}api/v1/cypress`,
        headers: {
            'Content-Type': 'application/json'
        },
        failOnStatusCode: false,
        body: {"method": "acceptESOPOfferEnvelope","params":[{"offerName":offer, "email":email}]}
    }).then((resp) => {
        expect(resp.status).to.eq(200)
    })
  });

