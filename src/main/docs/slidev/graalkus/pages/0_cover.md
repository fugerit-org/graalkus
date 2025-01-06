---
# You can also start simply with 'default'
theme: default
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: 'https://raw.githubusercontent.com/fugerit-org/graalkus/refs/heads/main/src/main/docs/slidev/graalkus/images/cover_alt2.png'
# some information about your slides (markdown enabled)
title: 'Graalkus: A GraalVM/Quarkus Demo Migrating from JIT to AOT'
info: |
  ## Graalkus: Let Quarkus fly high with GraalVM

favicon: 'https://raw.githubusercontent.com/fugerit-org/graalkus/refs/heads/main/src/main/docs/slidev/graalkus/images/favicon.png'
  Learn more at [Graalkus](https://github.com/fugerit-org/graalkus)
# apply unocss classes to the current slide
class: text-center
# https://sli.dev/features/drawing
drawings:
  persist: false
# slide transition: https://sli.dev/guide/animations.html#slide-transitions
transition: slide-left
# enable MDC Syntax: https://sli.dev/features/mdc
mdc: true
---

# Graalkus

Let Quarkus fly high with GraalVM

<div @click="$slidev.nav.next" class="mt-12 py-1" hover:bg="white op-10">
  Press Space for next page <carbon:arrow-right />
</div>

<div class="abs-br m-6 text-xl">
  <a href="https://github.com/fugerit-org/graalkus" target="_blank" class="slidev-icon-btn">
    <carbon:logo-github />
  </a>
</div>

<!--
The last comment block of each slide will be treated as slide notes. It will be visible and editable in Presenter Mode along with the slide. [Read more in the docs](https://sli.dev/guide/syntax.html#notes)
-->