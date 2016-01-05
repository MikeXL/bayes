A Study of Binomial
=========================================

Binomial test is the simplest from all other tests. Here is why

beta(a, b) * binomial(n, k) -> beta(a+n, b+n-k)

with that we can directly sample from the posterior ;)
usually the prior selection will be flat a=b=1 or Jeffery's a=b=.5
or else you have a strong belief of what you have already know.
