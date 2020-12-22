# Playwright Test Demo

Demonstration of [Playwright Test](https://github.com/microsoft/playwright-test) usage with Sauce Labs. Uses a [basic "Hello World"](./tests/basic-js) type implementation of Playwright Test 

## Prerequisites

In order to upload results and assets to Sauce Labs, you need to set your Sauce Labs credentials.
There is two options:
- Using `saucectl configure` that will ask for username and access key
- Using `SAUCE_USERNAME`/`SAUCE_ACCESS_KEY` environment variables

 If no account is set, the job will run, but no assets will be uploaded.

## Example

This demo requires a specifically build version of `saucectl` which is available in thie `saucectl_bin/` folder.
It is build from [saucectl@playwright-native-config](https://github.com/saucelabs/saucectl/tree/playwright-native-config).

```bash
./saucectl_bin/saucectl_darwin run # macOS
./saucectl_bin/saucectl_win64.exe run # Windows
```

Example output:
A link to the job will be provided in the output of the Saucectl command:

```
$> ./saucectl_bin/saucectl_darwin run
1:34PM INF Running version v0.21.1-playwright
1:34PM INF Reading config file config=.sauce/config.yml
1:34PM INF Running Playwright in Docker
1:34PM INF Setting up test environment
1:34PM WRN The use of 'latest' as the docker image tag is discouraged. We recommend pinning the image to a specific version. Please proceed with caution.
1:34PM INF File mounted from=./tests/ to=/home/seluser/tests
1:34PM INF Using credentials set by environment variables
1:34PM INF Starting container id=34c5473bdd84 img=saucelabs/stt-playwright-folio-node:latest

> sauce-playwright-runner@0.0.0 test /home/seluser
> node src/folio-recorder.js "-r" "/home/seluser/sauce-runner.json" "-s" "default"

  1 passed (17s)

  Slow test: test.spec.js (17s)

[...]

Open job details page: https://app.saucelabs.com/tests/d17a4eeaa95f46f18e0d2238085c8607

1:35PM INF Command Finished ExitCode=0
1:35PM INF Tearing down environment
```

Follow that link to see the test

## Example Sauce Job

Example of a Sauce Labs job that runs this test: https://app.saucelabs.com/tests/0ff4307a39c44151beccd91bc543f71d

## GitHub Actions

This repo has an example of `saucectl` running as a GitHub Action: https://github.com/saucelabs/playwright-test-demo/pull/2/checks?check_run_id=1597465811

The yaml is [saucectl.yml](./.github/workflows/saucectl.yml)

## Running Locally

This example can be run locally like this:

```bash
./saucectl_bin/saucectl_darwin run # macOS
./saucectl_bin/saucectl_win64.exe run # Windows
```

## Notes

* This repo uses a version of saucectl that hasn't been widely released yet. Once this version is merged and published, you will be able to install this via `npm` (`npm install -g saucectl`)

## Config

The file `.sauce/config.yml` contains the parameters used to run the Playwright test.

```yml
playwright:
  projectPath: ./tests/
  param:
    browserName: "webkit"
suites:
  - name: "default"
    param:
      browserName: "webkit"
      slowMo: 10000
    testMatch: "**/*.spec.js"
```

The `playwright` object is where you provide `projectPath` (where the tests are) and then any parameters passed to folio. Look up `npx folio --help` to see a list of parameters. 

For example, `test-match` is a folio parameter that can be provided in the yml like this

```yml
playwright:
  ...
  testMatch: "**/*.test.js"
```

The `suites` array is a list of objects that use the same arguments as `playwright`. Each suite can be run independently and each `suite` object overrides what's in `playwright`

Example

```yml
playwright:
  projectPath: ./tests/
  param:
    browserName: "webkit"
suites:
  - name: "default"
    param:
      browserName: "firefox"
      slowMo: 10000
    testMatch: "**/*.spec.js"
```

This above command will run `folio --param browserName=firefox slowMo=10000 --testMatch "**/*.spec.js"`. `browserName` is defined in `playwright` and `suites` but `firefox` will be used because the contents of a `suite` override what is in `playwright`.

Tests can have multiple suites

```yml
playwright:
  projectPath: ./tests/
suites:
  - name: "default"
    param:
      browserName: "firefox"
      slowMo: 10000
    testMatch: "tests/a/**/*.spec.js"
  - name: "default"
    param:
      browserName: "firefox"
      slowMo: 10000
    testMatch: "tests/b/**/*.spec.js"
  - name: "default"
    param:
      browserName: "firefox"
      slowMo: 10000
    testMatch: "tests/a/**/*.spec.js"
  - name: "default"
    param:
      browserName: "webkit"
      slowMo: 10000
    testMatch: "tests/a/**/*.spec.js"
  - name: "default"
    param:
      browserName: "webkit"
      slowMo: 10000
    testMatch: "tests/b/**/*.spec.js"
```

This will run four suites with different parameters. The purpose of this is that when the tests get run on our cloud, each suite can run independently on it's own VM, for parallelism.

## Roadmap

Currently these tests are running in Docker containers. Early 2021 we will be adding Playwright to our VM's so that they can run in the cloud.
