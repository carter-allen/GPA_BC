### R code from vignette source 'GPA-example.Rnw'

###################################################
### code chunk number 1: preliminaries
###################################################
options(prompt = "R> ")


###################################################
### code chunk number 2: GPA-prelim
###################################################
library("GPA")


###################################################
### code chunk number 3: mosaicsExample-prelim
###################################################
library(gpaExample)
data(exampleData)
dim(exampleData$pval)
head(exampleData$pval)
dim(exampleData$ann)
head(exampleData$ann)
table(exampleData$ann)


###################################################
### code chunk number 4: GPA-noann-show (eval = FALSE)
###################################################
## fit.GPA.noAnn <- GPA( exampleData$pval[ , c(3,5) ], NULL )


###################################################
### code chunk number 5: GPA-noann-run
###################################################
fit.GPA.noAnn <- GPA( exampleData$pval[ , c(3,5) ], NULL, maxIter=100 )


###################################################
### code chunk number 6: GPA-noann-simple (eval = FALSE)
###################################################
## fit.GPA.noAnn <- GPA( exampleData$pval[ , c(3,5) ] )


###################################################
### code chunk number 7: GPA-ann-show (eval = FALSE)
###################################################
## fit.GPA.wAnn <- GPA( exampleData$pval[ , c(3,5) ], exampleData$ann )


###################################################
### code chunk number 8: GPA-ann-run
###################################################
fit.GPA.wAnn <- GPA( exampleData$pval[ , c(3,5) ], exampleData$ann, maxIter=100 )


###################################################
### code chunk number 9: GPA-show-ann
###################################################
fit.GPA.wAnn


###################################################
### code chunk number 10: GPA-estimates-se-ann
###################################################
estimates( fit.GPA.wAnn )
se( fit.GPA.wAnn )


###################################################
### code chunk number 11: GPA-assoc-ann
###################################################
assoc.GPA.wAnn <- assoc( fit.GPA.wAnn, FDR=0.20, fdrControl="global" )
dim(assoc.GPA.wAnn)
head(assoc.GPA.wAnn)
table(assoc.GPA.wAnn[,1])
table(assoc.GPA.wAnn[,2])


###################################################
### code chunk number 12: GPA-fdr-ann
###################################################
fdr.GPA.wAnn <- fdr(fit.GPA.wAnn)
dim(fdr.GPA.wAnn)
head(fdr.GPA.wAnn)


###################################################
### code chunk number 13: GPA-assoc-pattern-ann
###################################################
assoc11.GPA.wAnn <- assoc( fit.GPA.wAnn, FDR=0.20, fdrControl="global", pattern="11" )
length(assoc11.GPA.wAnn)
head(assoc11.GPA.wAnn)
table(assoc11.GPA.wAnn)
fdr11.GPA.wAnn <- fdr( fit.GPA.wAnn, pattern="11" )
length(fdr11.GPA.wAnn)
head(fdr11.GPA.wAnn)


###################################################
### code chunk number 14: GPA-pleiotropy-null-show (eval = FALSE)
###################################################
## fit.GPA.pleiotropy.H0 <- GPA( exampleData$pval[ , c(3,5) ], NULL, pleiotropyH0=TRUE )


###################################################
### code chunk number 15: GPA-pleiotropy-null-run
###################################################
fit.GPA.pleiotropy.H0 <- GPA( exampleData$pval[ , c(3,5) ], NULL, pleiotropyH0=TRUE, maxIter=100 )


###################################################
### code chunk number 16: GPA-pleiotropy-null-show
###################################################
fit.GPA.pleiotropy.H0


###################################################
### code chunk number 17: pTest
###################################################
test.GPA.pleiotropy <- pTest( fit.GPA.noAnn, fit.GPA.pleiotropy.H0 )


###################################################
### code chunk number 18: aTest
###################################################
test.GPA.annotation <- aTest( fit.GPA.noAnn, fit.GPA.wAnn )


###################################################
### code chunk number 19: GPA-noann-fdr-cov
###################################################
dim(print(fit.GPA.wAnn))
head(print(fit.GPA.wAnn))
cov(fit.GPA.wAnn)


