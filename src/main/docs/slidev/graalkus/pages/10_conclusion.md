# Conclusion

<style>
td {
  font-size: 10px;
}
li {
  font-size: 10px;
}
</style>

Comparing the benchmark results, it is possible to see : 

* <span v-mark.blue="1">AOT memory footprint is less than half of JIT application</span>
* <span v-mark.orange="2">CPU Usage of all versions is comparable (except at startup, where JIT consumes more resources)</span>
* <span v-mark.green="3">Number of request for JIT and AOT PGO is comparable</span>
* <span v-mark.purple="4">AOT startup time is about 30/40 times lower than JIT version _(*)_</span>

|   |                   | JIT                                             | AOT                                            | AOT PGO                                       |
|:--|-------------------|-------------------------------------------------|------------------------------------------------|-----------------------------------------------|
|   | memory (MB)       | <span v-mark.circle.blue="1">≈ 400/500</span>   | <span v-mark.circle.blue="1">≈ 150/200</span>  | <span v-mark.circle.blue="1">≈ 150/200</span> |
|   | cpu (%)           | <span v-mark.circle.orange="2">≈ 150/100</span> | <span v-mark.circle.orange="2">≈ 100</span>    | <span v-mark.circle.orange="2">≈ 100</span>   |
|   | request/s         | <span v-mark.circle.green="3">16291</span>      | 12340                                          | <span v-mark.circle.green="3">15381</span>    |
|   | startup time (ms) | <span v-mark.circle.purple="4">682</span>       | <span v-mark.circle.cirle.purple="4">25</span> | <span v-mark.circle.purple="4">17</span>      |

_(*)_ Especially useful for scale to zero scenario (AWS Lambda, Google Functions and so on).