# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- quarkus version 3.18.0
- using image tag v1.3.0 for docker-compose and openshift yml

## [1.3.0] - 2025-01-19

### Added

- Appendix C : Quarkus OpenShift Extension
- help for benchmark scripts
- updated readme with AsciiDoc build information
- updated readme with Slidev build information
- Part IV - CI, Build multi-platform image (GitHub)

### Changed

- CI to build docker image now use the new [GitHub linux arm64 runners](https://github.com/orgs/community/discussions/148648).
- quarkus version 3.17.7
- using image tag v1.2.2 for docker-compose and openshift yml
- fj-doc-version 8.11.9

## [1.2.2] - 2025-01-06

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