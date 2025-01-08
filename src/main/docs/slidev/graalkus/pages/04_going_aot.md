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

<arrow v-click="[4, 5]" x1="700" y1="300" x2="220" y2="200" color="#953" width="2" arrowSize="1" />


2. exclude the relevant tests :

```java
    @Test @DisabledInNativeImage void testPdf() { ... }
```

</v-clicks>

<arrow v-click="[6, 7]" x1="700" y1="350" x2="220" y2="480" color="#539" width="2" arrowSize="1" />
