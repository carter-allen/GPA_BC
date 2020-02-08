\name{exampleData}
\docType{data}
\alias{exampleData}
\title{PGC GWAS Dataset and Annotation Dataset}
\description{
  This is the PGC GWAS dataset and annotation dataset used in Chung et al. (2013).
}
\usage{ data(exampleData) }
\format{
  A list with two matrices as elements.
  Two matrices of sizes 1,219,805 x 5 and 1,219,805 x 1, \code{exampleData$pval} and \code{exampleData$ann}, 
  contain the p-values of 1,219,805 SNPs for five psychiatric disorder GWAS (ADHD, ASD, BPD, MDD, SCZ)
  from the psychiatric GWAS consortium (PGC) and 
  the binary annotation data using genes preferentially expressed in the central nervous system (CNS), respectively.
}
\details{
  Five columns of the matrix \code{exampleData$pval} correspond to attention deficit-hyperactivity disorder (ADHD), autism spectrum disorder (ASD), bipolar disorder (BPD), major depressive disorder (MDD), and schizophrenia (SCZ). Detailed information about these data sets is provided in Cross-Disorder Group of the Psychiatric Genomics Consortium (2013a, 2013b). Summary statistics of these five psychiatric disorders were downloaded from the section for cross-disorder analysis at the Psychiatric Genomics Consortium (PGC) website (\url{https://pgc.unc.edu/Sharing.php}). \code{exampleData$ann} provides annotation data using genes preferentially expressed in the central nervous system (CNS) (Lee et al., 2012; Raychaudhuri et al., 2010), where the entries corresponding to SNPs within 50-kb of the genes from the CNS set were set to be one and zero otherwise. See the vignette of R package \code{GPA} and Chung et al. (2013) for more details. 
}
\source{
Cross-Disorder Group of the Psychiatric Genomics Consortium (2013a), "Genetic relationship between five psychiatric disorders estimated from genome-wide SNPs", \emph{Nature Genetics}, 45:984--994.

Cross-Disorder Group of the Psychiatric Genomics Consortium (2013b), "Identification of risk loci with shared effects on five major psychiatric disorders: a genome-wide analysis", \emph{Lancet}, 381:1371--1379.

Lee SH, DeCandia TR, Ripke S, Yang J, Sullivan PF, et al. (2012), "Estimating the proportion of variation in susceptibility to schizophrenia captured by common SNPs", \emph{Nature Genetics}, 44:247--250.

Raychaudhuri S, Korn JM, McCarroll SA, Altshuler D, Sklar P, et al. (2010), "Accurately assessing the risk of schizophrenia conferred by rare copy-number variation affecting genes with brain function", \emph{PLoS Genetics}, 6:e1001097.
}
\references{
Chung D, Yang C, Li C, Gelernter J, and Zhao H (2013), "GPA: A statistical approach to prioritizing GWAS results by integrating pleiotropy and annotation", To appear in PLoS Genetics.
}
\examples{
\dontrun{
data(exampleData)
library(GPA)
exampleData
}
}
\keyword{datasets}
