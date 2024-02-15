# bcgwcat 0.6.0
* Rename to bcgwcat to reflect change in scope
  * Update docs etc. in light of this
* Added more details to Shiny app explaining private vs. public EMS data, 
  water quality guidelines and parameter/unit changes

# rems2aquachem 0.5.1
* Speed increases
* Use dplyr v1.1.0

# rems2aquachem 0.5.0
* `piper_plot()` can distinguish points by different `group`s. `point_colour`,
  `point_filled`, `point_size` and `point_shape` are now arguments which can 
  specify group-level or overall styling of points. 
* `piper_plot()` has a new `legend_position` argument to move the legend, and
  `legend_title` argument to change the title
* Data for piper plots is sorted before plotting to ensure correct legend order
* New vignette for piper plots
* `dont_update` works for interactive sessions as well
* Prettier display in Shiny app when no data returned
* Better handling of missing data by plotting functions

# rems2aquachem 0.4.4
* Add calculations for water type
* Tweak piper plots data validity
* Stiff plots only use valid data
* Add minor elements
* Charge balances can include missing values (rounded to 1 decimal)
* Charge balances, anion sums and cation sums are recalculated completely
* Update authors
* Don't force users to update 2yr data in Shiny app

# rems2aquachem 0.4.3
* update rems and fix code accordingly

# rems2aquachem 0.4.2
* Added custom charge balance calculations (`anion_sum2`, `cation_sum2`, `charge_balance2`) 
and the option to choose between EMS charge balances and the one calculated here in the Shiny app

# rems2aquachem 0.4.1
* Fixed bug where cation/anion not showing up
* Added labels to stiff plots

# rems2aquachem 0.4.0
* Added water quality table
* Convert units correctly

# rems2aquachem 0.3.1

* Migrated to bcgov repositories

# rems2aquachem 0.3.0

* Added a `NEWS.md` file to track changes to the package.
* Added piper and stiff plots
* Updated to use rems v0.6.1
* Add checks for 'bad' data with charge balance
