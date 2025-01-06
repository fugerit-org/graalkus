# Going AOT

Some modification to the project are needed. The main one is to exclude some dependencies when native profile is activated to avoid build time failure.

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

And esclude the relevant tests :

```java
    @Test @DisabledInNativeImage void testPdf() { ... }
```