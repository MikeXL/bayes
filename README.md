# bayes

*Disclaimer:* _this package is created for fun, not practically for production use_, but please feel free to enhance it and use.


## Introduction
Just would like to have fun with bayesian and Monte Carlo simulations. There are good packages like MCMCpack for simulation, however it does not support Hamiltonian, at least not that I know of.

The t.test piece is based on J.K. Kruschke's paper on _Bayesian Estimation Supersedes the t-test_ (BEST).

## Monte Carlo Simulation

```
out <- mcmc(fun, nmc=1000, nbi=100, hmc=FALSE, ...)

fun ... The logged posterior sampling function
nmc ... The iterations of Markov Chains
nbi ... Number of burn ins
hmc ... Hamiltonian Monte Carlo or sometime named hybrid Monte Carlo,   
        default is FALSE with simple propose function. Yet to be implemented.

```


## t.test
Here is the run based on the toy mcmc simulation function I wrote.
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

If you would like to run the simulation with *MCMCpack*,
ttest.fun is the posterior sampling function (logged)

```
library(MCMCpack)

#Generate a sample
x <- rnorm(5, 0, 1)
y <- rnorm(5, 0, 3)

init <- c(mean(x), sd(x), mean(y), sd(y), 5)

mc.out <- MCMCmetrop1R(ttest.fun, theta.init=init, x=x, y=y, mcmc=20000, burnin=20000)
plot(mc.out)
```

The easiest way to run the simulation is from [this][http://www.sumsar.net/best_online/]
or install the BEST R package.

## Installation

```
library(devtools)
install_github("mikexl/bayes")
```
