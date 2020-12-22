# Playwright Test Demo

Demonstration of [Playwright Test](https://github.com/microsoft/playwright-test) usage with Sauce Labs

## Example Job

<<<<<<< HEAD
Example of a Sauce Labs job that runs this test: (TODO: Link to a Github Workflow action)
=======
Example of a Sauce Labs job that runs this test: https://app.saucelabs.com/tests/0ff4307a39c44151beccd91bc543f71d
>>>>>>> faf68f43a2487a099fde50ea1ad0a68c4c786a96

## Prerequisites

In order to upload results and assets to Sauce Labs, you need to set your Sauce Labs credentials.
There is two options:
- Using `saucectl configure` that will ask for username and access key
- Using `SAUCE_USERNAME`/`SAUCE_ACCESS_KEY` environment variables

 If no account is set, the job will run, but no assets will be uploaded.

## Usage with dockerdocker

This demo requires a specifically build version of `saucectl` which is available in thie `saucectl_bin/` folder.
It is build from [saucectl@playwright-native-config](https://github.com/saucelabs/saucectl/tree/playwright-native-config).

```bash
./saucectl_bin/saucectl_darwin run
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

## Roadmap

Currently these tests are running in Docker containers. Early 2021 we will be adding Playwright to our VM's so that they can run in the cloud.
