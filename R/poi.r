poisson.fun <- function(theta, x, y) {
  # parameters
  lambda1 <- theta[1]
  lambda2 <- theta[2]

  # priors
  log.priors <- dgamma(lambda1, .5, 1e-5, log=T) + dgamma(lambda2, .5, 1e-5, log=T)

  # likelihood
  log.like <- dpois(x, lambda1, log=T) + dpois(y, lambda2, log=T)

  ll <- log.priors + log.like
  
  ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}


bayes.poisson.test <- function(x, y, nmc=20000, nbi=20000) {
  theta.init <- c(mean(x), mean(y))
  out <- bayes::mcmc(poisson.fun, theta.init, nmc, nbi, x=x, y=y)
  colnames(out) <- c("lambda1", "lambda2")
  return(out)
}
