Diagnostic
=======================================

### Plots
1. trace plot
2. density plot
3. autocorrelation and cross correlation
4. cumulative plot (95% quatile)
5. caterpillar plot (68%, 95% quatile)

### Summary
1. MCSE
2. effective size
3. heidel diagnostic
4. geweke diagnostic
5. gelman diagnostic
6. acceptance rate = (1 - mean(dupllicated(mc.out))) * 100 %



### SAS diag plots in R
here is how to do it in R
```
layout(matrix(c(1,1,2,3), 2,2, byrow=T))
plot(chain, type="l")
acf(chain)
plot(density(chain))
abline(v=quantile(chain, .025))    # quantile based 95% interval
abline(v=quantile(chain, .975))    # quantile based 95% interval
```
