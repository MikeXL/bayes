# bayes
Have fun being baysianism


```
out <- mcmc(fun, nmc=1000, nbi=100, hmc=FALSE, ...)

fun ... The logged posterior sampling function
nmc ... The iterations of Markov Chains
nbi ... Number of burn ins
hmc ... Hamiltonian Monte Carlo or sometime named hybrid Monte Carlo, default is FALSE with simple propose function

```

```
x <- c(1,2,3,4,5)
y <- c(5,4,3,2,1)
out <- bayes.t.test(x, y)
mean_diff <- out[, "mu1"] - out[, "mu2"]
hist(mean_diff, breaks=25)
abline(h=quantile(mean_diff, .025))
abline(h=quantile(mean_diff, .975))
