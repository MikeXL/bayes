ttest.fun <- function(theta, x, y) {
  # parameters
	mu1 <- theta[1]
	sd1 <- theta[2]
	mu2 <- theta[3]
	sd2 <- theta[4]
	nu <- theta[5]

  # no negative standard deviations, right?!
	if(sd1 <=0 | sd2 <= 0) { return(-Inf) }

  # priors
  sigma <- sd(c(x,y))
  log.prior <- dnorm(mu1, sd = sigma*1e3,  log=T) +                   # mu1 ~ N(0, sd*1e3)
               dunif(sd1, min= sigma*1e-3, max=sigma*1e3, log=T) +    # sd1 ~ unif(sd*1e-3, sd*1e3)
  				     dnorm(mu2, sd = sigma*1e3,  log=T) +                   # mu2 ~ N(0, sd*1e3)
               dunif(sd2, min= sigma*1e-3, max=sigma*1e3, log=T) +    # sd2 ~ unif(sd*1e-3, sd*1e3)
  				     dexp((nu-1), 1/29, log=T)                              # nu  ~ exp(1/29) + 1

  # likelihood
	log.like <- sum(dt({x-mu1}/sd1, df=nu, log=T) - log(sd1)) +         # x ~ T(mu1, sd1, nu) ~ t({x-mu}/sd, nu)/sd
              sum(dt({y-mu2}/sd2, df=nu, log=T) - log(sd2))           # y ~ T(mu1, sd1, nu) ~ t({x-mu}/sd, nu)/sd

  # posterior
	ll <- log.like + log.prior

	ifelse(is.na(ll) | is.nan(ll), -Inf, ll)                            # deal with the missing values
}

bayes.t.test <- function(x, y, nmc=20000, nbi=20000) {
  out <- bayes::mcmc(ttest.fun, c(mean(x), sd(x), mean(y), sd(y), 5), nmc, nbi, x=x, y=y)
  colnames(out) <- c("mu1", "sd1", "mu2", "sd2", "nu")
  return(out)
}
