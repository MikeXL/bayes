# bayes
Have fun being baysianism


```
out <- mcmc(fun, nmc=1000, nbi=100, hmc=FALSE, ...)

```
fun ... The logged posterior sampling function
nmc ... The iterations of Markov Chains
nbi ... Number of burn ins
hmc ... Hamiltonian Monte Carlo or sometime named hybrid Monte Carlo, default is FALSE with simple propose function 
