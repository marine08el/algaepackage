#' @title Intertidal Zone Visualization
#'
#' @description
#' This function returns a scheme showing the location of algae on the foreshore (intertidal zone).
#' This stratification is typical of algae in the northeast Atlantic.
#'
#' @return A graphical representation, ggplot object, to better visualize the location of algae on the foreshore.
#'
#' @import dplyr
#' @import ggplot2
#'
#' @export
intertidal_zone <- function() {
  if (!requireNamespace("ggplot2", quietly = TRUE) || !requireNamespace("dplyr", quietly = TRUE)) {
    stop("Packages 'ggplot2' and 'dplyr' are required")
  }

  data("algae", package = "Algae")

  # Nettoyage
  algae_clean <- algae %>%
    dplyr::filter(!is.na(intertidal_zone)) %>%
    dplyr::mutate(
      zone = factor(tolower(intertidal_zone), levels = c("lower-intertidal", "mid-intertidal", "upper-intertidal")),
      full_name = paste0(vernacular_name, "\n(", scientific_name, ")")
    )

  # Définir les plages strictes par zone
  zone_df <- data.frame(
    zone = factor(c("lower-intertidal", "mid-intertidal", "upper-intertidal"),
                  levels = c("lower-intertidal", "mid-intertidal", "upper-intertidal")),
    ymin = c(0.5, 1.5, 2.5),
    ymax = c(1.5, 2.5, 3.5),
    label = c("Lower\nintertidal", "Mid\nintertidal", "Upper\nintertidal")
  )

  # Espace de sécurité pour ne pas toucher les limites
  padding <- 0.1

  # Positionner les algues à l’intérieur des limites, avec padding
  algae_labeled <- algae_clean %>%
    dplyr::left_join(zone_df, by = "zone") %>%
    dplyr::group_by(zone) %>%
    dplyr::mutate(
      x = runif(dplyr::n(), min = 0.1, max = 0.9),
      y = seq(from = ymin[1] + padding, to = ymax[1] - padding, length.out = dplyr::n())
    ) %>%
    dplyr::ungroup()

  # Ligne bleue (marée)
  wave_df <- data.frame(
    x = c(0, 0.5),
    y = c(3.5, 0.5)
  )

  # Fond sable
  sand_df <- data.frame(
    x = c(0, 0.5, 0.55, 0),
    y = c(3.5, 0.5, 0.5, 0.5)
  )

  # Limites de marée (haut et bas)
  tide_labels <- data.frame(
    x = 0.96,
    y = c(3.5, 0.5),
    label = c("Highest tide limit", "Lowest tide limit")
  )

  # Graphique
  p <- ggplot() +
    geom_polygon(data = sand_df, aes(x = x, y = y), fill = "#f4e8c1") +
    geom_line(data = wave_df, aes(x = x, y = y), color = "#4da6ff", size = 1) +
    geom_segment(aes(x = 0.95, xend = 0.95, y = 0.5, yend = 3.5), color = "black") +
    geom_hline(data = zone_df, aes(yintercept = ymin), linetype = "dashed", color = "grey50") +
    geom_text(data = tide_labels, aes(x = x, y = y, label = label),
              size = 3.5, fontface = "italic", hjust = 1, vjust = c(0, 1)) +
    scale_y_continuous(
      breaks = (zone_df$ymin + zone_df$ymax) / 2,
      labels = zone_df$label,
      limits = c(0.5, 3.5)
    ) +
    geom_text(data = algae_labeled,
              aes(x = x, y = y, label = full_name),
              size = 2.5, fontface = "bold", color = "#2F4F4F", lineheight = 1.1) +
    theme_minimal() +
    labs(title = "Vertical Zonation of Algae", x = "Sea", y = "Intertidal Zone") +
    theme(
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank(),
      panel.grid = element_blank(),
      plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
      axis.text.y = element_text(size = 12),
      axis.title.y = element_text(size = 14, face = "bold"),
      axis.title.x = element_text(size = 14, face = "bold")
    )

  print(p)
}

