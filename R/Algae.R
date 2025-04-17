#' Algae data
#'
#' This dataset contains the following information: vernacular name, scientific name, intertidal zone,
#' algae group, eatable, usage, max length (m)
#'
#'
#' @docType data
#' @format Tibble with rows and columns :
#' \describe{
#'   \item{vernacular_name}{common name for algae, among several possibilities}
#'   \item{scientific_name }{scientific name for algae}
#'   \item{intertidal_zone}{zone of the foreshore where algae are found}
#'   \item{group}{algae group: brown, green, red}
#'   \item{eatable}{eatable or non-eatable algae}
#'   \item{usage}{possible industrial uses for algae}
#'   \item{max_length_m}{maximum algae length in meters}
#' }
#'
#' @source Internal dataset, source DORIS: Observation Data for the Recognition and Identification of Underwater Fauna and Flora
"algae"
