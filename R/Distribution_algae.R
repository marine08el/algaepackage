#' @title Algae map distribution in Europe
#'
#' @description
#' This function  generates a spatial distribution map of an algae species in Europe.
#' The geolocated occurrences come from the GBIF (Global Biodiversity Information Facility) system.
#'
#' @param species The scientific name of the algae.
#' @param limit Integer. Maximum number of occurrences to download (default: 10000)
#' @param sample_size Integer. Maximum number of occurrences to plot (default: 7000)
#'
#' @return A map with geolocalised data on the algae species
#'
#' @importFrom rgbif occ_search
#' @importFrom sf st_as_sf st_transform st_intersects
#' @importFrom ggplot2 ggplot geom_sf labs theme_minimal theme element_rect element_text coord_sf
#' @importFrom rnaturalearth ne_countries
#' @importFrom dplyr filter
#'
#'
#' @export
Distribution_algae <- function(species, limit = 10000, sample_size = 7000) {

  # Vérification de l'entrée
  if (missing(species) || !is.character(species)) {
    stop("Please provide a valid scientific name from algae data.")
  }

  # Recherche d'occurrences
  occ <- rgbif::occ_search(
    scientificName = species,
    hasCoordinate = TRUE, #inclure des observations ayant des coordonnées
    limit = limit #Telechargement de max 10000 occurences
  )$data

  # Nettoyage des coordonnées (pour eliminer lignes avec coordonnées manquantes)
  occ_clean <- occ[!is.na(occ$decimalLongitude) & !is.na(occ$decimalLatitude), ]

  # Echantillonnage
  set.seed(123)
  sample_size <- min(sample_size, nrow(occ_clean))
  occ_sampled <- occ_clean[sample(nrow(occ_clean), size = sample_size), ]

  # Conversion en objet sf
  occ_sf <- sf::st_as_sf(occ_sampled, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326)

  # Cartographie
  world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
  europe <- dplyr::filter(world, continent == "Europe")
  non_europe <- dplyr::filter(world, continent != "Europe")

  # Filtrage spatial
  occ_europe <- occ_sf[sapply(sf::st_intersects(occ_sf, europe), length) > 0, ]

  # Projection Lambert-93
  occ_rgf93 <- sf::st_transform(occ_europe, crs = 2154)
  europe_rgf93 <- sf::st_transform(europe, crs = 2154)
  non_europe_rgf93 <- sf::st_transform(non_europe, crs = 2154)

  # Affichage
  p <- ggplot2::ggplot() +
    ggplot2::geom_sf(data = non_europe_rgf93, fill = "gray90", color = "gray70") +
    ggplot2::geom_sf(data = europe_rgf93, fill = "antiquewhite", color = "gray60") +
    ggplot2::geom_sf(data = occ_rgf93, color = "darkolivegreen", alpha = 0.6, size = 1) +
    ggplot2::coord_sf(
      crs = 2154,
      xlim = c(-1000000, 3500000),
      ylim = c(5000000, 10500000),
      expand = FALSE
    ) +
    ggplot2::labs(
      title = paste("European distribution of", species),
      subtitle = "Occurrence data from GBIF"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = "aliceblue"),
      panel.border = ggplot2::element_rect(fill = NA, size = 1.5, colour = "#2F4F4F"),
      plot.title = ggplot2::element_text(hjust = 0.5, size = 15, face = "bold", family = "serif", margin = ggplot2::margin(b = 10)),
      plot.subtitle = ggplot2::element_text(hjust = 0.5, size = 10, family = "serif", margin = ggplot2::margin(b = 10))
    )

  return(p)

}
