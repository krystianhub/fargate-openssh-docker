# AWS Fargate OpenSSH Docker

[![Docker CI](https://github.com/krystianhub/fargate-openssh-docker/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/krystianhub/fargate-openssh-docker/actions/workflows/docker-publish.yml)

## Description

Simple OpenSSH docker image for use with [AWS Fargate](https://aws.amazon.com/fargate/) service

## Usage

```bash
docker pull ghcr.io/krystianhub/fargate-openssh-docker:latest
```

## Example AWS Fargate Task definition

Example task definition with **OpenSSH server** and, for example, **[Transmission](https://hub.docker.com/r/linuxserver/transmission)** client.

```json
{
    "taskDefinitionArn": "arn:aws:ecs:XXX:XXX:task-definition/transmission-ssh:1",
    "containerDefinitions": [
        {
            "name": "fargate-openssh",
            "image": "ghcr.io/krystianhub/fargate-openssh-docker:latest",
            "cpu": 0,
            "links": [],
            "portMappings": [
                {
                    "containerPort": 2222,
                    "hostPort": 2222,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "entryPoint": [],
            "command": [],
            "environment": [
                {
                    "name": "USER_PASSWORD",
                    "value": "XXX"
                }
            ],
            "mountPoints": [
                {
                    "sourceVolume": "downloads",
                    "containerPath": "/home",
                    "readOnly": false
                }
            ],
            "volumesFrom": [],
            "dnsServers": [],
            "dnsSearchDomains": [],
            "dockerSecurityOptions": [],
            "systemControls": []
        },
        {
            "name": "transmission",
            "image": "linuxserver/transmission:latest",
            "cpu": 0,
            "portMappings": [
                {
                    "containerPort": 9091,
                    "hostPort": 9091,
                    "protocol": "tcp"
                },
                {
                    "containerPort": 51413,
                    "hostPort": 51413,
                    "protocol": "tcp"
                },
                {
                    "containerPort": 51413,
                    "hostPort": 51413,
                    "protocol": "udp"
                }
            ],
            "essential": true,
            "environment": [
                {
                    "name": "PASS",
                    "value": "XXX"
                },
                {
                    "name": "USER",
                    "value": "XXX"
                }
            ],
            "mountPoints": [
                {
                    "sourceVolume": "downloads",
                    "containerPath": "/downloads"
                }
            ],
            "volumesFrom": []
        }
    ],
    "family": "transmission-ssh",
    "taskRoleArn": "arn:aws:iam::XXX:role/ECS_S3FullAccess",
    "executionRoleArn": "arn:aws:iam::XXX:role/ecsTaskExecutionRole",
    "networkMode": "awsvpc",
    "revision": 1,
    "volumes": [
        {
            "name": "downloads",
            "host": {}
        }
    ],
    "status": "ACTIVE",
    "requiresAttributes": [
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.17"
        },
        {
            "name": "com.amazonaws.ecs.capability.task-iam-role"
        },
        {
            "name": "com.amazonaws.ecs.capability.docker-remote-api.1.18"
        },
        {
            "name": "ecs.capability.task-eni"
        }
    ],
    "placementConstraints": [],
    "compatibilities": [
        "EC2",
        "FARGATE"
    ],
    "runtimePlatform": {
        "cpuArchitecture": "X86_64",
        "operatingSystemFamily": "LINUX"
    },
    "requiresCompatibilities": [
        "FARGATE"
    ],
    "cpu": "512",
    "memory": "1024",
    "registeredBy": "arn:aws:iam::XXX:XXX"
}
```
