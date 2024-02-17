/// <reference types="@testing-library/cypress" />
import '../../../support/commands';
import { When } from '@badeball/cypress-cucumber-preprocessor';


 When(`in FCX Admin Cap Raise view, '{}' is pressed`, (action: string) => {
  switch (action.toLowerCase()) {
      case 'create new raise':
          cy.get(`button:contains('${action}')`).click();
          break;
        default:
          throw new Error(action + ' action not defined.');
          }
  });


  When(`in Create New Raise view pop-up, '{}' is entered into {}`, (text: string, item: string) => {
    switch (item.toLowerCase()) {
        case 'issuer':
          cy.get(`[role="combobox"]`).eq(0).type(text).type('{enter}')
          cy.get(`[role="option"][data-option-index="0"]`).click()
          break;
        case 'label':
          cy.get(`div[data-testid="field-label"]`).clear().type(text)
          break;
        default:
            throw new Error(item + ' action not defined.');
            }
    });


  When(`in Create New Raise view pop-up, '{}' is selected for {}`, (option: string, label: string) => {
        switch (label.toLowerCase()) {
            case 'raise type':
              cy.get(`#radio-raiseType`).next(`div`).find(`span:contains('${option}')`).click()
              break;
            default:
                throw new Error(label + ' label not defined.');
                }
    });



  When(`in Create New Raise view pop-up, '{}' is pressed`, (option: string) => {
      switch (option.toLowerCase()) {
          case 'create':
            cy.get(`[data-testid="create-button"]`).click();
            break;
          default:
              throw new Error(option + ' label not defined.');
              }
  });


