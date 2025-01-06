# Benchmark JIT

<table>
  <tr>
    <td style="width: 50%; font-size: 10px">


1. Run some load on the JIT application

**./src/main/script/bench-graph-siege.sh -m JIT**

2. Check the load result : 

<pre>
{
  "transactions": 333324,
  "availability": 100,
  "elapsed_time": 20.11,
  "data_transferred": 404.11,
  "response_time": 0,
  "transaction_rate": 16575.04,
  "throughput": 20.09,
  "concurrency": 11.16,
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
      <img alt="Resources plotting for JIT application" src="../images/01_step_04_jit_plot_a.png" width="100%" />
        <p style="text-align: center">Figure: Resources plotting for JIT application</p>
    </td>
  </tr>
</table>


<!--
You can have `style` tag in markdown to override the style for the current page.
Learn more: https://sli.dev/features/slide-scope-style
-->