# AOT migration approach

```mermaid {scale: 0.4, alt: 'Migration approch'}
flowchart TD
    A --> B
    B --> CF
    B --> |Assest features| CM
    A(Original JIT Application)
    B{Is full AOT
    conversion possible?}
    subgraph CM [Mixed conversion approach]
        E(AOT Features Application)
        F(JIT Features Application)
    end
    subgraph CF [Full conversion approach]
        C(AOT Application)
    end
```

<v-clicks depth="1">

1. <span v-mark.circle.green="1">Full</span> approach - when all the features can be easily configured to be included in a native build
2. <span v-mark.circle.orange="1">Mixed</span> approach - when not all features can be converted to AOT for any reason, for instance :
   - costs - we need to rewrite the feature and we decide conversion is not worth
   - technical limitation - some feature simply relies on some technology which cannot be converted (i.e. a very old library)

</v-clicks>

<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->