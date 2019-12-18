
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `rems2aquachem`

<!-- badges: start -->

<!-- [![Travis build status](https://travis-ci.org/steffilazerte/rems2aquachem.svg?branch=master)](https://travis-ci.org/steffilazerte/rems2aquachem) -->

<!-- badges: end -->

The goal of `rems2aquachem` is to provide a quick and painless way of
converting EMS data into a format compatible with AquaChem.

Data is first downloaded with BC Govs
[`rems`](http://github.com/bcgov/rems) package, then formated for use by
AquaChem.

## Installation

You can install `rems2aquachem` from
[GitHub](https://github.com/steffilazerte/rems2aquachem).

``` r
install.packages("remotes")
remotes::install_github("steffilazerte/rems2aquachem", build_vignettes = TRUE)
```

If you run into errors right at the start, consider updating your
packages.

``` r
remotes::update_packages()
```

## Usage

### R command line

Shows and saves to csv

``` r
library(rems2aquachem)
rems_to_aquachem(ems_ids = c("1401030", "1401377", "E292373"))
#> Checking for locally stored historical data...
#> It appears that you already have the most up-to date version of the historic ems data.
#> Checking for locally stored recent data...
#> Fetching data from cache...
#> # A tibble: 15 x 136
#>    StationID SampleID Sample_Date Analysis_Date Project Watertype shortWatertype
#>    <chr>     <chr>    <chr>       <chr>         <chr>   <chr>     <chr>         
#>  1 ""        ""       ""          ""            ""      ""        ""            
#>  2 203       1401377… 1987-07-07  <NA>          BACKGR… Fresh Wa… <NA>          
#>  3 203       1401377… 1989-10-11  <NA>          BACKGR… Fresh Wa… <NA>          
#>  4 203       1401377… 1994-03-24  <NA>          BACKGR… Fresh Wa… <NA>          
#>  5 203       1401377… 2016-11-02  <NA>          BACKGR… Fresh Wa… <NA>          
#>  6 75        1401030… 1987-07-07  <NA>          BACKGR… Fresh Wa… <NA>          
#>  7 75        1401030… 1991-08-07  <NA>          BACKGR… Fresh Wa… <NA>          
#>  8 75        1401030… 1994-06-08  <NA>          BACKGR… Fresh Wa… <NA>          
#>  9 75        1401030… 2001-09-09  <NA>          BACKGR… Fresh Wa… <NA>          
#> 10 75        1401030… 2009-11-11  <NA>          BACKGR… Fresh Wa… <NA>          
#> 11 75        1401030… 2010-08-09  <NA>          BACKGR… Fresh Wa… <NA>          
#> 12 75        1401030… 2016-11-02  <NA>          BACKGR… Fresh Wa… <NA>          
#> 13 75        1401030… 2018-06-14  <NA>          BACKGR… Ground W… <NA>          
#> 14 E292373   E292373… 2015-03-06  <NA>          GROUND… Fresh Wa… <NA>          
#> 15 E292373   E292373… 2017-10-11  <NA>          GROUND… Fresh Wa… <NA>          
#> # … with 129 more variables: Comment <chr>, Reference <chr>,
#> #   Quality_control <chr>, Duplicate_ID <chr>, Labcode <chr>, Location <chr>,
#> #   Geology <chr>, Coord_Lat <chr>, Coord_Long <chr>, X <chr>, Y <chr>,
#> #   Elevation <chr>, Well_Depth <chr>, Screen_Top <chr>, Screen_Mid <chr>,
#> #   Screen_Bottom <chr>, Gradient <chr>, Station_Comment <chr>,
#> #   Sample_Depth <chr>, Temp <chr>, pH_lab <chr>, Cond <chr>, Meas_Alk <chr>,
#> #   CO3 <chr>, HC03 <chr>, Cl <chr>, F <chr>, Meas_Hardness <chr>, NH4 <chr>,
#> #   NO3 <chr>, NO2 <chr>, SO4 <chr>, Ag_diss <chr>, Al_diss <chr>,
#> #   As_diss <chr>, B <chr>, Ba <chr>, Ca <chr>, Cd_diss <chr>, Cr_diss <chr>,
#> #   Cu_diss <chr>, DO <chr>, Fe_diss <chr>, K <chr>, Mg <chr>, Mn_diss <chr>,
#> #   Mo_diss <chr>, Na <chr>, Ni_diss <chr>, Pb_diss <chr>, pH_field <chr>,
#> #   Sb_diss <chr>, Cond_field <chr>, Se_diss <chr>, Si <chr>, Sr <chr>,
#> #   Tl_diss <chr>, U_diss <chr>, V_diss <chr>, Zn_diss <chr>, Cd_tot <chr>,
#> #   Zn_tot <chr>, Fe_tot <chr>, Cu_tot <chr>, Ni_tot <chr>, Al_tot <chr>,
#> #   Tl_tot <chr>, As_tot <chr>, Sb_tot <chr>, V_tot <chr>, Mo_tot <chr>,
#> #   Ag_tot <chr>, Pb_tot <chr>, Li <chr>, Mn_tot <chr>, U_tot <chr>, Br <chr>,
#> #   Acidity_pH_4_5 <chr>, Acidity_pH_8_3 <chr>, Alkalinity_Phen__8_3 <chr>,
#> #   Anion_Sum <chr>, Barium_Total <chr>, Beryllium_Dissolved <chr>,
#> #   Beryllium_Total <chr>, Bismuth_Dissolved <chr>, Bismuth_Total <chr>,
#> #   Boron_Total <chr>, Calcium_Total <chr>, Carbon_Dissolved_Organic <chr>,
#> #   `Cation_-_Anion_Balance` <chr>, Cation_Sum <chr>, Chromium_Total <chr>,
#> #   Cobalt_Dissolved <chr>, Cobalt_Total <chr>, Cyanide_WAD <chr>,
#> #   `Hardness_Total_(Total)` <chr>, Hydroxide_Alkalinity <chr>,
#> #   Lithium_Total <chr>, Magnesium_Total <chr>,
#> #   `Nitrate(NO3)_+_Nitrite(NO2)_Dissolved` <chr>, …
```

### Shiny GUI

Launch the shiny GUI with the function
`ac_gui()`

``` r
ac_gui()
```

![Screenshot](https://raw.githubusercontent.com/steffilazerte/rems2aquachem/master/inst/assets/screenshot.png)

## Vignette/Tutorials

After installing `rems2aquachem` you can access the Walkthrough vignette
with:

``` r
vignette("walkthrough", package = "rems2aquachem")
```
