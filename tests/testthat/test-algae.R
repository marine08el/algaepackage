# tests/testthat/test-algae.R

# Chargement des bibliothèques nécessaires pour les tests
library(testthat)
library(Algae)

# Test de la fonction info_algae
test_that("info_algae renvoie une chaîne avec le bon contenu", {
  result <- info_algae("Chondrus crispus")

  expect_true(is.character(result))
  expect_match(result, "Chondrus crispus")
  expect_match(result, "This algae")
})


# Test de la fonction algae_card
test_that("algae_card produit une carte sans erreur", {
  expect_invisible(algae_card("Chondrus crispus"))
})

test_that("algae_card utilise une image existante", {
  image_dir <- system.file("extdata", "photos", package = "Algae")
  img_path <- file.path(image_dir, "chondrus_crispus.png")
  expect_true(file.exists(img_path))
})
