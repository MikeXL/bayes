detach('package:bayes', unload=T)
require(bayes)

a <- rpois(10, 1.2)
b <- rpois(10, 1.3)

out<-bayes.poisson.test(a, b)

par(mfrow=c(3,2))
plot(out[,1], type="l")
hist(out[,1], breaks=80)
plot(out[,2], type="l")
hist(out[,2], breaks=80)
hist(out[,1]/out[,2], breaks=80)

abline(v=quantile(out[,1]/out[,2], .025), col="red")
abline(v=quantile(out[,1]/out[,2], .975), col="red")
hist(log(out[,1]/out[,2]), breaks=80)
abline(v=quantile(log(out[,1]/out[,2]), .975), col="red")
abline(v=quantile(log(out[,1]/out[,2]), .025), col="red")


poisson.test(c(sum(a), sum(b)), c(10, 10))



out <- bayes.binomial.test(matrix(c(3, 10, 25, 100), nrow=2, ncol=2))

b1 <- matrix(c(3, 10, 25, 100), nrow=2, ncol=2, byrow=T)
b2 <- matrix(c(30, 100, 27, 100), nrow=2, ncol=2, byrow=T)
out <- bayes.binomial.test(b1, b2)
