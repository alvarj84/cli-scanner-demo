
# GitHub CI Demo
In this demo we will use GitHub actions to build, scan and push a container image. The workflow is as follows:

1. Setup Docker Buildx to be able to build the image
2. Build the container image and store it locally
3. Download the sysdig-cli-scanner cli if needed
4. Perform the scan
5. Login to the DockerHub registry
6. Push the container image to a remote registry

The workflow leverages GitHub actions cache to avoid downloading the binary or the databases if they are available.

# Setup
It is required to create a few repository secrets in order to be able to push the container image:

`DOCKERHUB_USERNAME`: Docker Hub username
`DOCKERHUB_TOKEN`: Docker Hub registry token
`SECURE_API_TOKEN`: Sysdig Secure API Token

Modify the environment variables on the build-scan-and-push.yaml file to fit your needs:

SYSDIG_SECURE_ENDPOINT: "https://secure.sysdig.com" This depends on the region the account is located.

DOCKERHUB_USER: "alvarj84"

IMAGE_NAME: "cli-scanner-demo"

IMAGE_TAG: "clean"

DOCKERFILE_CONTEXT: "./" The path where the Dockerfile is located relative to this git repository

# Command Line Inline Scanning examples:

## Scanning a TAR file:

```
% sysdig-cli-scanner --apiurl https://us2.app.sysdig.com file://log4j.tar --dbpath=./sysdig-cli-scanner/cache/db --cachepath=./sysdig-cli-scanner/cache/scanner-cache/
```

## Scanning an AWS ECR:
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 306613785917.dkr.ecr.us-east-1.amazonaws.com
% sysdig-cli-scanner --apiurl https://us2.app.sysdig.com pull://306613785917.dkr.ecr.us-east-1.amazonaws.com/sysdigtest:clean --dbpath=./sysdig-cli-scanner/cache/db --cachepath=./sysdig-cli-scanner/cache/scanner-cache/ --policy sysdig-best-practices
```