# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- quarkus version 3.25.3

## [1.3.4] - 2025-05-01

### Changed

- new banner image
- quarkus version 3.22.1

## [1.3.3] - 2025-04-16

### Changed

- native version now supports graalvm 24
- native workflows on graalvm 24 (instead of 23)
- fj-doc-version 8.12.8
- quarkus version 3.21.3

## [1.3.2] - 2025-02-26

### Changed

- compiler-plugin.version set to 3.14.0
- upgrade docker file to ubi-9 <https://quarkus.io/blog/quarkus-3-19-1-released/>
- quarkus.platform.group-id from io.quarkus to io.quarkus.platform 
- quarkus version 3.21.0
- fj-doc-version 8.12.6
- Change on the name of jobs for docker publish native workflows

## [1.3.1] - 2025-02-16

### Changed

- setup quarkus-info extension
- quarkus version 3.18.3
- using image tag v1.3.0 for docker-compose and openshift yml

### Fixed

- docs, slidev : esbuild 0.25.0+ <https://github.com/fugerit-org/graalkus/security/dependabot/3>
- docs, slidev : dompurify 3.2.4+ <https://github.com/fugerit-org/graalkus/security/dependabot/4>

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