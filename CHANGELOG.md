# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Slidv site
- OpenShift scripts
- maven.compiler.proc = full (support lombok with java23)

### Changed

- GraalVM 23 for container build

## [1.2.1] - 2024-12-30

### Changed

- using siege for benchmark

### Fixed

- register for reflection

## [1.2.0] - 2024-12-30

### Changed

- setup on virtual threads (RunOnVirtualThread)

## [1.1.0] - 2024-12-28

### Added

- formatter-maven-plugin
- startup doc initialization

### Changed

- quarkus version 3.17.5
- fj-doc version 8.11.7
- docker-compose-mixed.yml no set to v1.0.0 images

## [1.0.0] - 2024-12-10

### Added

- OpenShift configuration files for sandbox
- Docker compose files for local run
- GitHub workflow for SonarCloud and Docker Hub publish
- Graalkus project
- AsciiDoc book version