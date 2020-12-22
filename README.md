# Playwright Test Demo

This is a repository for demonstrating [Playwright Test](https://github.com/microsoft/playwright-test) usage with Sauce Labs

## Example Job

Example of a Sauce Labs job that runs this test: (TODO: Link to a job)

## Usage with Docker

First need sauce credentials `SAUCE_USERNAME` and `SAUCE_ACCESS_KEY` set as environment variables. (If these aren't set, the job will run, but no assets will be uploaded)

```bash
git clone git@github.com:saucelabs/sauce-playwright-runner.git # Clone `sauce-playwright-runner'
pushd ./sauce-playwright-runner && make docker && popd # Builds the docker container
# Clone saucectl
./saucectl run .sauce/config.yml # Run saucectl
```

A link to the job will be provided in the output of the Saucectl command:

```
```

Follow that link to see the test

## Roadmap

Next step for early 2021 is to make this available in the cloud so that these tests can run inside of a Sauce Labs VM instead of just Docker.

