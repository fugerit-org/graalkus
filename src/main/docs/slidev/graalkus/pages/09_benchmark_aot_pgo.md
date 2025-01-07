# Benchmark PGO AOT

<table>
  <tr>
    <td style="width: 50%; font-size: 10px">


1. Run some load on the AOT PGO application

**./src/main/script/bench-graph-siege.sh -m AOT**

2. Check the load result : 

<pre>
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
</pre>

<br/>
<br/>
    </td>
    <td style="width: 50%; font-size: 10px">
      <img alt="Resources plotting for AOT PGO application" src="../images/01_step_04_aot_optimized_plot_b.png" width="100%" />
        <p style="text-align: center">Figure: Resources plotting for AOT PGO application</p>
    </td>
  </tr>
</table>


<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->