\name{simSummary}
\alias{simSummary}
\title{Simulation summary}
\description{\code{simSummary} eases the process of summarizing simulation results.
Simulations often produce some intermediate results (some focal statistic(s)),
that need to be summarized over many simulation replicates. \code{simSummary}
helps with summarizing these focal statistics.}
\usage{
simSummary(x,
FUN = c("length",
"nobs",
"mean",
"sd",
"min",
"max"),
...)
}
\arguments{
  \item{x}{an (outer) list of (inner) lists, where each inner list has exactly the same structure (see examples)}
  \item{FUN}{character, summary statistics function names}
  \item{\dots}{arguments passed to summary functions}
}
\details{\code{simSummary} accepts as input an (outer) list of (inner) lists,
where all inner lists must have the same structure and only scalars, vectors,
matrices, and arrays can be used in inner lists. Function combines all inputs
in a list of arrays and summarizes array values with specified functions that
can work on vector like inputs.}
\value{The return element is also a list (outer) of lists (inner), where
each inner list has the same structure as inner lists of input, but holding
one of the summary statistics - one summary statistics per one inner list.}

\author{Gregor Gorjanc}




\examples{

## Create simple input from a rather silly simulation
simFun <- function(x)
{
  ret <- list()
  ret$s <- rnorm(n=1)
  ret$v <- rnorm(n=5)
  ret$m <- matrix(rnorm(n=5*5), nrow=5, ncol=5)
  ret$a <- array(rnorm(n=4*3*2), dim=c(4, 3, 2))
  ret
}
sim <- list()
sim$sim1 <- simFun()
sim$sim2 <- simFun(x=0)
sim$sim3 <- simFun(x=1)

## Simulation summary (just mean and standard deviation)
simSummary(x=sim, FUN=c("mean", "sd"))

## Can handle simulations in process too = handle NA values
sim$sim3$s <- NA
sim$sim3$v[5] <- NA
simSummary(x=sim, FUN="mean")
simSummary(x=sim, FUN="mean", na.rm=TRUE)

## Unit tests (automatic run elsewhere)
## summary(runTest(test(simSummary)))

}
