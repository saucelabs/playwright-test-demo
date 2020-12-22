#docker build -t sauce-playwright-container .
docker run -it \
    -v $(pwd)/tests/basic-js:/home/seluser/project \
    -e SAUCE_USERNAME=$SAUCE_USERNAME \
    -e SAUCE_ACCESS_KEY=$SAUCE_ACCESS_KEY \
    saucelabs/stt-playwright-jest-node:latest \
    bash -c "./entry.sh & node . --suiteName basic-js --runCfgPath /home/seluser/project/sauce-runner.json" \
