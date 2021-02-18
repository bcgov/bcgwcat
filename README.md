
[![img](https://img.shields.io/badge/Lifecycle-Maturing-007EC6)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md)

<!-- README.md is generated from README.Rmd. Please edit that file -->

# `rems2aquachem`

<!-- badges: start -->
<!-- [![Travis build status](https://travis-ci.org/bcgov/rems2aquachem.svg?branch=master)](https://travis-ci.org/bcgov/rems2aquachem) -->
<!-- badges: end -->

The goal of `rems2aquachem` is to provide a quick and painless way of
converting EMS data into a format compatible with AquaChem.

Data is first downloaded with BC Govs
[`rems`](http://github.com/bcgov/rems) package, then formatted for use
by AquaChem.

## Installation steps

1.  [**Update RStudio**](https://rstudio.com/) (if it’s been a while)

2.  [**Update R**](https://cloud.r-project.org/) (if it’s been a while)

3.  **Open RStudio**

4.  **Install `remotes`** In the console type the following and hit
    enter

    ``` r
    install.packages("remotes")
    ```

5.  **Update `rems`** In the console type the following and hit enter

    ``` r
    remotes::install_github("bcgov/rems")
    ```

    > **Note:** If you run into errors during the `rems` data updates,
    > this might be due to old rems caches.
    >
    > **Try the following:**
    > 1.  Uninstall `rems` - RStudio, go to the lower right hand window,
    >     click on the “Packages” tab, in the search bar, search for
    >     “rems”, then click on the “X” in a circle to the right of it’s
    >     name.
    >
    > 2.  Remove the `rems` cache - Delete the cache folders by going to
    >     C:\_USER(windows) or \~/Library/Application Support (mac) and
    >     delete the “rems” folder
    >
    > 3.  Re-install `rems` remotes::install\_github(“bcgov/rems”) and
    >     then try again

6.  **Install `rems2aquachem`** In the console type the following and
    hit enter (be sure to install all updates if prompted!)

    ``` r
    remotes::install_github("bcgov/rems2aquachem")
    ```

If you run into errors right at the start, consider updating your
packages.

``` r
remotes::update_packages()
```

## Using `rems2aquachem`

### Shiny GUI

1.  In RStudio, first load the `rems2aquachem` package (this must be
    done every time)

    ``` r
    library(rems2aquachem)
    ```

2.  Next, launch the shiny GUI.

    Type the following in the console and hit enter

    ``` r
    ac_gui()
    ```

**See the
[tutorial](https://bcgov.github.io/rems2aquachem/articles/rems2aquachem.html)
for a more in-depth look at the GUI**

![Screenshot](https://raw.githubusercontent.com/bcgov/rems2aquachem/master/inst/assets/up-to-date.png)

### R command line

For advanced users, `rems2aquachem` can be used directly from R.

Downloads, converts and saves to csv

``` r
library(rems2aquachem)
r <- rems_to_aquachem(ems_ids = c("1401030", "1401377", "E292373"))
#> Checking for locally stored historical data...
#> Last download was 0 days ago
#> If you would like to update historical data, run 'rems::download_historic_data()'
#> Checking for locally stored recent data...
#> Fetching data from cache...
r
#> # A tibble: 16 x 145
#>    StationID SampleID Sample_Date Analysis_Date Project Watertype shortWatertype Comment Reference
#>    <chr>     <chr>    <chr>       <chr>         <chr>   <chr>     <chr>          <chr>   <chr>    
#>  1 ""        ""       ""          ""            ""      ""        ""             ""      ""       
#>  2 "075"     "140103… "1987-07-0…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#>  3 "075"     "140103… "1991-08-0…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#>  4 "075"     "140103… "1994-06-0…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#>  5 "075"     "140103… "2001-09-0…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#>  6 "075"     "140103… "2009-11-1…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#>  7 "075"     "140103… "2010-08-0…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#>  8 "075"     "140103… "2016-11-0…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#>  9 "075"     "140103… "2018-06-1…  <NA>         "BACKG… "Ground …  <NA>           <NA>    <NA>    
#> 10 "203"     "140137… "1987-07-0…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#> 11 "203"     "140137… "1989-10-1…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#> 12 "203"     "140137… "1994-03-2…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#> 13 "203"     "140137… "2016-11-0…  <NA>         "BACKG… "Fresh W…  <NA>           <NA>    <NA>    
#> 14 "203"     "140137… "2020-06-2…  <NA>         "BACKG… "Ground …  <NA>           <NA>    <NA>    
#> 15 "426"     "E29237… "2015-03-0…  <NA>         "GROUN… "Fresh W…  <NA>           <NA>    <NA>    
#> 16 "426"     "E29237… "2017-10-1…  <NA>         "GROUN… "Fresh W…  <NA>           <NA>    <NA>    
#> # … with 136 more variables: Quality_control <chr>, Duplicate_ID <chr>, Labcode <chr>, Location <chr>,
#> #   Geology <chr>, Coord_Lat <chr>, Coord_Long <chr>, X <chr>, Y <chr>, Elevation <chr>, Well_Depth <chr>,
#> #   Screen_Top <chr>, Screen_Mid <chr>, Screen_Bottom <chr>, Gradient <chr>, Station_Comment <chr>,
#> #   Sample_Depth <chr>, Temp <chr>, pH_lab <chr>, Cond <chr>, Meas_Alk <chr>, CO3 <chr>, HCO3 <chr>,
#> #   Cl <chr>, F <chr>, Meas_Hardness <chr>, NH4 <chr>, NO3 <chr>, NO2 <chr>, SO4 <chr>, Ag_diss <chr>,
#> #   Al_diss <chr>, As_diss <chr>, anion_sum <chr>, B <chr>, Ba <chr>, Ca <chr>, charge_balance <chr>,
#> #   Cd_diss <chr>, Cr_diss <chr>, cation_sum <chr>, Cu_diss <chr>, DO <chr>, Fe_diss <chr>, K <chr>,
#> #   Mg <chr>, Mn_diss <chr>, Mo_diss <chr>, Na <chr>, Ni_diss <chr>, Pb_diss <chr>, pH_field <chr>,
#> #   Sb_diss <chr>, Cond_field <chr>, Se_diss <chr>, Si <chr>, Sr <chr>, Tl_diss <chr>, U_diss <chr>,
#> #   V_diss <chr>, Zn_diss <chr>, Cd_tot <chr>, Zn_tot <chr>, Fe_tot <chr>, Cu_tot <chr>, Ni_tot <chr>,
#> #   Al_tot <chr>, Tl_tot <chr>, As_tot <chr>, Sb_tot <chr>, V_tot <chr>, Mo_tot <chr>, Ag_tot <chr>,
#> #   Pb_tot <chr>, Li <chr>, Mn_tot <chr>, U_tot <chr>, Br <chr>, `Acidity_pH_4_5_(as_CaCO3)` <chr>,
#> #   `Acidity_pH_8_3_(as_CaCO3)` <chr>, `Alkalinity;_Phenolphthalein_(as_CaCO3)` <chr>, Barium_Total <chr>,
#> #   Beryllium_Dissolved <chr>, Beryllium_Total <chr>, Bismuth_Dissolved <chr>, Bismuth_Total <chr>,
#> #   Boron_Total <chr>, Calcium_Total <chr>, Carbon_Dissolved_Organic <chr>, Chromium_Total <chr>,
#> #   Cobalt_Dissolved <chr>, Cobalt_Total <chr>, Cyanide_WAD <chr>, `Hardness_Total_(Total)` <chr>,
#> #   `Hydroxide_Alkalinity_(as_CaCO3)` <chr>, Lithium_Total <chr>, Magnesium_Total <chr>,
#> #   `Nitrate(NO3)_+_Nitrite(NO2)_Dissolved` <chr>, `Nitrogen_(Kjeldahl)_Total_Dissolved` <chr>,
#> #   Nitrogen_Ammonia_Total <chr>, …
```

Create plots

``` r
piper_plot(r, ems_id = "1401030")
```

<img src="man/figures/README-unnamed-chunk-9-1.png" width="50%" />

``` r
stiff_plot(r, ems_id = "1401030")
```

<img src="man/figures/README-unnamed-chunk-10-1.png" width="50%" />

## Vignette/Tutorials

See the [`rems2aquachem` website](https://bcgov.github.io/rems2aquachem)

## License

Copyright 2021 Province of British Columbia

Licensed under the Apache License, Version 2.0 (the “License”); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an “AS IS” BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
