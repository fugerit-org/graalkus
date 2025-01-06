# Conclusion

Comparing the benchmark results, it is possible to see : 

* Number of request for JIT and AOT PGO is comparable
* CPU Usage of all versions is comparable
* AOT memory footprint is less than half of JIT application
* AOT startup time is about 30 times lower than JIT version _(*)_.

|                   | JIT       | AOT       | AOT PGO   |
|-------------------|-----------|-----------|-----------|
| request/s         | 16291     | 12340     | 15381     |
| memory (MB)       | ≈ 400/500 | ≈ 150/200 | ≈ 150/200 |
| cpu (%)           | ≈ 100%    | ≈ 90%     | ≈ 90%     |
| cpu (%)           | ≈ 100%    | ≈ 90%     | ≈ 90%     |
| startup time (ms) | 682       | 25        | 17        |

_(*)_ Especially useful for scale to zero scenario (AWS Lambda, Google Functions and so on).