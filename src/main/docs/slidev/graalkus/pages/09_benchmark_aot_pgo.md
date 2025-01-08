---
layout: image-right
image: 'https://raw.githubusercontent.com/fugerit-org/graalkus/refs/heads/main/src/main/docs/slidev/graalkus/images/01_step_04_aot_optimized_plot_b.png'
backgroundSize: 20em 80%
---

# Benchmark PGO AOT

<v-clicks depth="1">

1. Run some load on the AOT PGO application

```shell
./src/main/script/bench-graph-siege.sh -m AOT
```

2. Check the load result :

```json
{
  "transactions": 333324,
  "availability": 100,
  "elapsed_time": 21.67,
  "data_transferred": 425.72,
  "response_time": 0,
  "transaction_rate": 15381.82,
  "throughput": 19.65,
  "concurrency": 11.22,
  "successful_transactions": 333324,
  "failed_transactions": 0,
  "longest_transaction": 0.01,
  "shortest_transaction": 0
}
```

<arrow v-click="[5, 6]" x1="400" y1="200" x2="280" y2="320" color="#539" width="2" arrowSize="1" />

</v-clicks>


<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->