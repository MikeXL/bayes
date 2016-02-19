Simulation to calculate poisson sample size and power
-----------------------

```
N=seq(10, 200, 5)
mu1 = .1
mu2 = .3              # to make the calculation works, ensure mu1 <= mu2
nmc = 10000
df = array(dim=c(length(N), 5))
# type 1 err = .05

for (i in 1:length(N)){
	lambda_1 = rgamma(nmc, 2+N[i]*mu1, 1+N[i])
	lambda_2 = rgamma(nmc, 2+N[i]*mu2, 1+N[i])

	alpha = round(quantile(lambda_1, .975)[[1]], 2)  #not that accurate, proximate only; use HPD
	power = sum(round(lambda_2,2)>alpha)/nmc
	df[i, 1] = N[i]
	df[i, 2] = alpha
	df[i, 3] = power
	df[i, 4] = median(lambda_1)   #not 100% accurate, reference only
	df[i, 5] = median(lambda_2)   #not 100% accurate
}

colnames(df) <- c("N", "alpha", "power", "med_a", "med_b")
plot(power~N, data=df, type="l")
abline(h=.8, col="blue")
abline(h=.9, col="#cc8800")

```
