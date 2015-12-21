poisson.fun <- function(theta, x, y) {


}


bayes.poisson.test <- function(x, y, nmc=20000, nbi=20000)
  theta.init <- ?
  out <- bayes::mcmc(poisson.fun, theta.init, nmc, nbi, x=x, y=y)
  colnames(out) <- c("lambda1", "lambda2")
  return(out)
}
