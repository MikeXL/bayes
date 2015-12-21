poisson.fun <- function(theta, x, y) {
  # parameters
  lambda1 <- theta[1]
  lambda2 <- theta[2]

  # priors
  priors <- dgamma(lambda1, .5, 1e-5, log=T) + dgamma(lambda2, .5, 1e-5, log=T)

  # likelihood
  ll <- dpois(x, lambda1, log=T) + dpois(y, lambda2, log=T)

  return (ll + priors)
}


bayes.poisson.test <- function(x, y, nmc=20000, nbi=20000) {
  theta.init <- c(rgamma(1, .5, 1e-5), rgamma(1, .5, 1e-5))
  out <- bayes::mcmc(poisson.fun, theta.init, nmc, nbi, x=x, y=y)
  colnames(out) <- c("lambda1", "lambda2")
  return(out)
}
