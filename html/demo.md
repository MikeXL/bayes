Use Cases
====================
As I have been working on the case of call centre a lot, like to use that as cases of demo.

## 1. call reduction program
A program introduced in call centre aiming to reduce calls. The experiment carries on ten customers,
heck, don't say it is too small of sample size, just hypothetical demo.

here is the data on customer call counts, 5 weeks before and after the program for the ten customers.

before <- c(20, 17, 21, 18, 29, 7, 17, 9, 17, 0)
after  <- c(18, 18, 19, 20, 10, 9, 16, 10, 8, 0)

now we need to know if the program effective.

we can simply do this.
```
  t.test(before, after, paired=T)
```
but that won't be fun at all, let's simulate
```
  diff <- after - before
  out  <- bayes.t.test(diff)
  require(coda)
  mcmc.out <- as.mcmc(out)
  plot(mcmc.out)
  summary(mcmc.out)
```

## 2. yet another call reduction program
Now we are running another more realistic call reduction program, rather we have the two experiments groups
call them A (control) and B (treatment), and we monitor the two groups for 10 weeks.

a <- c(12, 14, 16, 6, 13, 11, 10, 18, 10,  9)
b <- c(8,  5,  9,  9,  8,  7,  6, 10, 18,  7)

As the data follow poisson distribution, again, we can do the boring thing

```
  poisson.test(c(sum(a), sum(b)), c(10, 10))
```

again, let's do the fun thing
```
  out <- bayes.poisson.test(a, b)
  require(coda)
  out <- cbind(out, NA)
  colnames(out) <- c("lambda_a", "lambda_b", "lambda_a/lambda_b")
  out[, 3] <- out[, 1] / out[, 2]
  mcmc.out <- as.mcmc(out)
  plot(mcmc.out)
  summary(mcmc.out)
```

### 3. repeat reduction program
This is another interesting one, if you are in the call centre business,
you don't like customer to call you repeated for the same problem. And sometime it is called
First Call Resolution (FCR) or first order success (FOS), depends on which part of the department
you are in.

Again, we have an lovely program aiming improve the FCR, that has run 10 weeks for the two groups
naming A and B, in both case n=1000.

a <- c(803, 784, 802, 782, 760, 781, 772, 767, 795, 792)
b <- c(811, 827, 827, 817, 828, 824, 847, 832, 839, 829)

as the success of a call or repeats sorta follow Bernoulli trial, we can use binomial test
in the boring way

```
  binom.test(sum(a), n*length(a), p=sum(b)/(n*length(b)))
```

or do it in the exciting way

```
  x <- cbind(a, rep(n, length(a)))
  y <- cbind(b, rep(n, length(b)))
  out <- bayes.binomial.test(x, y, nmc=1000000)
  out <- cbind(out, NA)
  colnames(out) <- c("theta1", "theta2", "theta1 - theta2")
  out[, 3] <- out[, 1] - out[, 2]
  require(coda)
  mcmc.out <- as.mcmc(out)
  plot(mcmc.out)
  summary(mcmc.out)
```
