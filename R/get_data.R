# Copyright 2021 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Fetch data from rems
#'
#' Use [rems::rems-package()] to download data and then filter it.
#'
#' @param ems_ids Character vector. EMS IDs to filter by.
#' @param date_range Character vector. Start and end of the date range
#'   (YYYY-MM-DD)
#' @param interactive Logical. Whether or not to allow interactive queries by
#'   the `rems` package.
#'
#' @return data frame
#'
#' @keywords internal

get_rems <- function(ems_ids, date_range, interactive) {

  ems_ids <- as.character(ems_ids)

  # Only get data which is required
  hist <- TRUE
  recent <- TRUE
  if(!is.null(date_range)) {
    if(min(as.Date(date_range)) >= (Sys.Date() - lubridate::years(4))) {
      hist <- FALSE
    }
    if(max(as.Date(date_range)) <= (Sys.Date() - lubridate::years(4))) {
      recent <- FALSE
    }
  }


  # Get the historic data from ems
  if(hist) {
    if(interactive) {
      message("Checking for locally stored historical data...")
      message("Last download was ",
              round(difftime(Sys.Date(),
                             rems::get_cache_date("historic"), units = "day")),
              " days ago")
      message("If you would like to update historical data, run 'rems::download_historic_data()'")
    }

    # Filter historic data
    con <- suppressMessages(rems::connect_historic_db())
    h <- rems::attach_historic_data(con) %>%
      dplyr::select("EMS_ID", "COLLECTION_START", "LOCATION_PURPOSE",
                    "SAMPLE_STATE", "LATITUDE", "LONGITUDE", "PARAMETER",
                    "PARAMETER_CODE", "ANALYTICAL_METHOD", "RESULT", "UNIT") %>%
      dplyr::filter(.data$EMS_ID %in% ems_ids) %>%
      dplyr::collect() %>%
      dplyr::mutate(COLLECTION_START =
                      rems::ems_posix_numeric(.data$COLLECTION_START)) %>%
      dplyr::arrange(.data$COLLECTION_START)
    rems::disconnect_historic_db(con)
  } else h <- data.frame()

  if(recent) {
    message("Checking for locally stored recent data...")
    d <- rems::get_ems_data(which = "2yr", ask = interactive) %>%
      dplyr::select("EMS_ID", "COLLECTION_START", "LOCATION_PURPOSE", "SAMPLE_STATE",
                    "LATITUDE", "LONGITUDE", "PARAMETER", "PARAMETER_CODE",
                    "ANALYTICAL_METHOD", "RESULT", "UNIT") %>%
      dplyr::filter(.data$EMS_ID %in% ems_ids) %>%
      dplyr::arrange(.data$COLLECTION_START)
  } else d <- data.frame()

  d <- dplyr::bind_rows(h, d) %>%
    dplyr::distinct()

  if(!is.null(date_range)) {
    d <- d %>%
      dplyr::mutate(date = as.Date(.data$COLLECTION_START)) %>%
      dplyr::filter(date >= as.Date(date_range[1]),
                    date <= as.Date(date_range[2])) %>%
      dplyr::select(-"date")
  }

  ems_ids <- check_present(d, ems_ids, "all")

  d
}

#' Check for data in `rems`
#'
#' Returns a message regarding whether the data requested was actually found.
#'
#' @param d Data frame. Filtered output from [get_rems()].
#' @param ems_ids Character vector. EMS IDs
#' @param type Character. Either "all" (all data) or "date" (date-filtered data)
#'
#' @return Character vector of EMS IDs that __were__ in the data (omitting ones
#'   that were not found).
#'
#'
#' @keywords internal
check_present <- function(d, ems_ids, type = "all") {

  present <- sapply(ems_ids, FUN = function(x) x %in% d$EMS_ID)

  if(type == "all") {
    if(all(!present)) {
      stop("None of the EMS ID(s) (",
           paste0(names(present[!present]), collapse = ", "), ")",
           " are present in rems data for this date range\n", call. = FALSE)
    } else if(!all(present)) {
      message("Some EMS ID(s) (",
              paste0(names(present[!present]), collapse = ", "), ")",
              " are not present in rems data for this date range, skipping these sites...\n")
      ems_ids <- names(present[present])
    }
  } else if(type == "date") {
    if(all(!present)) {
      stop("None of the EMS ID(s) (",
           paste0(names(present[!present]), collapse = ", "), ")",
           " are present in this date range\n", call. = FALSE)
    } else if(!all(present)) {
      message("Some EMS ID(s) (",
              paste0(names(present[!present]), collapse = ", "), ")",
              " are not present in this date range, skipping these sites...\n")
      ems_ids <- names(present[present])
    }
  }
  ems_ids
}

#' Fetch and convert data from rems to AquaChem format
#'
#' @param ems_ids Character vector. Unique EMS ids
#' @param date_range Character vector. Start and end dates (YYYY-MM-DD)
#' @param save Logical. Whether or not to save the data as csv.
#' @param out_folder Character. Where to save data for AquaChem
#' @param out_file Character. What to call data file for AquaChem. Default is
#'   aquachem_DATE.csv
#' @param interactive Logical. Whether or not to ask when caching data.
#'
#' @return Outputs an Excel and a CSV file in the format to import into AquaChem.
#'
#' @details **`out_folder`**
#'   This is how you tell the function where to store the aquachem data.
#    By default, this data is stored in your working directory.
#
#    You do not have to change this if you are fine with that location. If you
#    are not certain where your working directory is, type `getwd()` in the
#    console and hit enter. To set your working directory, it is best to use an
#    RStudio project. Otherwise, go to the drop down menus in RStudio: Session >
#    Set Working Directory > To Source File Location. This will ensure that the
#    data files are placed in the same directory as these scripts.
#'
#' @examples
#' \dontrun{
#' # Convert one well and save the data in the working directory
#' rems_to_aquachem(ems_ids = "E289551")
#'
#' # Convert several wells (this will overwrite the previous data!)
#' rems_to_aquachem(ems_ids = c("1401030", "1401377"))
#'
#' # To specify a date range (Year-Month-Day)
#' rems_to_aquachem(ems_ids = c("1401030", "1401377"),
#'                  date_range = c("2000-01-01", "2015-01-01"))
#'
#' # To name the ouput (extension should be .csv, .txt, or .dat)
#' rems_to_aquachem(ems_ids = "1401030", out_file = "water_quality01.csv")
#'
#' # To save the output to a specific folder
#' # (here, the Outputs folder in the Rcode folder on the H drive)
#' # Note that the out_folder must exist or you'll get an error
#' rems_to_aquachem(ems_ids = c("1401030", "1401377"),
#'                  out_folder = "H:\\Rcode\\Outputs/")
#'
#' # All together now!
#' rems_to_aquachem(ems_ids = c("1401030", "1401377"),
#'                  date_range = c("2000-01-01", "2015-01-01"),
#'                  out_file = "water_quality05.csv",
#'                  out_folder = "H:\\Rcode\\Outputs/")
#'
#' # Clean up
#' unlink("water_quality01.csv")
#' unlink(paste0("aquachem_", Sys.Date(), ".csv"))
#' }
#'
#' @export
rems_to_aquachem <- function(ems_ids, date_range = NULL, save = TRUE,
                             out_folder = "./", out_file = NULL,
                             interactive = TRUE) {

  if(is.null(out_file)) out_file <- paste0("aquachem_", Sys.Date(), ".csv")

  # Add a trailing slash if there is none
  if(!(substr(out_folder, nchar(out_folder),
              nchar(out_folder)) %in% c("/", "\\"))) {
    out_folder <- paste0(out_folder, "/")
  }

  if(!(tools::file_ext(out_file) %in% c("csv", "txt", "dat"))) {
    stop("'out_file' should have an extension, either 'csv', 'txt', or 'dat")
  }

  # Get data and select only the columns of interest
  # - Columns in params_list.csv (internal params)
  # - Parameter columns
  d <- get_rems(ems_ids = ems_ids, date_range = date_range,
                interactive = interactive)

  if(nrow(d) == 0) return(data.frame())

  d <- ac_format(d)
  d <- ac_units(d)

  # Save data to disk, specfying NA values
  if(save) {
    # Get output location
    out_file <- file.path(out_folder, out_file)
    readr::write_csv(d, out_file, "N/A")
  }
  d
}

ac_format <- function(d) {

  meta_ac <- dplyr::filter(params, .data$type == "meta", !is.na(.data$aqua_code)) %>%
    dplyr::select("rems_name", "aqua_code")

  params_ac <- dplyr::filter(params, .data$type == "param", !is.na(.data$aqua_code)) %>%
    dplyr::mutate(aqua_unit = dplyr::if_else(is.na(.data$aqua_unit),
                                             .data$rems_unit, .data$aqua_unit)) %>%
    dplyr::select("rems_code", "aqua_code", "aqua_unit")

  # Rename the meta data in rems to correspond to AquaChem

  names(d)[!is.na(match(names(d), meta_ac$rems_name))] <-
    meta_ac$aqua_code[stats::na.omit(match(names(d), meta_ac$rems_name))]

  # Make Sample_Date a date (as opposed to date/time)
  d <- dplyr::mutate(d, Sample_Date = as.Date(.data$Sample_Date))

  # Add AquaChem parameter names
  d <- d %>%
    dplyr::mutate(rems_code = .data$PARAMETER_CODE) %>%
    dplyr::left_join(dplyr::select(params_ac, -"aqua_unit"), by = "rems_code") %>%
    # Replace parameter name with rems name if doesn't exist in AquaChem
    # Replace all spaces and periods with _
    dplyr::mutate(aqua_code = dplyr::if_else(is.na(.data$aqua_code),
                                             .data$PARAMETER,
                                             .data$aqua_code),
                  aqua_code = stringr::str_replace_all(
                    .data$aqua_code, c(" " = "_", "\\." = "_")))

  # Add in missing parameters and fill with NA
  d <- tidyr::complete(d, tidyr::nesting(
    !!!rlang::syms(c("SampleID", "Sample_Date", "Coord_Lat", "Project",
                     "Coord_Long", "Watertype"))),
    aqua_code = params_ac$aqua_code)

  # Add in AquaChem units
  d <- dplyr::left_join(d, dplyr::select(params_ac, -"rems_code"), by = "aqua_code")

  # Add StationID
  d <- d %>%
    dplyr::left_join(dplyr::select(ow, "StationID" = "ow", "SampleID" = "ems_id"),
                     by = "SampleID") %>%
    dplyr::mutate(StationID = replace(.data$StationID,
                                      is.na(.data$StationID),
                                      .data$SampleID[is.na(.data$StationID)]))

  # Find multiple measures
  # (i.e. same location, same date, same parameter, but different method)
  d <- d %>%
    # Group by location, date and parameter
    dplyr::group_by(.data$StationID, .data$Sample_Date, .data$aqua_code) %>%
    # Mark first observation
    dplyr::mutate(keep = c(TRUE, rep(FALSE, dplyr::n() - 1))) %>%
    # Remove grouping
    dplyr::ungroup() %>%
    # Filter out all but first observations
    dplyr::filter(.data$keep == TRUE)

  # Remove Ph units
  d <- dplyr::mutate(d, UNIT = dplyr::if_else(.data$UNIT == "pH units",
                                              NA_character_, .data$UNIT))

  # Convert units to those used in AquaChem
  d <- dplyr::mutate(d, RESULT2 = purrr::pmap_dbl(
    list(.data$RESULT, .data$UNIT, .data$aqua_unit),
    ~units_convert(..1, ..2, ..3)))

  # Remove now unnecessary parameter columns:
  d <- dplyr::select(d,
                     -"keep",  -"rems_code", -"PARAMETER",
                     -"PARAMETER_CODE", -"ANALYTICAL_METHOD")

  # Add in any missing AquaChem columns
  missing_cols <- meta_ac$aqua_code[!(meta_ac$aqua_code %in% names(d))]
  d[, missing_cols] <- NA

  # Add sample numbers to SampleID
  ids <- d %>%
    dplyr::select("StationID", "SampleID", "Sample_Date") %>%
    dplyr::distinct() %>%
    dplyr::group_by(.data$StationID, .data$SampleID) %>%
    dplyr::mutate(SampleID = paste0(.data$SampleID, "-",
                                    1:dplyr::n_distinct(.data$Sample_Date)))

  d <- d %>%
    dplyr::select(-"SampleID") %>%
    dplyr::left_join(ids, by = c("StationID", "Sample_Date")) %>%
    dplyr::arrange(.data$StationID)

  # Calculate MEQ
  d <- meq(d)

  d
}

ac_units <- function(d) {

  # Get units as separate data frame so we can add them in later
  units <- d %>%
    dplyr::select("aqua_code", "aqua_unit") %>%
    dplyr::distinct() %>%
    dplyr::bind_rows(params[params$type == "meta",
                            c("aqua_code", "aqua_unit")], .) %>%
    dplyr::mutate(aqua_unit = replace(.data$aqua_unit,
                                      is.na(.data$aqua_unit), "")) %>%
    dplyr::filter(!is.na(.data$aqua_code))

  # Transform to wide format
  d <- d %>%
    dplyr::select(-"UNIT", -"RESULT", -"aqua_unit") %>%
    tidyr::pivot_wider(names_from = .data$aqua_code,
                       values_from = .data$RESULT2) %>%
    dplyr::select(tidyselect::all_of(params$aqua_code[params$type == "meta"]),
                  dplyr::everything()) %>%
    dplyr::arrange(.data$StationID, .data$SampleID, .data$Sample_Date)

  # Spread and Order units by column names in d
  units <- units %>%
    tidyr::pivot_wider(names_from = .data$aqua_code,
                       values_from = .data$aqua_unit) %>%
    dplyr::select(tidyselect::all_of(names(d))) %>%
    dplyr::mutate(cations = "", anions = "", charge_balance = "%")

  # Add units to d
  d <- d %>%
    dplyr::mutate_all(.funs = as.character) %>%
    dplyr::bind_rows(units, .)

  # Arrange column order as in AquaChem template (unknown colums to end)
  cols <- params$aqua_code[params$type == "meta" & params$aqua_code %in% names(d)]
  d <- dplyr::select(d, tidyselect::all_of(cols), dplyr::everything())

  d
}


