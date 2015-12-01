# bayes

*Disclaimer:* _this package is created for fun, not practically for production use_, but please feel free to enhance it and use.


## Introduction
The Phantom Menace: _P(A|B) = P(B|A) * P(A) / P(B)_  

Just would like to have fun with bayesian and Monte Carlo simulations. There are good packages like MCMCpack for simulation, however it does not support Hamiltonian, at least not that I know of.

The t.test piece is based on J.K. Kruschke's paper on _Bayesian Estimation Supersedes the t-test_ (BEST).

## Monte Carlo Simulation

The random walk version is quite straightforward,
to propose the new parameter value with adding an randomized number from N(0, 1) or
N(0, M) {if you prefer a scaling}, sometime it improves acceptance.
Tuning effort required.

The more exciting Hamiltonian simulation is to borrow the physics back into math,
that is very exciting. The basic is very simple, rather than doing a random walk,
use the way things move in the physics system to propose a new parameter value.
It improves acceptance rate and fast convergence. Guess nothing moves totally
randomly rather following physics laws.. ;) however, the reality is a bit different
story, as way many tuning parameters are introduced such as stepping size epsilon,  
Leap frog, and the M, forgot what that is, but definitely not James's boss.

Here is the toy version of the mcmc that I wrote and can be used with caution.
Source code in R/mcmc.r
```
out <- mcmc(fun, nmc=1000, nbi=100, hmc=FALSE, ...)

fun ... The logged posterior sampling function
nmc ... The iterations of Markov Chains
nbi ... Number of burn-ins
hmc ... Hamiltonian Monte Carlo or sometime named hybrid Monte Carlo,   
        default is FALSE with simple propose function. Yet to be implemented.

```


## BEST (Bayesian Estimation Supersedes t.test)

To do the t.test in bayesian way, is quite simple and straightforward too.
Based on J.K. Kurschke's paper, draw samples from T Distribution. That's it.
T
### the toy mcmc
he detailed prior and likelihood setup, please see code in R/best.r

And of course, I have created another toy function bayes.t.test
for independent two sample t.test.
```
bayes.t.test(x, y, nmc=20000, nbi=20000)

x ... the first group
y ... the second group

```

Here is the execution based on the toy mcmc simulation function I wrote above.
To make it a bit more interesting, [here][3] is one of the million the caffeine study.
I have uploaded the simulated results in data/caffeine.rda and also created an [tableau view][4].

```
x <- c(105, 119, 100, 97, 96, 101, 94, 95, 98)
y <- y <- c(96, 99, 94, 89, 96, 93, 88, 105, 88)
out <- bayes.t.test(x, y)
mean_diff <- out[, "mu1"] - out[, "mu2"]
hist(mean_diff, breaks=25)
abline(v=quantile(mean_diff, .025))
abline(v=quantile(mean_diff, .975))


acceptance = 1-mean(duplicated(out[])))
```

### MCMCpack
If you would like to run the simulation with *MCMCpack*,
ttest.fun is the posterior sampling function (logged).
I have an version published on Azure ML [here][1].

```
library(MCMCpack)

#Generate a sample
x <- rnorm(5, 0, 1)
y <- rnorm(5, 0, 3)

init <- c(mean(x), sd(x), mean(y), sd(y), 5)

mc.out <- MCMCmetrop1R(ttest.fun, theta.init=init, x=x, y=y, mcmc=20000, burnin=20000)
plot(mc.out)
```

### JAGS

The easiest way to run the simulation is from [this][2] or install the BEST R package.
This is the tool J.K.K used for his paper.

### PROC MCMC
SAS has a PROC MCMC and it is quite straightforward to use.

```
ods graphics on;
proc mcmc data=kit_paired outpost=out nmc=20000 nbi=0 diag=all;

	parms mu1 5 mu2 4 sigma1 2.14 sigma2 2.56 nu 5;

	prior mu1     ~ N(mu1, sd=2.34*1e6);    
	prior sigma1  ~ uniform(sigma1 * 1e-3, sigma1*1e3);   
	prior mu2     ~ N(mu2, sd=2.34*1e6);    
	prior sigma2  ~ uniform(sigma2*1e-3, sigma2*1e3);   
	prior nu      ~ expon(iscale=1/29);

	model a ~ t(mu1, sd=sigma1, nu+1);
	model b ~ t(mu2, sd=sigma2, nu+1);

run;
ods graphics off;
```



## Installation

Install from GitHub
```
library(devtools)
install_github("mikexl/bayes")
```

Or clone the source from github then install from command line
```
R CMD build bayes
R CMD INSTALL bayes_0.2.2.tar.gz
```


[1]: https://gallery.cortanaanalytics.com/Experiment/dcf16dbf200c4d4b88d091b642fb7770
[2]: http://www.sumsar.net/best_online/
[3]: http://learntech.uwe.ac.uk/da/Default.aspx?pageid=1438
[4]: https://public.tableau.com/profile/spock/
