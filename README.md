# Inventory Manager — DevOps Engineering Project

A hands-on DevOps project focused on containerization, CI/CD automation, infrastructure as code, configuration management, and cloud deployment.

## About the Project

This repository contains my DevOps implementation and configuration for an existing Inventory Management application built with Spring Boot, React, and PostgreSQL.

The goal is to develop a repeatable deployment workflow, automate testing, and eventually measure application performance and infrastructure behavior under load.

**Original application:** [Inventory Manager — Oussama Hdidou](https://github.com/oussamahdidou/inventory-manager-springboot-react)

## Technology Stack

- Docker and Docker Compose
- Java 21 and Gradle
- PostgreSQL
- Jenkins
- Terraform
- Ansible
- AWS
- Linux and Bash

Tools will be introduced as the project progresses and their purpose is established.

## Current Progress

- [x] Investigated and resolved the initial Spring Boot test configuration issue.
- [x] Ran PostgreSQL in a Docker container.
- [x] Moved database settings toward environment-based configuration.
- [x] Created a multi-stage Dockerfile for the Spring Boot backend.
- [x] Built the backend Docker image locally.
- [ ] Run the backend and PostgreSQL together with Docker Compose.
- [ ] Implement an automated Jenkins CI pipeline.
- [ ] Provision AWS infrastructure using Terraform.
- [ ] Automate server configuration using Ansible.
- [ ] Deploy, monitor, and load-test the application.

## Repository Structure

```text
inventory-manager-devops/
├── api/
│   ├── Dockerfile
│   ├── .dockerignore
│   └── src/main/resources/
│       └── application.properties
├── .env.example
├── .gitignore
└── README.md
```

This repository currently contains DevOps configuration rather than a complete copy of the application source.

## Getting Started

Obtain the original application source from the repository linked above. The backend Dockerfile in this repository is intended to be used with the original application's `api` directory as the Docker build context.

Local configuration should use environment variables. Do not commit `.env` files or real credentials.

## Engineering Principles

- Automate repeatable tasks.
- Keep credentials out of source control.
- Prefer least-privilege configurations.
- Diagnose failures using logs and evidence.
- Measure performance rather than making unsupported claims.
- Document implementation decisions and troubleshooting.

## Project Status

This project is under active development. The checklist above distinguishes completed work from planned milestones.

More implementation details and lessons learned will be documented as the project progresses.

## License and Attribution

The original application's source remains the property of its respective author. This repository documents my DevOps work and does not claim authorship of the original application.

