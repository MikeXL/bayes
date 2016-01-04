binomial.fun <- function(theta, x, prior) {

  # parameters
  # x[, 1] ... number of success
  # x[, 2] ... number of trials

  # priors  beta(a, b)
  #  flat beta(1, 1)
  #  jeffery beta(.5, .5
  #
  # log.priors <- sum(dbeta(theta, prior[1], prior[2], log=T))

  # likelihood
  # log.like <- sum(dbinom(x[, 1], x[, 2], theta, log=T))

  # ll <- log.priors + log.like
  # posterior is actually another beta(a+y, b+n-y)
  # therefore no need to run full monte carlo, just need to sample from 
  ll <- sum(dbeta(theta, prior[1]+sum(x[ ,1]), prior[2]+sum(x[ ,2]) - sum(x[ ,1]), log=T))

  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}
#
# x is a matrix (series) of success and trials
#      [,1] [,2]
# [1,]   23  100           100 trials with 23 success
# [2,]   24  200           200 trials with 24 success
#
bayes.binomial.test <- function(x, prior=c(1, 1), nmc=20000, nbi=20000) {
  theta.init <- (sum(x[, 1])+1) / (sum(x[, 2])+2)
  out <- bayes::mcmc(binomial.fun, theta.init, nmc, nbi, x=x, prior=prior)
  return(out)
}
