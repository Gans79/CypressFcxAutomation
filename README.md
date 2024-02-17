# FCX-Cypress

This repository is for the Cypress-Cucumber-TypeScript code base to enable test automation of FCX.

## Getting started
1. Install pre-requisites:
    - node.js
2. Git clone this repo:
   > `git checkout `
3. Install packages
   > `npm install`
4. Add Cucumber json formatter, see details (https://github.com/cucumber/json-formatter)
   - For MacOS: cucumber-json-formatter-darwin-amd64
   - For Windows: cucumber-json-formatter-windows-amd64

## Executing Test

Check scripts section in package.json
- `open:[dev|test]` starts up the Cypress IDE using <environment> configuration.
- `run:[dev|test]` executes the automated tests, defined by the Tags using <environment> configuration.
- `run:[dev|test]:record` executes the automated tests, defined by the Tags using <environment> configuration and sends results to the Cypress Dashboard.


---
