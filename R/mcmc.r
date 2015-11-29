
metrop.proposal.fun <- function(theta){
  # finding the right scaling factor is more of an art than science
  # or try and error to look for the best fit on acceptance %

  return(rnorm(length(theta), mean=theta, sd=rep(sqrt(.5), length(theta))))
}


simple.proposal.fun <- function(theta){
  return(theta+rnorm(1))
}

hamiltonian.proposal.fun <- function(theta){
  return(theta+rnorm(1))
}

mcmc <- function(fun, theta.init, nmc, nbi, hmc=FALSE, ...) {

  iterations <- nmc + nbi
  chain <- array(dim = c(iterations, length(theta.init)))
  chain[1, ] <- theta.init

  # choose the proposal function
  if(hmc){
    propose <- hamiltonian.proposal.fun  #hamiltonian
  }else{
    propose <- metrop.proposal.fun       #metropolis hasting
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
