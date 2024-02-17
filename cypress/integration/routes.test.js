it(`displays correct heading when navigating to order route`, () => {
    cy.visit("/");
    cy.findByRole("button", {name: /login/i} ).click();
    cy.findByRole("heading", {name: /beverage/i} ).should("exist");
})