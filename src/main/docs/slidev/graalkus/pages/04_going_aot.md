# Going AOT

Some modifications to the project are needed. the main ones are : 

<v-clicks depth="1">

1. exclude some dependencies when native profile is activated to avoid build time failure.

```xml
    <profile>
      <id>native</id>
        ...
      <dependencies>
        <dependency>
          <groupId>org.fugerit.java</groupId>
          <artifactId>fj-doc-mod-fop</artifactId>
          <scope>provided</scope>
          <exclusions>
             ...
          </exclusions>
        </dependency>
      </dependencies>
    </profile>
```

2. exclude the relevant tests :

```java
    @Test @DisabledInNativeImage void testPdf() { ... }
```

</v-clicks>