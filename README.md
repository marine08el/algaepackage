Algae
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

# Algae package

<!-- badges: start -->
<!-- badges: end -->

The goal of Algae Package is to provide an educational tool for
exploring intertidal algae species. It visualizes foreshore layering
schemes, provides short descriptive texts, and allows users to interact
with algae species through photo cards and data summaries. …

## Contents

- [Installation](#installation)
- [Functions](#functions)
- [Examples](#example)

## Installation

You can install the development version of package ‘Algae’ like so:
```r
devtools::install_github(“marine08el/algaepackage”)
``` 

Load the package: 
```r
library(Algae)
```

## Functions

Three functions provide data on algae:

```r
info_algae() 
```
From the vernacular or scientific name of the seaweed,
obtain a text summarising its group, its location on the foreshore,
whether it is edible or not, its maximum size and its most common human
uses.

```r
intertidal_zone() 
``` 
Simply execute this function to obtain a diagram
showing the locations of the algae on the foreshore. The physiological
parameters specific to each species of algae react differently to
environmental conditions such as light, humidity or salinity, which
determines their specific positioning along the foreshore.

```r
algae_card() 
```
After choosing the vernacular or scientific name of the
species of algae, this function produces a graphical educational sheet
summarising the main characteristics of the algae.


## Examples

Example with the function info_algae

```r
info_algae(“Ulva lactuca”) or info_algae("Sea lettuce")
```
```r
Response: Sea lettuce (*Ulva lactuca*) is a green alga from the
mid-intertidal zone. This algae is eatable. Its maximum size is 0.4 m.
This algae can be used for : Food industry, Fertilizer.
```

Example with the function algae_card

```r
algae_card(“Gracilaria gracilis”) or algae_card(“Slender wart weed”)
```

Example with the cards: ![Gracilaria gracilis
card](man/figures/algae_card_gracilaria_gracilis.png)
