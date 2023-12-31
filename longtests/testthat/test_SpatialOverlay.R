if(!file.exists("muBrain.RDS")){
  tifFile <- downloadMouseBrainImage()
  annots <- system.file("extdata", "muBrain_LabWorksheet.txt", 
                        package = "SpatialOmicsOverlay")
  
  overlay <- suppressWarnings(readSpatialOverlay(ometiff = tifFile, annots = annots, 
                                                 slideName = "D5761 (3)", outline = FALSE))
  
  saveRDS(overlay, "muBrain.RDS")
}else{
  overlay <- readRDS( "muBrain.RDS")
}

annots <- system.file("extdata", "muBrain_LabWorksheet.txt", 
                      package = "SpatialOmicsOverlay")

overlay <- addImageOmeTiff(overlay,
                           ometiff = downloadMouseBrainImage(), 
                           res = 8)

annots <- readLabWorksheet(annots, "D5761 (3)")

overlay <- addPlottingFactor(overlay, annots, "segment")

testthat::test_that("SpatialOverlay is formatted correctly",{
    #Spec 1. The class is formatted correctly.
    expect_true(all(names(scanMeta(overlay)) == c("Panels", "PhysicalSizes", 
                                                  "Fluorescence", 
                                                  "Segmentation")))
    expect_true(class(scanMeta(overlay)$Panels) == "character")
    expect_true(all(names(scanMeta(overlay)$PhysicalSizes) == c("X", "Y")))
    expect_true(class(scanMeta(overlay)$PhysicalSizes$X) == "numeric")
    expect_true(class(scanMeta(overlay)$PhysicalSizes$Y) == "numeric")
    expect_true(class(scanMeta(overlay)$Fluorescence) == "data.frame")
    expect_true(all(names(scanMeta(overlay)$Fluorescence) == c("Dye", 
                                                               "DisplayName",
                                                               "Color", 
                                                               "WaveLength",
                                                               "Target", 
                                                               "ExposureTime",
                                                               "MinIntensity", 
                                                               "MaxIntensity",
                                                               "ColorCode")))
    expect_true(all(names(overlay@workflow) %in% c("labWorksheet", "outline", 
                                                   "scaled")))
    expect_true(all(coords(overlay)$sampleID %in% sampNames(overlay)))
    expect_true(all(rownames(plotFactors(overlay)) == sampNames(overlay)))
    
    expect_true(all(names(overlay@image) %in% c("filePath", "imagePointer", 
                                                "resolution")))
})

testthat::test_that("SpatialOverlay accessor work as expected",{
    #Spec 2. The class accessors work as expected.
    expect_true(slideName(overlay) == "D5761 (3)")
    expect_identical(slideName(overlay), overlay@slideName)
    
    expect_true(class(overlay(overlay)) == "SpatialPosition")
    expect_identical(overlay(overlay), overlay@overlayData)
    
    expect_true(class(scanMeta(overlay)) == "list")
    expect_identical(scanMeta(overlay), overlay@scanMetadata)
    
    expect_true(class(coords(overlay)) == "data.frame")
    expect_identical(coords(overlay), overlay@coords)
    
    expect_true(class(plotFactors(overlay)) == "data.frame")
    expect_identical(plotFactors(overlay), overlay@plottingFactors)
    
    expect_true(class(labWork(overlay)) == "logical")
    expect_identical(labWork(overlay), overlay@workflow$labWorksheet)
    
    expect_true(class(outline(overlay)) == "logical")
    expect_identical(outline(overlay), overlay@workflow$outline)
    
    expect_true(class(scaleBarRatio(overlay)) == "numeric")
    expect_identical(scaleBarRatio(overlay), overlay@scanMetadata$PhysicalSizes$X)
    
    expect_true(class(fluor(overlay)) == "data.frame")
    expect_identical(fluor(overlay), overlay@scanMetadata$Fluorescence)
    
    expect_true(class(seg(overlay)) == "character")
    expect_identical(seg(overlay), overlay@scanMetadata$Segmentation)
     
    expect_true(class(sampNames(overlay)) == "character")
    expect_identical(sampNames(overlay), meta(overlay(overlay))$Sample_ID)
    
    expect_true(class(res(overlay)) == "numeric")
    expect_true(res(overlay) == overlay@image$resolution)
    
    expect_true(class(showImage(overlay)) == "magick-image")
    expect_identical(showImage(overlay), overlay@image$imagePointer)
    
    expect_true(class(scaled(overlay)) == "logical")
    expect_identical(scaled(overlay), overlay@workflow$scaled)
    
    expect_true(class(imageInfo(overlay)) == "list")
    expect_identical(imageInfo(overlay), overlay@image)
    
    expect_true(class(workflow(overlay)) == "list")
    expect_identical(workflow(overlay), overlay@workflow)
})


