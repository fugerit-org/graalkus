# AOT Profile Guided Optimization

When going native, it is usually a good idea to optimize the application.

<v-clicks depth="1">

1. On graalkus there are some specific feature to collect load data (instrumentation) : 

```shell
mvn install -Dnative -Pinstrumented
```

2. Run some relevant load : 

```shell
./target/graalkus-*-instrumented-runner
./src/main/script/bench-graph-siege.sh
```

3. Build the optmized executable : 

```shell
mvn install -Dnative -Poptimized
```

NOTE: PGO is only a unique feature of Oracle GraalVM (not available on GraalVM community edition or Mandrel).

</v-clicks>