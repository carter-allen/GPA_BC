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


# simulation setting

nBin <- 20000
pi1 <- 0.2
common <- 0.5
betaAlpha <- c( 0.6, 0.6 )
annP <- c( 0.2, 0.4, 0.4, 0.4 )
seed <- 12345

# simulation setting

nCommon <- round( pi1 * common * nBin )
nUniq <- round( pi1 * ( 1 - common ) * nBin )
nBg <- nBin - 2 * nUniq - nCommon

# M * K matrix of GWAS p-value

set.seed( seed )

pvec1 <- c( rbeta( nCommon, betaAlpha[1], 1 ), rbeta( nUniq, betaAlpha[1], 1 ), 
	runif( nUniq ), runif( nBg ) )
pvec2 <- c( rbeta( nCommon, betaAlpha[2], 1 ), runif( nUniq ),
	rbeta( nUniq, betaAlpha[2], 1 ), runif( nBg ) )
pmat <- cbind( pvec1, pvec2 )

# M * D matrix of annotation
 	
ann <- c( 
	sample( c(1,0), nCommon, replace=TRUE, prob = c( annP[4], 1 - annP[4] ) ), 
	sample( c(1,0), nUniq, replace=TRUE, prob = c( annP[2], 1 - annP[2] ) ),
	sample( c(1,0), nUniq, replace=TRUE, prob = c( annP[3], 1 - annP[3] ) ),
	sample( c(1,0), nBg, replace=TRUE, prob = c( annP[1], 1 - annP[1] ) ) )
		
# GPA without annotation data

fit.GPA.noAnn <- GPA( pmat, NULL )
cov.GPA.noAnn <- cov( fit.GPA.noAnn )
		
# GPA with annotation data

fit.GPA.wAnn <- GPA( pmat, ann )
cov.GPA.wAnn <- cov( fit.GPA.wAnn )

# GPA under pleiotropy H0

fit.GPA.pleiotropy.H0 <- GPA( pmat, NULL, pleiotropyH0=TRUE )

# association mapping

assoc.GPA.wAnn <- assoc( fit.GPA.wAnn, FDR=0.05, fdrControl="global" )

# hypothesis testing for pleiotropy

test.pleiotropy <- pTest( fit.GPA.noAnn, fit.GPA.pleiotropy.H0 )

# hypothesis testing for annotation enrichment

test.annotation <- aTest( fit.GPA.noAnn, fit.GPA.wAnn )

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
nsnp <- 10000
alpha <- 0.4
pmat <- matrix( NA, nsnp, 5 )

pmat[,1] <- simulator( c(1:2000), nsnp=nsnp, alpha=alpha )
pmat[,2] <- simulator( c(501:2500), nsnp=nsnp, alpha=alpha )
pmat[,3] <- simulator( c(4001:6000), nsnp=nsnp, alpha=alpha )
pmat[,4] <- simulator( c(4501:7500), nsnp=nsnp, alpha=alpha )
pmat[,5] <- simulator( c(8001:10000), nsnp=nsnp, alpha=alpha )

# Fit GPA for all possible pairs of GWAS datasets

out <- fitAll( pmat )

# Run the ShinyGPA app using the ouput from fitAll()

shinyGPA(out)




cleanEx()
nameEx("GPA")
### * GPA

flush(stderr()); flush(stdout())

### Name: GPA
### Title: Fit GPA model
### Aliases: GPA
### Keywords: models methods

### ** Examples


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
nsnp <- 10000
alpha <- 0.4
pmat <- matrix( NA, nsnp, 5 )

pmat[,1] <- simulator( c(1:2000), nsnp=nsnp, alpha=alpha )
pmat[,2] <- simulator( c(501:2500), nsnp=nsnp, alpha=alpha )
pmat[,3] <- simulator( c(4001:6000), nsnp=nsnp, alpha=alpha )
pmat[,4] <- simulator( c(4501:7500), nsnp=nsnp, alpha=alpha )
pmat[,5] <- simulator( c(8001:10000), nsnp=nsnp, alpha=alpha )

# Fit GPA for all possible pairs of GWAS datasets

out <- fitAll( pmat )

# Run the ShinyGPA app using the ouput from fitAll()

shinyGPA(out)




cleanEx()
nameEx("pTest")
### * pTest

flush(stderr()); flush(stdout())

### Name: pTest
### Title: Hypothesis testing for pleiotropy
### Aliases: pTest
### Keywords: models methods

### ** Examples


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
nsnp <- 10000
alpha <- 0.4
pmat <- matrix( NA, nsnp, 5 )

pmat[,1] <- simulator( c(1:2000), nsnp=nsnp, alpha=alpha )
pmat[,2] <- simulator( c(501:2500), nsnp=nsnp, alpha=alpha )
pmat[,3] <- simulator( c(4001:6000), nsnp=nsnp, alpha=alpha )
pmat[,4] <- simulator( c(4501:7500), nsnp=nsnp, alpha=alpha )
pmat[,5] <- simulator( c(8001:10000), nsnp=nsnp, alpha=alpha )

# Fit GPA for all possible pairs of GWAS datasets

out <- fitAll( pmat )

# Run the ShinyGPA app using the ouput from fitAll()

shinyGPA(out)




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
