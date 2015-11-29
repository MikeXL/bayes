# bayes

## Introduction
Just would like to have fun with bayesian and Monte Carlo simulations. There are good packages like MCMCpack for simulation, however it does not support Hamiltonian, at least not that I know of.

The t.test piece is based on J.K. Kruschke's paper on _Bayesian Estimation Supersedes the t-test_ (BEST).

## Monte Carlo Simulation

```
out <- mcmc(fun, nmc=1000, nbi=100, hmc=FALSE, ...)

fun ... The logged posterior sampling function
nmc ... The iterations of Markov Chains
nbi ... Number of burn ins
hmc ... Hamiltonian Monte Carlo or sometime named hybrid Monte Carlo, default is FALSE with simple propose function. Yet to be implemented.

```


## t.test

```
x <- rnorm(5, 0, 1)
y <- rnorm(5, 0, 2)
out <- bayes.t.test(x, y)
mean_diff <- out[, "mu1"] - out[, "mu2"]
hist(mean_diff, breaks=25)
abline(v=quantile(mean_diff, .025))
abline(v=quantile(mean_diff, .975))


acceptance = 1-mean(duplicated(out[])))
```

## Installation

```
library(devtools)
install_github("mikexl/bayes")
```
