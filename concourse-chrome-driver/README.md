# Docker container for behave

# Building the docker container 

We are in the process of migrating our CD pipelines from Concourse to AWS Codepipeline. The following instructions show how to build the old concourse-chrome-driver image manually and push to Dockerhub.

This image is automatically built in the `build+test` account (670214072732) - Codepipeline [cd-chrome-driver](https://eu-west-2.console.aws.amazon.com/codesuite/codepipeline/pipelines/cd-chrome-driver/view?region=eu-west-2)

```
# NOTE: Replace version with the bumped version number
docker build --no-cache -t gdscyber/concourse-chrome-driver -t gdscyber/concourse-chrome-driver:1.0 .

# Then to push to DockerHub:
docker push gdscyber/concourse-chrome-driver:1.0
docker push gdscyber/concourse-chrome-driver:latest 
```