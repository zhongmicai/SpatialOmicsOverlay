% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/omeExtraction.R
\name{xmlExtraction}
\alias{xmlExtraction}
\title{Extract xml from OME-TIFF}
\usage{
xmlExtraction(ometiff, saveFile = FALSE, outdir = NULL)
}
\arguments{
\item{ometiff}{path to OME-TIFF}

\item{saveFile}{should xml be saved, file is saved in working directory with 
same name as OME-TIFF}

\item{outdir}{output directory for saved xml. If NULL, saved in same directory as OME-TIFF}
}
\value{
list of xml data
}
\description{
Extract xml from OME-TIFF
}
\examples{

image <- downloadMouseBrainImage()
xml <- xmlExtraction(ometiff = image)

}
