binomial.fun <- function(theta, x) {

  # parameters
  # x[, 1] ... number of success
  # x[, 2] ... number of trials

  # flat priors
  #log.priors <- sum(dbeta(theta, 1, 1, log=T))

  # Jeffrey's priors
  log.priors <- sum(dbeta(theta, .5, .5, log=T))

  # likelihood
  log.like <- sum(dbinom(x[, 1], x[, 2], theta, log=T))

  ll <- log.priors + log.like

  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}

bayes.binomial.test <- function(x, nmc=20000, nbi=20000) {
  theta.init <- (sum(x[, 1])+1) / (sum(x[, 2])+2)
  out <- bayes::mcmc(binomial.fun, theta.init, nmc, nbi, x=x)
  return(out)
}
