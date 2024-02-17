import { defineConfig } from "cypress";
import * as webpack from "@cypress/webpack-preprocessor";
import { addCucumberPreprocessorPlugin } from "@badeball/cypress-cucumber-preprocessor";

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

  // Make sure to return the config object as it might have been modified by the plugin.
  return config;
}

export default defineConfig({
  // Global Config
  projectId: "8ygbuw",
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
      ENV: "local",
      TAGS: "(@DEV and @run)",
      //APP_DOMAIN: "https://app.platformx-dev.fincleartech.io/",
      //PXADMIN_DOMAIN: "https://pxadmin.platformx-dev.fincleartech.io/",
      APP_DOMAIN: "http://localhost:3000/",
      PXADMIN_DOMAIN: "http://localhost:3002/",
      DOWNLOAD_RELATIVE_LOCATION: "../../Downloads/",
      DOWNLOAD_CYPRESS_LOCATION: "cypress/downloads/",
      FAIL_FAST_STRATEGY: "spec",
      FAIL_FAST_ENABLED: false,
      FAIL_FAST_BAIL: 2,
      /* Specific extended timeouts */
      MAX_TIMEOUT: 30000,
      LOAD_VIDEO_TIMEOUT: 20000,
    },
    // specPattern: ["**/01_new_account*.feature", "**/04_ESOP_role.feature", "**/05_esop/*.feature"],
    specPattern: ["**/00_reset/*.feature", "**/05_esop/*.feature", "**/06_shareholder_communications/*.feature"],
    excludeSpecPattern: "",
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
