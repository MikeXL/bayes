binomial.fun <- function(theta, x, y) {
  # parameters
  # theta1, theta2

  N.Success <- x
  N.Trial   <- y

  # flat priors
  log.priors <- sum(dbeta(theta, 1, 1, log=T))
  # Jeffrey's priors
  # log.priors <- dbeta(theta, .5, .5, log=T)

  # likelihood
  log.like <- sum(dbinom(N.Success, N.Trial, theta, log=T))

  ll <- log.priors + log.like

  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}

bayes.binomial.test <- function(x, n, nmc=20000, nbi=20000) {
  theta.init <- (sum(x)+1) / (sum(n)+2)
  out <- bayes::mcmc(binomial.fun, theta.init, nmc, nbi, x=x, y=n)
  return(out)
}
