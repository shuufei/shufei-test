describe('My First Test', () => {
  it('Visits the Kitchen Shink', () => {
    cy.visit('https://example.cypress.io');

    cy.contains('type').click();

    cy.url().should('include', '/commands/actions');

    cy.matchImageSnapshot('after type click');

    cy.get('.action-email')
      .type('fake@email.com')
      .should('have.value', 'fake@email.com');
  });
});
