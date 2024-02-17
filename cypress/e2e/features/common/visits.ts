import { Given } from "@badeball/cypress-cucumber-preprocessor";
import '../../../support/commands';

beforeEach(() => {
  cy.intercept('GET', `/chart**`, (res) => {
    cy.log(res.body);
  }).as('googleOTP');
});

Given(`a user browsers to FCX app`, () => {
  cy.visit(Cypress.env("APP_DOMAIN"));
});

Given(`'{}' is logged in to FCX '{}'`, (user: string, app: string) => {
  const userFixture: string = Cypress.env('ENV') + '/users/' + user.toLowerCase()
  cy.fixture(userFixture)
    .then((userDetails) => {
      switch (app.toLowerCase()) {
        case "app":
          cy.visit(Cypress.env("APP_DOMAIN"));
          // In Log In, enter login details
          cy.get(`input[name=email]`).type(userDetails.email);
          cy.get(`input[name=password]`).type(userDetails.password);
          // click Log In button
          cy.get(`button[data-testid=button-login]`).click();
          cy.get(`h1:contains('Welcome to FCX')`).should('be.visible')
          break;
        case "pxadmin":
          cy.visit(Cypress.env("PXADMIN_DOMAIN"));
          // In Log In, enter login details
          cy.get(`input[name=email]`).type(userDetails.email);
          cy.get(`input[name=password]`).type(userDetails.password);
          // click Log In button
          cy.get(`button[data-testid=button-login]`).click();
          break;
        default:
          throw new Error(app + " web app is not defined");
      }
    });
});
