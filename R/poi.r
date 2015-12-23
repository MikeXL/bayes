poisson.fun <- function(theta, x, y) {
  # parameters
  lambda1 <- theta[1]
  lambda2 <- theta[2]

  # priors
  log.priors <- dgamma(lambda1, .5, 1e-5, log=T) + dgamma(lambda2, .5, 1e-5, log=T)

  # likelihood
  log.like <- sum(dpois(x, lambda1, log=T)) + sum(dpois(y, lambda2, log=T))

  ll <- log.priors + log.like

  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}

poisson.1g.fun <- function(theta, x) {
  # parameters
  lambda <- theta[1]

  # priors
  log.priors <- dgamma(lambda, .5, 1e-5, log=T)

  # likelihood
  log.like <- sum(dpois(x, lambda, log=T))

  ll <- log.priors + log.like

  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}

bayes.poisson.test <- function(x, y=NULL, nmc=20000, nbi=20000) {
  if(is.null(y)) {
    theta.init <- (sum(x)+.5)/length(x)
    out <- bayes::mcmc(poisson.1g.fun, theta.init, nmc, nbi, x=x)
    colnames(out) <- c("lambda")
  } else {
    theta.init <- c((sum(x)+.5)/length(x), (sum(y)+.5)/length(y))
    out <- bayes::mcmc(poisson.fun, theta.init, nmc, nbi, x=x, y=y)
    colnames(out) <- c("lambda1", "lambda2")
  }
  return(out)
}
