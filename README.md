# graalkus

[![Keep a Changelog v1.1.0 badge](https://img.shields.io/badge/changelog-Keep%20a%20Changelog%20v1.1.0-%23E05735)](https://github.com/fugerit-org/graalkus/blob/master/CHANGELOG.md)
[![license](https://img.shields.io/badge/License-MIT%20License-teal.svg)](https://opensource.org/license/mit)
[![code of conduct](https://img.shields.io/badge/conduct-Contributor%20Covenant-purple.svg)](https://github.com/fugerit-org/fj-universe/blob/main/CODE_OF_CONDUCT.md)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=fugerit-org_graalkus&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=fugerit-org_graalkus)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=fugerit-org_graalkus&metric=coverage)](https://sonarcloud.io/summary/new_code?id=fugerit-org_graalkus)
[![Docker images](https://img.shields.io/badge/dockerhub-images-important.svg?logo=Docker)](https://hub.docker.com/repository/docker/fugeritorg/graalkus/general)

[![Java runtime version](https://img.shields.io/badge/run%20on-java%2021+-%23113366.svg?style=for-the-badge&logo=openjdk&logoColor=white)](https://universe.fugerit.org/src/docs/versions/java21.html)
[![Java build version](https://img.shields.io/badge/build%20on-GraalVM%2021+-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)](https://universe.fugerit.org/src/docs/versions/gvm21.html)
[![Apache Maven](https://img.shields.io/badge/Apache%20Maven-3.9.0+-C71A36?style=for-the-badge&logo=Apache%20Maven&logoColor=white)](https://universe.fugerit.org/src/docs/versions/maven3_9.html)

## Documentation

Documentation of this project has been produced with a doc-as-code approach.

[Here you can find project documentation index](https://graalkus.fugerit.org/) published through GitHub pages.

Introduction slides are available thanks to [Slidev](https://sli.dev/) : 

[![Slideshow](https://img.shields.io/badge/HTML-Slideshow-greeb?style=for-the-badge)](https://graalkus.fugerit.org/graalkus-slidev/ "Go to project Slideshow")

While [AsciiDoc](https://asciidoc.org/) full documentation is here :

[![HTML - Documentation](https://img.shields.io/badge/HTML-Documentation-blue?style=for-the-badge)](https://graalkus.fugerit.org/book/ "Go to project HTML documentation")
[![PDF - Documentation](https://img.shields.io/badge/PDF-Documentation-red?style=for-the-badge)](https://graalkus.fugerit.org/book/graalkus.pdf "Go to project PDF documentation")


## Quickstart

Requirement :

* maven 3.9.x
* java 21+ (GraalVM for native version)

NOTE: All benchmarks has been run on Oracle GraalVM 23.

1. Verify the app

```shell
mvn verify
```

2. Start the app

```shell
mvn quarkus:dev
```

3. Try the app

Open the [swagger-ui](http://localhost:8080/q/swagger-ui/)

Test available paths (for instance : [/doc/example.md](http://localhost:8080/doc/example.md))

NOTE:

* Powered by Quarkus 3.17.2
* Using Fugerit Venus Doc 8.11.4 (extensions : fj-doc-base,fj-doc-freemarker,fj-doc-mod-fop,fj-doc-mod-opencsv)

## Native version

If you picked only native modules, you should be able to build and run the AOT version (GraalVM 21+ needed).

Further documentation :

* [List of modules and native support](https://venusdocs.fugerit.org/guide/#available-extensions)
* [Fugerit Venus Doc native support introduction](https://venusdocs.fugerit.org/guide/#doc-native-support)

1. Build and verify

```shell
mvn package -Dnative
```

2. Start

```shell
./target/graalkus-*-runner
```

## Container deployment

Requirement :

* Container environment (Docker or Podman)

> Note: It is recommended to install the latest versions of [Docker Desktop](https://www.docker.com/products/docker-desktop/) or [Podman Desktop](https://podman-desktop.io/). 

Pick a docker compose file (inside the [src/main/docker](src/main/docker)) and run by using docker compose or podman compose. Se example below: 

```shell
# If you have a docker environment
# This syntax of docker compose is available from then Docker Desktop 3.4
docker compose -f src/main/docker/docker-compose.yml up -d

# If you have a podman environment
# This syntax of podman compose is available from the Podman 4.0
podman compose -f src/main/docker/docker-compose.yml up -d
```

NOTE: both amd64 and arm64 (including macOS) [pre-built images](https://hub.docker.com/r/fugeritorg/graalkus) are available.

## Run benchmark with siege

Requirement :

* siege
* psrecord (optional for plotting)

Start the application and run :

```shell
./src/main/script/bench-graph-siege.sh 
```

The result output file is in the `target` directory.

## Run benchmark with h2load

Requirement :

* h2load
* psrecord (optional for plotting)

Start the application and run : 

```shell
./src/main/script/bench-graph-h2-load.sh 
```

The result output file is in the `target` directory.

## Run benchmark on different url

Default for benchmark is to run on http://localhost:8080.

To run on a different url use the -u parameter, for instance : 

```shell
./src/main/script/bench-graph-h2-load.sh -u http://localhost:8081
```

The result output file is in the `target` directory.

## Run benchmark with plotting

To run benchmark with plotting, psrecord should be installed.

Build the application without launching it, and run : 

```shell
mvn install -Dnative
./src/main/script/bench-graph-h2-load.sh -m AOT
```

or 

```shell
mvn package
./src/main/script/bench-graph-h2-load.sh -m JIT
```

The result output file is in the `target` directory.

## Build the documentation

Requirement : 

* NodeJS 20+
* Mermaid CLI

### AsciiDoc documentation

[AsciiDoc](https://asciidoc.org/) source folder is located at : 

[src/main/docs/asciidoc](src/main/docs/asciidoc)

It is possible to build HTML and PDF documentation running : 

```shell
mvn install -Pdocs
```

Output will be in `target/site` directory.

### Slidev slideshow

[Slidev](https://sli.dev/) source folder is located at : 

[src/main/docs/slidev/graalkus](src/main/docs/slidev/graalkus)

