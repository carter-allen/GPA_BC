pkgname <- "GPA"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('GPA')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("GPA-class")
### * GPA-class

flush(stderr()); flush(stdout())

### Name: GPA-class
### Title: Class "GPA"
### Aliases: GPA-class show,GPA-method print,GPA-method fdr,GPA-method
###   cov,GPA-method estimates,GPA-method se,GPA-method fdr cov estimates
###   se
### Keywords: classes

### ** Examples

showClass("GPA")

# simulator function

simulator <- function( risk.ind, nsnp=20000, alpha=0.6 ) {
  
  m <- length(risk.ind)
  
  p.sig <- rbeta( m, alpha, 1 )
  pvec <- runif(nsnp)
  pvec[ risk.ind ] <- p.sig
  
  return(pvec)
}

# run simulation

set.seed(12345)
nsnp <- 1000
alpha <- 0.3
pmat <- matrix( NA, nsnp, 5 )

pmat[,1] <- simulator( c(1:200), nsnp=nsnp, alpha=alpha )
pmat[,2] <- simulator( c(51:250), nsnp=nsnp, alpha=alpha )
pmat[,3] <- simulator( c(401:600), nsnp=nsnp, alpha=alpha )
pmat[,4] <- simulator( c(451:750), nsnp=nsnp, alpha=alpha )
pmat[,5] <- simulator( c(801:1000), nsnp=nsnp, alpha=alpha )

ann <- rbinom(n = nrow(pmat), size = 1, prob = 0.15)
ann <- as.matrix(ann,ncol = 1)

fit.GPA.wAnn <- GPA( pmat, ann )
fit.GPA.wAnn
pp.GPA.wAnn <- print( fit.GPA.wAnn )
fdr.GPA.wAnn <- fdr( fit.GPA.wAnn )
fdr11.GPA.wAnn <- fdr( fit.GPA.wAnn, pattern="11" )
fdr1..GPA.wAnn <- fdr( fit.GPA.wAnn, pattern="1*" )
cov.GPA.wAnn <- cov( fit.GPA.wAnn )
est.GPA.wAnn <- estimates( fit.GPA.wAnn )
se.GPA.wAnn <- se( fit.GPA.wAnn )




cleanEx()
nameEx("GPA-package")
### * GPA-package

flush(stderr()); flush(stdout())

### Name: GPA-package
### Title: GPA (Genetic analysis incorporating Pleiotropy and Annotation)
### Aliases: GPA-package
### Keywords: package

### ** Examples

## Not run: 
##D # simulation setting
##D 
##D nBin <- 1000
##D pi1 <- 0.2
##D common <- 0.5
##D betaAlpha <- c( 0.6, 0.6 )
##D annP <- c( 0.2, 0.4, 0.4, 0.4 )
##D seed <- 12345
##D 
##D # simulation setting
##D 
##D nCommon <- round( pi1 * common * nBin )
##D nUniq <- round( pi1 * ( 1 - common ) * nBin )
##D nBg <- nBin - 2 * nUniq - nCommon
##D 
##D # M * K matrix of GWAS p-value
##D 
##D set.seed( seed )
##D 
##D pvec1 <- c( rbeta( nCommon, betaAlpha[1], 1 ), rbeta( nUniq, betaAlpha[1], 1 ), 
##D 	runif( nUniq ), runif( nBg ) )
##D pvec2 <- c( rbeta( nCommon, betaAlpha[2], 1 ), runif( nUniq ),
##D 	rbeta( nUniq, betaAlpha[2], 1 ), runif( nBg ) )
##D pmat <- cbind( pvec1, pvec2 )
##D 
##D # M * D matrix of annotation
##D  	
##D ann <- c( 
##D 	sample( c(1,0), nCommon, replace=TRUE, prob = c( annP[4], 1 - annP[4] ) ), 
##D 	sample( c(1,0), nUniq, replace=TRUE, prob = c( annP[2], 1 - annP[2] ) ),
##D 	sample( c(1,0), nUniq, replace=TRUE, prob = c( annP[3], 1 - annP[3] ) ),
##D 	sample( c(1,0), nBg, replace=TRUE, prob = c( annP[1], 1 - annP[1] ) ) )
##D 		
##D # GPA without annotation data
##D 
##D fit.GPA.noAnn <- GPA( pmat, NULL )
##D cov.GPA.noAnn <- cov( fit.GPA.noAnn )
##D 		
##D # GPA with annotation data
##D 
##D fit.GPA.wAnn <- GPA( pmat, ann )
##D cov.GPA.wAnn <- cov( fit.GPA.wAnn )
##D 
##D # GPA under pleiotropy H0
##D 
##D fit.GPA.pleiotropy.H0 <- GPA( pmat, NULL, pleiotropyH0=TRUE )
##D 
##D # association mapping
##D 
##D assoc.GPA.wAnn <- assoc( fit.GPA.wAnn, FDR=0.05, fdrControl="global" )
##D 
##D # hypothesis testing for pleiotropy
##D 
##D test.pleiotropy <- pTest( fit.GPA.noAnn, fit.GPA.pleiotropy.H0 )
##D 
##D # hypothesis testing for annotation enrichment
##D 
##D test.annotation <- aTest( fit.GPA.noAnn, fit.GPA.wAnn )
##D 
##D # simulator function
##D 
##D simulator <- function( risk.ind, nsnp=20000, alpha=0.6 ) {
##D   
##D   m <- length(risk.ind)
##D   
##D   p.sig <- rbeta( m, alpha, 1 )
##D   pvec <- runif(nsnp)
##D   pvec[ risk.ind ] <- p.sig
##D   
##D   return(pvec)
##D }
##D 
##D # run simulation
##D 
##D set.seed(12345)
##D nsnp <- 1000
##D alpha <- 0.4
##D pmat <- matrix( NA, nsnp, 5 )
##D 
##D pmat[,1] <- simulator( c(1:200), nsnp=nsnp, alpha=alpha )
##D pmat[,2] <- simulator( c(51:250), nsnp=nsnp, alpha=alpha )
##D pmat[,3] <- simulator( c(401:600), nsnp=nsnp, alpha=alpha )
##D pmat[,4] <- simulator( c(451:750), nsnp=nsnp, alpha=alpha )
##D pmat[,5] <- simulator( c(801:1000), nsnp=nsnp, alpha=alpha )
##D 
##D # Fit GPA for all possible pairs of GWAS datasets
##D 
##D out <- fitAll( pmat )
##D 
##D # Run the ShinyGPA app using the ouput from fitAll()
##D 
##D shinyGPA(out)
## End(Not run)



cleanEx()
nameEx("GPA")
### * GPA

flush(stderr()); flush(stdout())

### Name: GPA
### Title: Fit GPA model
### Aliases: GPA
### Keywords: models methods

### ** Examples


# simulator function

simulator <- function( risk.ind, nsnp=20000, alpha=0.6 ) {
  
  m <- length(risk.ind)
  
  p.sig <- rbeta( m, alpha, 1 )
  pvec <- runif(nsnp)
  pvec[ risk.ind ] <- p.sig
  
  return(pvec)
}

# run simulation

set.seed(12345)
nsnp <- 1000
alpha <- 0.3
pmat <- matrix( NA, nsnp, 5 )

pmat[,1] <- simulator( c(1:200), nsnp=nsnp, alpha=alpha )
pmat[,2] <- simulator( c(51:250), nsnp=nsnp, alpha=alpha )
pmat[,3] <- simulator( c(401:600), nsnp=nsnp, alpha=alpha )
pmat[,4] <- simulator( c(451:750), nsnp=nsnp, alpha=alpha )
pmat[,5] <- simulator( c(801:1000), nsnp=nsnp, alpha=alpha )

ann <- rbinom(n = nrow(pmat), size = 1, prob = 0.15)
ann <- as.matrix(ann,ncol = 1)

# GPA without annotation data

fit.GPA.noAnn <- GPA( pmat, NULL )
cov.GPA.noAnn <- cov( fit.GPA.noAnn )
		
# GPA with annotation data

fit.GPA.wAnn <- GPA( pmat, ann )
cov.GPA.wAnn <- cov( fit.GPA.wAnn )

# GPA under the null hypothesis of pleiotropy test

fit.GPA.pleiotropy.H0 <- GPA( pmat, NULL, pleiotropyH0=TRUE )




cleanEx()
nameEx("aTest")
### * aTest

flush(stderr()); flush(stdout())

### Name: aTest
### Title: Hypothesis testing for annotation enrichment
### Aliases: aTest
### Keywords: models methods

### ** Examples


# simulator function

simulator <- function( risk.ind, nsnp=20000, alpha=0.6 ) {
  
  m <- length(risk.ind)
  
  p.sig <- rbeta( m, alpha, 1 )
  pvec <- runif(nsnp)
  pvec[ risk.ind ] <- p.sig
  
  return(pvec)
}

# run simulation

set.seed(12345)
nsnp <- 1000
alpha <- 0.3
pmat <- matrix( NA, nsnp, 5 )

pmat[,1] <- simulator( c(1:200), nsnp=nsnp, alpha=alpha )
pmat[,2] <- simulator( c(51:250), nsnp=nsnp, alpha=alpha )
pmat[,3] <- simulator( c(401:600), nsnp=nsnp, alpha=alpha )
pmat[,4] <- simulator( c(451:750), nsnp=nsnp, alpha=alpha )
pmat[,5] <- simulator( c(801:1000), nsnp=nsnp, alpha=alpha )

ann <- rbinom(n = nrow(pmat), size = 1, prob = 0.15)
ann <- as.matrix(ann,ncol = 1)

# GPA without annotation data

fit.GPA.noAnn <- GPA( pmat, NULL )
		
# GPA with annotation data

fit.GPA.wAnn <- GPA( pmat, ann )

# hypothesis testing for annotation enrichment

test.annotation <- aTest( fit.GPA.noAnn, fit.GPA.wAnn )




cleanEx()
nameEx("assoc")
### * assoc

flush(stderr()); flush(stdout())

### Name: assoc
### Title: Association mapping
### Aliases: assoc assoc,GPA-method
### Keywords: models methods

### ** Examples


# simulator function

simulator <- function( risk.ind, nsnp=20000, alpha=0.6 ) {
  
  m <- length(risk.ind)
  
  p.sig <- rbeta( m, alpha, 1 )
  pvec <- runif(nsnp)
  pvec[ risk.ind ] <- p.sig
  
  return(pvec)
}

# run simulation

set.seed(12345)
nsnp <- 1000
alpha <- 0.3
pmat <- matrix( NA, nsnp, 5 )

pmat[,1] <- simulator( c(1:200), nsnp=nsnp, alpha=alpha )
pmat[,2] <- simulator( c(51:250), nsnp=nsnp, alpha=alpha )
pmat[,3] <- simulator( c(401:600), nsnp=nsnp, alpha=alpha )
pmat[,4] <- simulator( c(451:750), nsnp=nsnp, alpha=alpha )
pmat[,5] <- simulator( c(801:1000), nsnp=nsnp, alpha=alpha )

ann <- rbinom(n = nrow(pmat), size = 1, prob = 0.15)
ann <- as.matrix(ann,ncol = 1)

fit.GPA.wAnn <- GPA( pmat, ann )
cov.GPA.wAnn <- cov( fit.GPA.wAnn )
assoc.GPA.wAnn <- assoc( fit.GPA.wAnn, FDR=0.05, fdrControl="global" )




cleanEx()
nameEx("fitAll")
### * fitAll

flush(stderr()); flush(stdout())

### Name: fitAll
### Title: Fit GPA model for all possible pairs of GWAS datasets
### Aliases: fitAll
### Keywords: models methods

### ** Examples

## Not run: 
##D 
##D # simulator function
##D 
##D simulator <- function( risk.ind, nsnp=20000, alpha=0.6 ) {
##D   
##D   m <- length(risk.ind)
##D   
##D   p.sig <- rbeta( m, alpha, 1 )
##D   pvec <- runif(nsnp)
##D   pvec[ risk.ind ] <- p.sig
##D   
##D   return(pvec)
##D }
##D 
##D # run simulation
##D 
##D set.seed(12345)
##D nsnp <- 10000
##D alpha <- 0.4
##D pmat <- matrix( NA, nsnp, 5 )
##D 
##D pmat[,1] <- simulator( c(1:2000), nsnp=nsnp, alpha=alpha )
##D pmat[,2] <- simulator( c(501:2500), nsnp=nsnp, alpha=alpha )
##D pmat[,3] <- simulator( c(4001:6000), nsnp=nsnp, alpha=alpha )
##D pmat[,4] <- simulator( c(4501:7500), nsnp=nsnp, alpha=alpha )
##D pmat[,5] <- simulator( c(8001:10000), nsnp=nsnp, alpha=alpha )
##D 
##D # Fit GPA for all possible pairs of GWAS datasets
##D 
##D out <- fitAll( pmat )
##D 
##D # Run the ShinyGPA app using the ouput from fitAll()
##D 
##D shinyGPA(out)
##D 
## End(Not run)



cleanEx()
nameEx("pTest")
### * pTest

flush(stderr()); flush(stdout())

### Name: pTest
### Title: Hypothesis testing for pleiotropy
### Aliases: pTest
### Keywords: models methods

### ** Examples


# simulator function

simulator <- function( risk.ind, nsnp=20000, alpha=0.6 ) {
  
  m <- length(risk.ind)
  
  p.sig <- rbeta( m, alpha, 1 )
  pvec <- runif(nsnp)
  pvec[ risk.ind ] <- p.sig
  
  return(pvec)
}

# run simulation

set.seed(12345)
nsnp <- 1000
alpha <- 0.3
pmat <- matrix( NA, nsnp, 5 )

pmat[,1] <- simulator( c(1:200), nsnp=nsnp, alpha=alpha )
pmat[,2] <- simulator( c(51:250), nsnp=nsnp, alpha=alpha )
pmat[,3] <- simulator( c(401:600), nsnp=nsnp, alpha=alpha )
pmat[,4] <- simulator( c(451:750), nsnp=nsnp, alpha=alpha )
pmat[,5] <- simulator( c(801:1000), nsnp=nsnp, alpha=alpha )

# GPA without annotation data

fit.GPA.noAnn <- GPA( pmat, NULL )

# GPA under the null hypothesis of pleiotropy test

fit.GPA.pleiotropy.H0 <- GPA( pmat, NULL, pleiotropyH0=TRUE )

# hypothesis testing for pleiotropy

test.pleiotropy <- pTest( fit.GPA.noAnn, fit.GPA.pleiotropy.H0 )




cleanEx()
nameEx("shinyGPA")
### * shinyGPA

flush(stderr()); flush(stdout())

### Name: shinyGPA
### Title: Run ShinyGPA app
### Aliases: shinyGPA
### Keywords: models methods

### ** Examples

## Not run: 
##D 
##D # simulator function
##D 
##D simulator <- function( risk.ind, nsnp=20000, alpha=0.6 ) {
##D   
##D   m <- length(risk.ind)
##D   
##D   p.sig <- rbeta( m, alpha, 1 )
##D   pvec <- runif(nsnp)
##D   pvec[ risk.ind ] <- p.sig
##D   
##D   return(pvec)
##D }
##D 
##D # run simulation
##D 
##D set.seed(12345)
##D nsnp <- 1000
##D alpha <- 0.3
##D pmat <- matrix( NA, nsnp, 5 )
##D 
##D pmat[,1] <- simulator( c(1:200), nsnp=nsnp, alpha=alpha )
##D pmat[,2] <- simulator( c(51:250), nsnp=nsnp, alpha=alpha )
##D pmat[,3] <- simulator( c(401:600), nsnp=nsnp, alpha=alpha )
##D pmat[,4] <- simulator( c(451:750), nsnp=nsnp, alpha=alpha )
##D pmat[,5] <- simulator( c(801:1000), nsnp=nsnp, alpha=alpha )
##D 
##D # Fit GPA for all possible pairs of GWAS datasets
##D 
##D out <- fitAll( pmat )
##D 
##D # Run the ShinyGPA app using the ouput from fitAll()
##D 
##D shinyGPA(out)
## End(Not run)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
