# cyber-security-concourse-base-image

This repository holds the pipeline for cyber security Concourse Docker image builds.

The main image in this repository is the base image that should be used by all concourse Docker images in Cyber. The reason being is we had multiple images that installed the same things, this way we have a standardised build.

To extend upon the main image, use `FROM gdscyber/cyber-security-concourse-base-image`.

# other base images

There are a number of different directories in this repository which contain different base images that are generic and can be reused but do not use the base image for the reasons mentioned above.

# Dockerfiles that use the base image

Other repositories that use this base image will contain their own Dockerfile in the project repo. The pipeline within this repository will check for changes to those Dockerfiles and update them in docker hub so they are always up to date.
