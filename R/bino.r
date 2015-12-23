binomial.fun <- function(theta, x, y) {
  # parameters
  # theta1, theta2

  N.Trial.x   <- x[, 1]
  N.Success.x <- x[, 2]
  N.Trial.y   <- y[, 1]
  N.Success.y <- y[, 2]

  # priors
  log.priors <- dbeta(theta[1], 1, 1, log=T) + dbeta(theta[2], 1, 1, log=T)

  # likelihood
  log.like <- sum(dbinom(N.Success.x, N.Trial.x, theta[1], log=T)) +
              sum(dbinom(N.Success.y, N.Trial.y, theta[2], log=T))

  ll <- log.priors + log.like

  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}

binomial.1g.fun <- function(theta, x) {
  # parameters
  # theta

  N.Trial   <- x[ ,1]
  N.Success <- x[, 2]

  # priors
  log.priors <- dbeta(theta, 1, 1, log=T)

  # likelihood
  log.like <- sum(dbinom(N.Success, N.Trial, theta, log=T))

  ll <- log.priors + log.like

  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}

bayes.binomial.test <- function(x, y=NULL, nmc=20000, nbi=20000) {
  if(is.null(y)) {
    theta.init <- sum(x[, 2]) / sum(x[, 1])
    out <- bayes::mcmc(binomial.1g.fun, theta.init, nmc, nbi, x=x)
    colnames(out) <- c("theta")
  } else {
    theta.init <- c(sum(x[, 2]) / sum(x[, 1]), sum(y[, 2]) / sum(y[, 1]))
    out <- bayes::mcmc(binomial.fun, theta.init, nmc, nbi, x=x, y=y)
    colnames(out) <- c("theta1", "theta2")
  }
  return(out)
}
