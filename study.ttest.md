A Study of t.test
===========================

The t.test piece is based on J.K. Kruschke's paper on _Bayesian Estimation Supersedes the t-test_ (BEST).

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
SAS has a PROC MCMC and it is quite straightforward to use though
I have keyed in a lot numbers

```
ods graphics on;
proc mcmc data = caffeine outpost = out nmc = 20000 nbi = 2000
          diag = all
          monitor = (mu1 sigma1 mu2 sigma2 mu_diff log_nu)
;

	parms mu1 5 mu2 4 sigma1 2.14 sigma2 2.56 nu 5;

	prior mu1     ~ N(mu1, sd=2.34*1e3);                   /* pooled standard deviation */
	prior sigma1  ~ uniform(sigma1*1e-3, sigma1*1e3);
	prior mu2     ~ N(mu2, sd=2.34*1e3);                   /* pooled standard deviation */
	prior sigma2  ~ uniform(sigma2*1e-3, sigma2*1e3);
	prior nu      ~ expon(iscale=1/29);                    /* it is actually nu - 1 */

	mu_diff = mu1 - mu2;
	log_nu  = log(nu+1);

	model a ~ t(mu1, sd=sigma1, (nu+1));
	model b ~ t(mu2, sd=sigma2, (nu+1));

run;
ods graphics off;
```
