Algae
================

<!-- README.md is generated from README.Rmd. Please edit that file -->

# Algae package

<!-- badges: start -->
<!-- badges: end -->

The goal of Algae Package is to obtain information on intertidal algae 
thanks to short descriptions and interactive cards,locate algae according 
to its position on the foreshore, visualize the distribution of algae in 
Europe and detect algae accumulation with indexes.

## Contents

- [Installation](#installation)
- [Functions](#functions)
- [Examples](#example)

## Installation

You can install the development version of package ‘Algae’ like so:
```r
devtools::install_github("marine08el/algaepackage")
``` 

Load the package: 
```r
library(Algae)
```

## Functions

Five functions provide data on algae:

```r
info_algae() 
```
Obtain a text summarizing its group, its location on the foreshore,
whether it is edible or not, its maximum size and its most common human
uses.

```r
algae_card() 
```
This function produces a graphical educational sheet
summarizing the main characteristics of the algae.

```r
Distribution_algae() 
```
This function generates a spatial distribution map 
of an algae species in Europe. Geolocated occurrences come from the GBIF system. 

```r
intertidal_zone() 
``` 
Diagram showing the locations of the algae on the foreshore. The physiological
parameters specific to each species of algae react differently to
environmental conditions such as light, humidity or salinity, which
determines their specific positioning along the foreshore.

```r
Algae_index_detection() 
``` 
This function can be used to detect the accumulation of algae in shallow waters 
or on foreshores. The NDVI and NDWI indices are combined to extract vegetation (algae) 
from wetlands or aquatic areas.


## Examples

Load data
```r
data(algae)
```

Example with the function distribution_algae

```r
Distribution_algae("Chondrus crispus")
```
Example with the distribution: ![Distribution de Chondrus crispus](man/figures/distribution_algae_chondrus_crispus.png)


Example with the function algae_card

```r
algae_card(“Gracilaria gracilis”)
```

Example with a card: ![Gracilaria gracilis
card](man/figures/algae_card_gracilaria_gracilis.png)
