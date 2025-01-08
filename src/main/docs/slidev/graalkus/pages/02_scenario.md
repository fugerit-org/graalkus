# Application demo scenario

This demo is inspired by a real microservice I migrated to AOT some time ago.

The scenario for this project is a JIT application used generate documents in various formats (HTML, MarkDown, AsciiDoc and PDF), exposed as REST services.

Let's define every format as a feature, and the use of each format/feature : 

- <span v-mark.purple="1">HTML</span> : 40% 
- <span v-mark.orange="2">MarkDown</span> : 30%
- <span v-mark.green="3">AsciiDoc</span> : 20%
- <span v-mark.blue="4">PDF</span> : 10%

<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->