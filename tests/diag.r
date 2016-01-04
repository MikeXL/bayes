
diag <- function(mc.out) {

  require(coda)

  traceplot(mc.out)
  densplot(mc.out)
  cumuplot(mc.out)
  autocorr.plot(mc.out)
  crosscorr.plot(mc.out)
  #caterplot(mc.out)    #require(mcmcplot)

  summary(mc.out)
  effectiveSize(mc.out)
  heidel.diag(mc.out)
  geweke.diag(mc.out)
  #gelman.diag(mc.list)   #multiple chains

  cat("acceptance % = ", 1-mean(duplicated(mc.out)))

  unload("package:coda", unload=T)
}
