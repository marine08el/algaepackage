#' @title Info on Algae
#'
#' @description This function provides some information about an algae based on its name.
#'
#' @param name The vernacular or the scientific name of the algae.
#'
#' @return A summary message about the algae.
#'
#' @examples
#' info_algae("Chondus crispus")
#'
#' @importFrom utils data
#' @importFrom dplyr filter %>%
#'
#' @export
info_algae <- function(name) {

  data("algae", package = "Algae")

  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package 'dplyr' is required")
  }

  results <- algae %>%
    dplyr::filter(tolower(vernacular_name) == tolower(name)|
                  tolower(scientific_name) == tolower(name))


  if (nrow(results) == 0){
    return(paste("No algae with name : ", name))
  }

  ligne <- results[1, ]

  #Construction of text elements

  eatable_text <- if (!is.na(ligne$eatable) && tolower(ligne$eatable) == "true") {
    "This algae is eatable."
  } else {
    "This algae is not eatable."
  }

  usage_text <- if (!is.na(ligne$usage) && tolower(ligne$usage) != "no human use") {
    paste0("This algae can be used for : ", ligne$usage, ".")
  } else {
    "This algae has no known human use."
  }

  # Message complet
  message_txt <- paste0(
    ligne$vernacular_name, " (*", ligne$scientific_name, "*) is a ",
    tolower(ligne$algae_group), " alga from the ", tolower(ligne$intertidal_zone), " zone.\n",
    eatable_text, "\n",
    "Its maximum size is ", ligne$max_length_m, " m.\n",
    usage_text
  )

  cat(message_txt, "\n")
  return(invisible(message_txt))
}
