ttest.fun <- function(theta, x, y) {
  #parameters
	mu1 <- theta[1]
	sd1 <- theta[2]
	mu2 <- theta[3]
	sd2 <- theta[4]
	nu <- theta[5]

	if(sd1 <=0 | sd2 <= 0) { return(-Inf) }

  #priors
    sigma <- sd(c(x,y))
    log.prior <- dnorm(mu1, sd=1000*sigma, log=T) + dunif(sd1, min=sigma/1000, max=sigma*1000, log=T) +
  				dnorm(mu2, sd=1000*sigma, log=T) + dunif(sd2, min=sigma/1000, max=sigma*1000, log=T) +
  				dexp(nu-1, 1/29, log=T)

  #likelihood
	log.like <- sum(dt({x-mu1}/sd1, df=nu, log=T) - log(sd1)) + sum(dt({y-mu2}/sd2, df=nu, log=T) - log(sd2))

	ll <- log.like + log.prior

	ifelse(is.na(ll) | is.nan(ll), -Inf, ll)
}

metrop.proposal.fun <- function(theta){
    return(rnorm(length(theta), mean=theta, sd=rep(.3, length(theta))))
}

hamiltonian.proposal.fun <- function(thta){
  return(1)
}

mcmc <- function(fun, theta.init, nmc, nbi, hmc=FALSE, ...) {
  iterations <- nmc + nbi
  chain <- array(dim = c(iterations, length(theta.init)))
  chain[1, ] <- theta.init

  if(hmc){
    propose <- hamiltonian.proposal.fun
  }else{
    propose <- metrop.proposal.fun
  }
  

  for(i in 1:(iterations-1)) {
    proposal <- propose(chain[i, ])

    p <- exp(fun(proposal, ...) - fun(chain[i, ], ...))
    if(runif(1) < p) {
      chain[i+1, ] <- proposal       #accept
    }else{
      chain[i+1, ] <- chain[i, ]     #reject
    }
  }
  return(chain[-(1:nbi), ])
}

#out <- mcmc(ttest.fun, c(mean(x), sd(x), mean(y), sd(y), 5), 5000, 2000, x=x, y=y)
