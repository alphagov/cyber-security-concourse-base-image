# Artillery

Artillery is a load testing tool that we can run in concourse to test the resilience of our apps against denial of service attempts or unusually high traffic.

## Docker image

This pipeline builds a docker image and uploads it to dockerhub at `gdscyber/artillery-load-testing`. You can pull the image in your pipeline to run load tests. You will need to run the artillery commands within your docker image as shown in the example below:

```shell
artillery run artillery-config.yml -o artillery.json
```

## Artillery config

The best way to run artillery is to use a config yaml file to specify your payloads and any plugins you might use. Two config examples can be found in this directory. One is for [testing HTTP endpoints](https://artillery.io/docs/http-reference/), the other is for [testing a Kinesis data stream](https://github.com/artilleryio/artillery-engine-kinesis) in AWS. More information can be found on the [artillery website](https://artillery.io).
