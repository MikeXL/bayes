# bayes

*Disclaimer:* _this package is created for fun, not practically for production use_, but please feel free to enhance it and use.


## Introduction
The Phantom Menace: _P(A|B) = P(B|A) * P(A) / P(B)_  
![Bayesian Inference on Sheldon's Life Expectancy in Big Bang Theory][5]

Just would like to have fun with _bayesian_ statistics and (Monte Carlo) _simulations_. There are good packages like MCMCpack for simulation, however it does not support Hamiltonian, and not been updated for years.

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

## Installation

Install from GitHub
```
library(devtools)
install_github("mikexl/bayes")
```

Or clone the source from github then install from command line
```
R CMD build bayes
R CMD INSTALL bayes_0.6.1.tar.gz
```


[1]: https://gallery.cortanaanalytics.com/Experiment/dcf16dbf200c4d4b88d091b642fb7770
[2]: http://www.sumsar.net/best_online/
[3]: http://learntech.uwe.ac.uk/da/Default.aspx?pageid=1438
[4]: https://public.tableau.com/profile/spock/
[5]: http://mjliu.com/stats/bayes-bbt.png "Bayesian Inference in Big Bang Theory"
