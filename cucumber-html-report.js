const report = require("multiple-cucumber-html-reporter");
report.generate({
  jsonDir: "results/cucumber-json/", // ** Path of .json file **//
  reportPath: "results/reports",
  metadata: {
    browser: {
      name: "Chrome",
      version: "v109",
    },
    device: "Local test machine",
    platform: {
      name: "MacOS",
      version: "Ventura 13.1",
    },
  },
});
