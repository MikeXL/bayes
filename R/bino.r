binomial.fun <- function(theta, x, y) {
  # parameters
  # theta1, theta2

  # flat priors
  #log.priors <- sum(dbeta(theta[1], 1, 1, log=T)) +
  #              sum(dbeta(theta[2], 1, 1, log=T))

  # Jeffrey's priors
  log.priors <- sum(dbeta(theta[1], .5, .5, log=T)) +
                sum(dbeta(theta[2], .5, .5, log=T))

  # likelihood
  log.like <- sum(dbinom(x[, 1], x[, 2], theta[1], log=T)) +
              sum(dbinom(y[, 1], y[, 2], theta[2], log=T))

  ll <- log.priors + log.like

  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}

bayes.binomial.test <- function(x, y, nmc=20000, nbi=20000) {
  theta.init <- c((sum(x[, 1])+1) / (sum(x[, 2])+2), (sum(y[, 1])+1) / (sum(y[, 2])+2))
  out <- bayes::mcmc(binomial.fun, theta.init, nmc, nbi, x=x, y=y)
  return(out)
}
