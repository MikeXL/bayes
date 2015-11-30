
metrop.proposal.fun <- function(theta){
  # finding the right scaling factor is more of an art than science
  # or try and error to look for the best fit on acceptance %

  return(rnorm(length(theta), mean=theta, sd=rep(sqrt(.5), length(theta))))
}


simple.proposal.fun <- function(theta){
  return(theta+rnorm(1))
}

# hamiltonian gradient function
grad_U <- function(theta) {
  return(0)
}

# from R.M. Neal's paper MCMC using Hamiltonian dynamics
hmc = function (U, grad_U, L, epsilon, current_q, ...)
{
  #L=20
  #epsilon = .18
  q = current_q
  p = rnorm(length(q),0,1)  # independent standard normal variates
  current_p = p

  p = p - epsilon * grad_U(q) / 2           # Make a half step for momentum at the beginning
  for (i in 1:L)                            # Alternate full steps for position and momentum
  {
    q = q + epsilon * p                     # Make a full step for the position
    if (i!=L) p = p - epsilon * grad_U(q)   # Make a full step for the momentum, except at end of trajectory
  }
  p = p - epsilon * grad_U(q) / 2           # Make a half step for momentum at the end.

  # Negate momentum at end of trajectory to make the proposal symmetric
  p = -p
  # Evaluate potential and kinetic energies at start and end of trajectory
  current_U = U(current_q, ...)
  current_K = sum(current_p^2) / 2
  proposed_U = U(q, ...)
  proposed_K = sum(p^2) / 2

  # Accept or reject the state at end of trajectory, returning either
  # the position at the end of the trajectory or the initial position
  if (runif(1) < exp(current_U-proposed_U+current_K-proposed_K))
  {
    return (q)          # accept
  }else{
    return (current_q)  # reject
  }
}


hamiltonian.proposal.fun <- function(theta){
  #forget it.. it is a good theory
  # H(q, p) = U(q) + K(p) .. the potential and kinetic energy
  # simulate data by the way of the physical system moves than a random walk
  # faster convergence
  # more parameters to worry: epsilon, M, t, L
  # not to mention the change of proposal..
  #   U(q) = -log[pi(q) * L(q|D)]
  # hmc proposal and actual simulation is tight up
  #  condition:
  #     runif(1) < exp(-U(q*)+U(q)-K(p*)+K(p))
  #
  # good read, I'll leave the work for others :)
  #
  #return(hmc(theta, ...))

  return(theta+rnorm(length(theta)))
}

# Metroplis Hasting Monte Carlo Simulation
# fun .......... the logged posterior sampling function
# theta.init ... initial parameter(s) value
# nmc .......... number of Markov Chains
# nbi .......... number of burn-ins
# hmc .......... reserved for future Hamiltonian or RWHMC implementation
mcmc <- function(fun, theta.init, nmc, nbi, hmc=FALSE, ...) {

  iterations <- nmc + nbi
  chain <- array(dim = c(iterations, length(theta.init)))
  chain[1, ] <- theta.init

  # choose the proposal function
  if(hmc){
    propose <- hamiltonian.proposal.fun  #hamiltonian
  }else{
    propose <- metrop.proposal.fun       #random walk
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
