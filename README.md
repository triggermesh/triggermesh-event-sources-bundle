# TriggerMesh - Event Sources Bundle

A subset of the [TriggerMesh platform][tm-repo] containing only event sources.

## Contents

1. [Included Components](#included-components)
1. [Creating a Release](#creating-a-release)

## Included Components

- Event Sources for Amazon Web Services
  - CloudWatch
  - CloudWatch Logs
  - CodeCommit
  - Cognito Identity
  - Cognito User Pool
  - DynamoDB
  - Kinesis
  - Performance Insights
  - Simple Cloud Storage (S3)
  - Simple Notification Service (SNS)
  - Simple Queue Service (SQS)

- Event Sources for Microsoft Azure
  - Activity Logs
  - Blob Storage
  - Event Grid
  - Event Hubs
  - IoT Hub
  - Queue Storage
  - Service Bus Queues
  - Service Bus Topics

- Event Sources for Google Cloud Platform
  - Cloud Audit Logs
  - Cloud Billing
  - Cloud IoT
  - Cloud Pub/Sub
  - Cloud Source Repositories
  - Cloud Storage

## Creating a Release

:information_source: _Please ensure `ko` is installed according to the [TriggerMesh Contributor Guide][tm-contrib-ko]._

To publish a container image for this bundle and generate the corresponding release manifests, set the value of the
`KO_DOCKER_REPO` environment variable to the container registry where the image is to be pushed, then run:

```
make release
```

Once the build is complete and the container image is uploaded, the release manifests are written to the `_output`
directory.

```console
$ ls _output
triggermesh-crds.yaml  triggermesh.yaml
```

[tm-repo]: https://github.com/triggermesh/triggermesh
[tm-contrib-ko]: https://github.com/triggermesh/triggermesh/blob/main/CONTRIBUTING.md#ko
