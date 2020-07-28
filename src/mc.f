C sketch 
C        metropolis hasting monte carlo 
C        hamiltonian monte carlo
C not really gonna use it, consider there are 
C MCMCpack and STAN
C rather for fun and jot down thoughts
C
C   arXiv:1808.08490v2  
C   MikeXL/bayes/R/mcmc.r
C
C metropolis hasting, the simplest one 
C target the logged posterior function
C nmc number iterations 
C nbi burnin 
C chain the Markov chain 
C23456789
      subroutine metrop(target, nmc, nbi, chain)
        call random_number(chain(1, :)) 
        do 71 i = 2, nmc
          x = chain(i-1, :)
          call random_number(chain(i, :)
          call random_number(metropolis) 
          h = exp(target(chain(i, :)) - target(x))
          if h > metropolis then 
C accept
          else
C reject 
            chain(i, :) = x
          end 
 71     continue 
      end subroutine metrop
C
C Hamiltonian, put out your sketchbook 
C derivatives 
C
      subroutine ham()
        do 99 i = 1, nmc
C where the magic happens 
          call molecular_dynamics(..., Hi, Hf)
          h = exp(Hf - Hi)
          call random_number(metropolis)
          if h > metropolis then 
C
          else
C
          end if
 99     continue 
      end subroutine ham
