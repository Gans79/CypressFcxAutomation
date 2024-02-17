import { defineConfig } from "cypress";
import * as webpack from "@cypress/webpack-preprocessor";
import { addCucumberPreprocessorPlugin } from "@badeball/cypress-cucumber-preprocessor";
import { Client } from 'pg';
const otplib = require("otplib");

/* Environment specific */

async function setupNodeEvents(
  on: Cypress.PluginEvents,
  config: Cypress.PluginConfigOptions
): Promise<Cypress.PluginConfigOptions> {
  // This is required for the preprocessor to be able to generate JSON reports after each run, and more,
  await addCucumberPreprocessorPlugin(on, config);

  on(
    "file:preprocessor",
    webpack({
      webpackOptions: {
        resolve: {
          extensions: [".ts", ".js"],
        },
        module: {
          rules: [
            {
              test: /\.ts$/,
              exclude: [/node_modules/],
              use: [
                {
                  loader: "ts-loader",
                },
              ],
            },
            {
              test: /\.feature$/,
              use: [
                {
                  loader: "@badeball/cypress-cucumber-preprocessor/webpack",
                  options: config,
                },
              ],
            },
          ],
        },
      },
    }),
  );

  on("task", {
    generateOTP(secret) {
      return otplib.authenticator.generate(secret);
    }
  });

  // Make sure to return the config object as it might have been modified by the plugin.
  return config;
};

export default defineConfig({
  // Global Config
  projectId: "wsrpn9",
  chromeWebSecurity: false,
  videoUploadOnPasses: false,
  retries: {
    runMode: 0,
    openMode: 0,
  },
  /* Global - Timeouts */
  // defaultCommandTimeout: 5000, //default: 4000 #BUG: PLX-3293
  // execTimeout: 30000, //default: 60000
  // taskTimeout: 31000, //default: 60000
  // pageLoadTimeout: 32000, //default: 60000
  // requestTimeout: 10000,  //default: 5000
  // responseTimeout: 30000,  //default: 30000
  blockHosts: ["*google.com"],
  /* Common */
  viewportWidth: 1920,
  viewportHeight: 1080,
  /* lower denomination */
  // viewportWidth: 1280,
  // viewportHeight: 720,
  e2e: {
    env: {
      ENV: "test",
      TAGS: "(@ESOPSmoke or @ShareCommSmoke or @CompanySmoke or @WalletSmoke or @CapRaiseSmoke ) and (@TEST) ",
      APP_DOMAIN: "https://app.platformx-test.fincleartech.io/",
      PXADMIN_DOMAIN: "https://pxadmin.platformx-test.fincleartech.io/",
      DOWNLOAD_RELATIVE_LOCATION: "../../Downloads/",
      DOWNLOAD_CYPRESS_LOCATION: "cypress/downloads/",
      RESULTS_OUTPUT_LOCATION: "results/",
      FAIL_FAST_STRATEGY: "spec",
      FAIL_FAST_ENABLED: false,
      FAIL_FAST_BAIL: 2,
      /* Specific extended timeouts */
      MAX_TIMEOUT: 30000,
      LOAD_VIDEO_TIMEOUT: 20000,
      /* Env specific Test data */
      ISSUER_ID: "5E7DAC6B-4F4D-46E9-AF80-2B403F802F44",
    },
    specPattern: [
      "**/00_reset/*.feature",
      "**/01_onboarding/*.feature",
      "**/04_cap_raise/*.feature",
      "**/05_esop/*.feature",
      "**/06_shareholder_communications/*.feature"
    ],
    excludeSpecPattern: [
      "**/03_investor/01_dashboard.feature"
    ],
    videosFolder: "results/videos",
    screenshotsFolder: "results/screenshots",
    supportFile: false,
    setupNodeEvents,
  },
  /* Reporters */
  // reporter: 'junit',
  // reporterOptions: {
  //   mochaFile: 'results/junit/output.xml',
  //   toConsole: true
  // },
  reporter: 'cypress-multi-reporters',
  reporterOptions: {
    configFile: 'reporter-config.json',
  },
});
