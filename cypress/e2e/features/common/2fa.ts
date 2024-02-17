
import { Given } from "@badeball/cypress-cucumber-preprocessor";
import '../../../support/commands';

Given(`enter second factor via {} for {}`, (secondFAApp: string, user: string) => {
  const userFixture: string = Cypress.env('ENV') + '/users/' + user.toLowerCase()
  cy.fixture(userFixture)
    .then((userDetails) => {
      switch (secondFAApp.toLowerCase()) {
        case 'authentication app':
          cy.task("generateOTP", userDetails.secret).then(token => {
            let tokenStr: string = token[0] + token[1] + token[2] + token[3] + token[4] + token[5];
            cy.log(tokenStr)
            cy.get(`input[name="secondFactor"]`).type(tokenStr);
          });
          break;
        default:
          throw new Error(secondFAApp + ' web app is not defined');
      }
    });
});