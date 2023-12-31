% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/addImage.R
\name{addImageOmeTiff}
\alias{addImageOmeTiff}
\title{Add image to SpatialOverlay from OME-TIFF}
\usage{
addImageOmeTiff(overlay, ometiff = NULL, res = NULL, ...)
}
\arguments{
\item{overlay}{SpatialOverlay object}

\item{ometiff}{File path to OME-TIFF. NULL indicates pull info from overlay}

\item{res}{resolution layer, 1 = largest & higher values = smaller. The 
images increase in resolution and memory. The largest image your 
environment can hold is recommended.  NULL indicates pull info 
from overlay}

\item{...}{Extra variables}
}
\value{
SpatialOverlay object with image
}
\description{
Add image to SpatialOverlay from OME-TIFF
}
\examples{

muBrain <- readRDS(unzip(system.file("extdata", "muBrainSubset_SpatialOverlay.zip", 
                                    package = "SpatialOmicsOverlay")))

image <- downloadMouseBrainImage()

muBrain <- addImageOmeTiff(overlay = muBrain, 
                           ometiff = image, res = 8)
showImage(muBrain)

}
