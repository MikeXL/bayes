A Study of Poisson Test - glm v. simulation
=============================================

## Generate fake data

```
  ctl <- cbind(rpois(10, 4.2), rep(0,10))    # control group
  trt <- cbind(rpois(10, 3), rep(1,10)       # treatment
  d <- as.data.frame(rbind(trt, ctl))
  colnames(d) <- c("cnt", "trt")
```

### classy glm
```
  glm(cnt ~ trt, data=d, family="poisson")
  summary(d.glm)

Call:
glm(formula = cnt ~ trt, family = "poisson", data = d)

Deviance Residuals:
    Min       1Q   Median       3Q      Max
-3.2249  -0.6047   0.1423   0.7493   1.1369

Coefficients:
            Estimate Std. Error z value Pr(>|z|)
(Intercept)   1.6487     0.1387  11.889   <2e-16 ***
trt          -0.4547     0.2226  -2.043    0.041 *
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 25.666  on 19  degrees of freedom
Residual deviance: 21.382  on 18  degrees of freedom
AIC: 87.544

Number of Fisher Scoring iterations: 4

```
from that, we can estimate the interval of treatment/control ratio:
```
  exp(-.45 +/- .22 * 1.96) = [.41, .98]
```

### simulation

```
  out<- bayes.poisson.test(trt[,1], ctl[,1])
  summary(as.mcmc(out[,1]/out[,2]))

Iterations = 1:20000
Thinning interval = 1
Number of chains = 1
Sample size per chain = 20000

1. Empirical mean and standard deviation for each variable,
   plus standard error of the mean:

          Mean             SD       Naive SE Time-series SE
      0.652446       0.144050       0.001019       0.002957

2. Quantiles for each variable:

  2.5%    25%    50%    75%  97.5%
0.4131 0.5527 0.6373 0.7352 0.9772

```
from there, we learnt the treatment/control ratio [.41, .98] with median .64

P.S.
the actual ratio was 3/4.2 = .71
