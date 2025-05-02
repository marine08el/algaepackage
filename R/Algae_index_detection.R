#' @title Index for Algae detection
#'
#' @description
#' This function can be used to detect the accumulation of algae in shallow waters or on foreshores.
#' The NDVI and NDWI indices are combined to extract vegetation (algae) from wetlands or aquatic areas.
#'
#'
#' @param red_band_path Expected format: tif or jp2
#' @param nir_band_path Expected format: tif or jp2
#' @param green_band_path Expected format: tif or jp2
#' @param ndvi_threshold From 0.1: low vegetation, works with algae. default: 0.1.
#' @param ndwi_threshold With -0.2 the index includes wetlands and aquatic areas. default -0.2.
#'
#' @return A raster containing the binary mask of areas detected as algae.
#'
#' @import terra
#'
#' @export
Algae_index_detection <- function(red_band_path,
                                  nir_band_path,
                                  green_band_path,
                                  ndvi_threshold = 0.1,
                                  ndwi_threshold = -0.2) {
  if (!require("terra")) {
    install.packages("terra")
    library(terra)
  }

  # Chargement des bandes
  red <- rast(red_band_path)
  nir <- rast(nir_band_path)
  green <- rast(green_band_path)

  # Verificiation resolutions et alignement
  nir <- resample(nir, red)
  green <- resample(green, red)

  # Calcul et masque du NDVI avec le seuil de 0.1
  ndvi <- (nir - red) / (nir + red)
  ndvi_mask <- ndvi > ndvi_threshold

  # Calcul et masque du NDWI avec le seuil de moins 0.2
  ndwi <- (green - nir) / (green + nir)
  ndwi_mask <- ndwi > ndwi_threshold

  # Masque algues
  algae_mask <- ndvi_mask & ndwi_mask

  plot(algae_mask,
       col = c("grey", "darkgreen"),
       legend = FALSE,
       main = paste0("Detected algae (NDVI > ", ndvi_threshold,
                     " & NDWI > ", ndwi_threshold, ")"))

  return(algae_mask)
}
