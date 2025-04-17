#' @title Cards for algae
#'
#' @description
#' This function generates a pedagogical visual card for a given algae.
#' Information is accompanied by an image of the species.
#'
#'
#' @param name The vernacular or the scientific name of the algae.
#' @param data algae
#'
#' @return A graphical representation of the algae card.
#'
#' @importFrom png readPNG
#' @importFrom grid grid.newpage pushViewport viewport unit grid.raster grid.text grid.rect gpar
#' @importFrom utils data
#' @importFrom dplyr filter
#'
#'
#' @export
algae_card <- function(name, data = algae) {

  data ("algae", package = "Algae")

  ligne <- data |>
    dplyr::filter(tolower(vernacular_name) == tolower(name) |
                    tolower(scientific_name) == tolower(name))

  if (nrow(ligne) == 0) {
    message("No algae found with name: ", name)
    return(invisible(NULL))
  }

  image_dir <- system.file("extdata", package = "Algae")
  fond_path <- file.path(image_dir, "fond.png")
  logo_path <- file.path(image_dir, "logo.png")
  photo_dir <- file.path(image_dir, "photos")

  img_file <- paste0(tolower(gsub(" ", "_", name)), ".png")
  img_path <- file.path(photo_dir, img_file)

  if (!file.exists(fond_path)) stop("Image 'fond.png' not found.")
  if (!file.exists(logo_path)) stop("Image 'logo.png' not found.")
  if (!file.exists(img_path)) {
    warning("Image not found for algae: ", ligne$scientific_name)
    return(invisible(NULL))
  }

  fond <- png::readPNG(fond_path)
  photo <- png::readPNG(img_path)
  logo <- png::readPNG(logo_path)

  # Affichage
  grid::grid.newpage()
  grid::pushViewport(grid::viewport(width = grid::unit(1, "npc"), height = grid::unit(1, "npc")))
  grid::grid.raster(fond, width = grid::unit(1, "npc"), height = grid::unit(1, "npc"))

  # Titre & sous-titre
  grid::grid.text(ligne$vernacular_name, x = 0.5, y = 0.9,
                  gp = grid::gpar(fontsize = 24, fontface = "bold", fontfamily = "serif", col = "white"))
  grid::grid.text(paste0("(", ligne$scientific_name, ")"), x = 0.5, y = 0.83,
                  gp = grid::gpar(fontsize = 16, fontface = "italic", fontfamily = "serif", col = "white"))

  # Photo & bordure
  grid::grid.raster(photo, x = 0.5, y = 0.65, width = 0.40)
  grid::grid.rect(gp = grid::gpar(fill = NA, col = "#FAEBD7", lwd = 10))


  # Infos texte
  y_base <- 0.45
  pas <- 0.05

  grid::grid.text(paste("Group:", ligne$algae_group), x = 0.5, y = y_base, gp = grid::gpar(fontsize = 12, fontfamily = "mono", col = "#2F4F4F"))
  grid::grid.text(paste("Foreshore Zone:", ligne$intertidal_zone), x = 0.5, y = y_base - pas, gp = grid::gpar(fontsize = 12, fontfamily = "mono", col = "#2F4F4F"))
  grid::grid.text(ifelse(ligne$eatable, "Eatable", "Not eatable"), x = 0.5, y = y_base - 2*pas, gp = grid::gpar(fontsize = 12, fontfamily = "mono", col = "#2F4F4F"))
  grid::grid.text(paste("Max size:", ligne$max_length_m, "m"), x = 0.5, y = y_base - 3*pas, gp = grid::gpar(fontsize = 12, fontfamily = "mono", col = "#2F4F4F"))

  # Usages
  if (!is.na(ligne$usage) && tolower(ligne$usage) != "no human use") {
    usage_lines <- unlist(strsplit(ligne$usage, ","))
    for (i in seq_along(usage_lines)) {
      grid::grid.text(paste("Use:", trimws(usage_lines[i])), x = 0.5,
                      y = y_base - 4 * pas - (i - 1) * pas,
                      gp = grid::gpar(fontsize = 12, fontfamily = "mono", col = "#2F4F4F"))
    }
  }

  # Logo
  grid::grid.raster(logo, x = 0.5, y = 0.07, width = 0.1)

  invisible(NULL)
}

