# internal data correct

    Code
      meq_conversion
    Output
      # A tibble: 18 x 4
         param      mass valency_state conversion
         <chr>     <dbl>         <dbl>      <dbl>
       1 Al_diss    8.99             1       8.99
       2 CO3       60.0              2      30.0 
       3 Ca        40.1              2      20.0 
       4 Cl        35.5              1      35.5 
       5 Cu_diss   63.5              2      31.8 
       6 F         19.0              1      19.0 
       7 Fe_diss   55.8              2      27.9 
       8 HCO3      61.0              1      61.0 
       9 K         39.1              1      39.1 
      10 Meas_Alk 100.               2      50.0 
      11 Mg        24.3              2      12.2 
      12 Mn_diss   54.9              2      27.5 
      13 NH4       14.0              1      14.0 
      14 NO2       14.0              1      14.0 
      15 NO3       14.0              1      14.0 
      16 Na        23.0              1      23.0 
      17 SO4       96.1              2      48.0 
      18 Zn_diss   65.4              2      32.7 

# water_type

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["Sample_Date", "SampleID", "StationID", "Cl_meq", "SO4_meq", "HCO3_meq", "Meas_Alk_meq", "Ca_meq", "Mg_meq", "Na_meq", "K_meq", "charge_balance", "water_type"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
        }
      },
      "value": [
        {
          "type": "double",
          "attributes": {
            "class": {
              "type": "character",
              "attributes": {},
              "value": ["Date"]
            }
          },
          "value": [16500, 16489, 16849, 17051]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["E292373-1", "E298873-1", "E298873-2", "E298873-3"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["426", "451", "451", "451"]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.05077144, 0.36668265, 0.23411277, 0.16952021]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.02519191, 0.06995438, 0.06662322, 0.07307735]
        },
        {
          "type": "double",
          "attributes": {},
          "value": ["NA", 0.50970321, 0.50150862, 0.56870422]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [1.32285044, 0.50955719, 0.61146863, 0.69339744]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.92819003, 0.55391986, 0.4935376, 0.5139977]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.3488994, 0.14811767, 0.12919152, 0.1505863]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.17486038, 0.26272555, 0.22444766, 0.21531316]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [0.03401682, 0.03708601, 0.03529565, 0.03836484]
        },
        {
          "type": "double",
          "attributes": {},
          "value": [3.4, 1, -4.2, -4.1]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["Ca-Mg-HCO3*", "Ca-Na-HCO3-Cl", "Ca-Na-HCO3-Cl", "Ca-Na-HCO3"]
        }
      ]
    }

# dominant_water_types()

    {
      "type": "list",
      "attributes": {
        "names": {
          "type": "character",
          "attributes": {},
          "value": ["Sample_Date", "SampleID", "Coord_Lat", "Project", "Coord_Long", "StationID", "Watertype", "Analysis_Date", "shortWatertype", "Comment", "Reference", "Quality_control", "Duplicate_ID", "Labcode", "Location", "Geology", "X", "Y", "Elevation", "Well_Depth", "Screen_Top", "Screen_Mid", "Screen_Bottom", "Gradient", "Station_Comment", "Sample_Depth", "Temp", "14C", "18O", "2H", "Ag_diss", "Ag_tot", "Al_diss", "Al_tot", "As_diss", "As_tot", "B", "B_tot", "Ba", "Ba_tot", "Benzene", "Br", "CN_diss", "CN_tot", "CO3", "Ca", "Ca_tot", "Cd_diss", "Cd_tot", "Cl", "Co_diss", "Co_tot", "Cond", "Cond_field", "Cr_III_diss", "Cr_VI_diss", "Cr_diss", "Cr_tot", "Cu_diss", "Cu_tot", "DO", "Density", "Eh", "Ethylbenzene", "F", "Fe_III_diss", "Fe_II_diss", "Fe_diss", "Fe_tot", "HCO3", "Hg_diss", "Hg_tot", "K", "K_tot", "Li", "Li_tot", "Meas_Alk", "Meas_Hardness", "Mg", "Mg_tot", "Mn_diss", "Mn_tot", "Mo_diss", "Mo_tot", "NH4", "NH4_tot", "NO2", "NO3", "Na", "Na_tot", "Ni_diss", "Ni_tot", "PCE", "Pb_diss", "Pb_tot", "SO4", "Sb_diss", "Sb_tot", "Se_diss", "Se_tot", "Si", "Si_tot", "Sr", "Sr_tot", "TCE", "TOC", "TSS", "Tl_diss", "Tl_tot", "Toluene", "Tritium", "U_diss", "U_tot", "V_diss", "V_tot", "Vinyl chloride", "Xylene", "Zn_diss", "Zn_tot", "pH_field", "pH_lab", "Phosphorus_Total", "Alkalinity;_Phenolphthalein_(as_CaCO3)", "Phosphorus_Total_Dissolved", "Nitrogen_Kjel_Tot(N)", "Nitrate(NO3)_+_Nitrite(NO2)_Dissolved", "Silica_Reactive_Diss", "Residue:_Filterable_1_0u_(TDS)", "Phosphorus_Ort_Dis-P", "Bismuth_Dissolved", "Beryllium_Total", "Zirconium_Total", "Beryllium_Dissolved", "Titanium_Total", "Titanium_Dissolved", "Sulfur_Dissolved", "Tellurium_Total", "Tellerium_Dissolved", "Coliform_-_Total", "Sulfur_Total", "Tin_Total", "Coliform_-_Fecal", "Bismuth_Total", "Tin_Dissolved", "Zirconium_Dissolved", "Nitrogen_NO2_Total", "Acidity_pH_8_3_(as_CaCO3)", "Nitrogen_Total", "Alkalinity_pH_4_5/4_2", "Hardness_Total_(Total)", "Sulfate_Total", "Fluoride_Total", "Turbidity", "Color_True", "Carbon_Total_Organic", "Nitrogen_Organic-Total", "Nitrogen_(Kjeldahl)_Total_Dissolved", "Nitrogen_Total_Dissolved", "Total_Nitrogen_NO2_+_NO3", "Mirex", "Phorate", "Bromophos_Ethyl", "Phosalone", "Metolachlor", "Chlorfenvinphos", "Hexachlorobenzene", "Chlorbenside", "Demeton", "Atrazine", "Tolyfluanid", "Dicrotophos", "Carbophenthion", "Desmetryn", "Pronamide", "Endosulfan_Sulphate", "Quinalophos", "Benfluralin", "Methoxychlor", "Diazinon", "Parathion", "Alachlor", "Malaoxon", "Dicofol", "p;p'-DDE", "Parathion_Methyl", "Dichlorbenil", "Malathion", "Pirimiphos_Ethyl", "Ethalfluralin", "Tecnazene", "Endosulfan_I", "Phosmet", "Chlormephos", "Dichlorfluanid", "Endosulfan_II", "Terbuthylazine", "Captan", "Iodofenphos", "Bromacil", "Prometryne", "Terbutryn", "Dicloran", "Triadimefon", "gamma-Chlordane", "Dimethoate", "Cyanazine", "Phosphamidon", "Butylate", "Terbufos", "Fenitrothion", "Omethoate", "Chlorthiophos", "DACTHAL_(DCPA)", "Dioxathion", "Eptam", "Chlorpropham", "Fenthion", "Simazine", "Metribuzin", "Heptachlor", "Lindane", "Isofenphos", "Sulfotep", "Aspon", "alpha-Chlordane", "Quintozene", "Dieldrin", "Hexazinone", "p;p'-DDT", "Aldrin", "Chlorpyrifos", "Tetrachlorvinphos", "Chlorfenson", "Fonofos", "Tetradifon", "De-ethyl_Atrazine", "Triallate", "Profluralin", "Vinclozolin", "Bromophos", "Trifluralin", "EPN", "Cyanophos", "Methidathion", "Ethion", "Disulfoton", "Dichlofenthion", "Pirimicarb", "Procymidone", "BHC;_beta", "BHC;_alpha", "Chlorothalonil", "Nitrofen", "Pirimiphos-methyl", "Endrin", "Propazine", "Metalaxyl", "Fensulfothion", "Diallate", "Diphenylamine", "Folpet", "Cyanide_S_A_D_", "Mercury_Dissolved", "Nitrogen_Organic_Total_Dissolved", "Hydroxide_Alkalinity_(as_CaCO3)", "Oxid__Red__Potential", "Temperature", "Temperature-Field", "Al_diss_meq", "CO3_meq", "Ca_meq", "Cl_meq", "Cu_diss_meq", "F_meq", "Fe_diss_meq", "HCO3_meq", "K_meq", "Meas_Alk_meq", "Mg_meq", "Mn_diss_meq", "NH4_meq", "NO2_meq", "NO3_meq", "Na_meq", "SO4_meq", "Zn_diss_meq", "anion_sum", "cation_sum", "charge_balance", "water_type", "missing_ion"]
        },
        "row.names": {
          "type": "integer",
          "attributes": {},
          "value": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40]
        },
        "class": {
          "type": "character",
          "attributes": {},
          "value": ["tbl_df", "tbl", "data.frame"]
        }
      },
      "value": [
        {
          "type": "character",
          "attributes": {},
          "value": ["", "1985-09-10", "1997-10-16", "2000-11-15", "2001-11-07", "2003-06-25", "2003-12-23", "2004-03-09", "2004-10-27", "2005-03-03", "2005-09-30", "2006-02-02", "1986-04-01", "2006-09-05", "2007-03-01", "2007-10-31", "2008-02-18", "2008-09-10", "2009-02-16", "2009-08-31", "2010-03-04", "2010-10-20", "2011-03-01", "1987-10-22", "2011-09-14", "2012-02-23", "2012-11-01", "2013-02-25", "2013-10-09", "2014-03-17", "2014-10-02", "2015-02-18", "2016-02-22", "2017-07-20", "1988-10-27", "1989-08-17", "1990-10-10", "1991-11-21", "1992-01-29", "1993-02-18"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", "1401057-1", "1401057-10", "1401057-11", "1401057-12", "1401057-13", "1401057-14", "1401057-15", "1401057-16", "1401057-17", "1401057-18", "1401057-19", "1401057-2", "1401057-20", "1401057-21", "1401057-22", "1401057-23", "1401057-24", "1401057-25", "1401057-26", "1401057-27", "1401057-28", "1401057-29", "1401057-3", "1401057-30", "1401057-31", "1401057-32", "1401057-33", "1401057-34", "1401057-35", "1401057-36", "1401057-37", "1401057-38", "1401057-39", "1401057-4", "1401057-5", "1401057-6", "1401057-7", "1401057-8", "1401057-9"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["°", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101", "49.017101"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND", "BACKGROUND"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["°", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651", "-122.341651"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002", "002"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water", "Fresh Water"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["m", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["m", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["m(asl)", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["m", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["m", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["m", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["m", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["m", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["°C", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["% mod.", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["‰", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, "10", "10", "10", "0.02", "0.02", "0.02", "0.02", "0.02", "0.02", "0.02", null, "0.02", "0.02", "0.005", "0.005", "0.005", "0.005", "0.005", "0.005", "0.005", "0.005", null, "0.005", "0.005", "0.005", "0.005", "0.005", "0.005", "0.005", "0.005", "0.01", "0.01", null, null, null, null, "10", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, "10", "10", "10", "0.02", "0.02", "0.02", "0.02", "0.02", "0.02", "0.02", null, "0.02", "0.02", "0.005", "0.005", "0.005", "0.005", "0.005", "0.005", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "10", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "20", "50", "50", "50", "0.3", "39.8", "0.3", "0.3", "0.3", "0.3", "0.3", null, "0.3", "0.3", "0.3", "0.6", "1.6", "1.1", "1", "0.4", "1.8", "0.7", "30", "1", "1.5", "1.02", "0.53", "1.34", "0.5", "0.5", "0.5", "1", "1", null, null, null, "100", "20", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "70", "60", "60", "60", "5.4", "142", "1.5", "0.4", "0.3", "0.3", "0.3", null, "0.5", "0.7", "1.1", "1.4", "7.9", "1", "1.1", "0.6", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "100", "100", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "250", "50", "50", "0.5", "0.1", "0.2", "0.1", "0.1", "0.1", "0.1", "0.1", null, "0.1", "0.1", "0.07", "0.06", "0.06", "0.1", "0.06", "0.08", "0.09", "0.05", "1", "0.04", "0.07", "0.037", "0.039", "0.025", "0.046", "0.062", "0.046", "0.1", "0.1", "1", null, null, null, "1", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "250", "0.5", "60", "60", "0.2", "0.2", "0.2", "0.1", "0.1", "0.1", "0.1", null, "0.2", "0.1", "0.09", "0.08", "0.07", "0.13", "0.06", "0.11", null, null, "1", null, null, null, null, null, null, null, null, null, null, "1", null, null, null, "1", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.01", "0.03", "0.04", "0.01", "0.03", "0.032", "0.029", "0.037", "0.026", "0.02", "0.031", null, "0.029", "0.029", "0.034", "0.034", "0.05", "0.05", "0.05", "0.05", "0.05", "0.05", "0.01", "0.05", "0.05", "0.05", "0.05", "0.05", "0.05", "0.045", "0.039", "0.038", "0.035", "0.01", "0.01", null, "0.01", "0.008", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "0.03", "0.1", "0.01", "0.03", "0.036", "0.029", "0.038", "0.033", "0.008", "0.038", null, "0.027", "0.026", "0.035", "0.034", "0.05", "0.05", "0.05", "0.05", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0.024", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.02", "0.006", "0.008", "0.003", "0.00473", "0.0062", "0.00097", "0.00099", "0.00114", "0.00161", "0.00129", null, "0.00188", "0.00262", "0.00307", "0.0024", "0.00239", "0.00325", "0.00345", "0.00381", "0.00467", "0.00558", "0.01", "0.00503", "0.00481", "0.00397", "0.0032", "0.00395", "0.00379", "0.00372", "0.00331", "0.00368", "0.00308", "0.01", "0.01", null, "0.01", "0.003", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "0.007", "0.01", "0.005", "0.00509", "0.00659", "0.00114", "0.00105", "0.00127", "2e-05", "0.0013", null, "0.00198", "0.00256", "0.00287", "0.00228", "0.00281", "0.00329", "0.00357", "0.00375", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0.01", "0.003", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "0.05", "0.3", "0.05", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0.5", "0.5", "0.5", "0.5", "0.5", "0.5", "0.5", "0.5", null, "0.5", "0.5", "0.5", "0.5", "0.5", "0.5", "0.5", "0.5", "1", "1", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "14.4", "28.7", "38.2", "14.5", "25.5", "25.5", "26.6", "24.2", "28", "29.5", "29.3", null, "31.6", "29.2", "27.9", "25.7", "26.9", "25.8", "25.7", "26", "25.5", "27", "8.67", "28.6", "25.5", "26.9", "23.3", "24.7", "23.1", "25.4", "24.5", "22.6", "19.3", "8.12", "9.59", null, "8.9", "8.74", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "14.4", "27.9", "35.6", "14.9", "25", "24.3", "24.2", "23.5", "28", "30.1", "27.9", null, "31.4", "28.7", null, null, "27.1", "26.3", "27.5", "26.5", null, null, "8.68", null, null, null, null, null, null, null, null, null, null, "8.36", "9.6", null, "10.2", "9.09", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "10", "5", "5", "5", "0.03", "0.05", "0.02", "0.01", "0.02", "0.02", "0.02", null, "0.03", "0.03", "0.011", "0.03", "0.028", "0.032", "0.031", "0.022", "0.028", "0.036", "10", "0.04", "0.03", "0.028", "0.014", "0.021", "0.021", "0.022", "0.018", "0.0164", "0.0168", "10", "10", null, "10", "2", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "10", "6", "9", "6", "0.05", "0.05", "0.03", "0.01", "0.02", "0.01", "0.02", null, "0.03", "0.03", "0.027", "0.034", "0.028", "0.034", "0.031", "0.024", null, null, "10", null, null, null, null, null, null, null, null, null, null, "10", "10", null, "10", "2", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "10.2", "9.6", "11.5", "11.6", "4.1", "7.5", "5.1", "5.2", "5.7", "7.1", "6.5", "10.7", "7.6", "6.4", "6.5", "6.9", "6", "5.7", "5.8", "5.2", "5.7", "6.2", "11.2", "7.7", "7.4", "8.1", "8.1", "10", "10", "7.6", "6.8", "5.73", "6.05", "12.6", "13.4", "13.3", "12.3", "9.6", "12.1"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.1", "0.005", "0.015", "0.005", "0.000111", "0.00164", "0.000286", "0.000262", "0.000174", "0.000229", "0.000146", null, "0.000181", "0.000108", "0.000156", "0.000113", "0.000103", "0.00017", "0.000112", "0.000103", "0.000135", "0.00018", "0.1", "0.000104", "0.000148", "0.000128", "0.000132", "9.4e-05", "7.9e-05", "7.2e-05", "0.000207", "1e-04", "1e-04", "0.1", "0.1", null, "0.1", "0.003", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.1", "0.006", "0.006", "0.006", "0.000243", "0.00171", "0.00033", "0.000261", "0.000186", "0.000231", "0.000144", null, "0.000199", "0.00012", "0.000187", "0.000106", "0.000117", "0.000176", "0.000104", "0.000128", null, null, "0.1", null, null, null, null, null, null, null, null, null, null, "0.1", "0.1", null, "0.1", "0.003", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["uS/cm", "115", "227", "302", "162", "206", "192", "191", "193", "214", "1", "223", "114", "244", "231", "230", "220", "230", "220", "226", "222", "219", "223", "107", "239", "221", "208", "202", "198", "201", "191", "196", "191", "177", "114", "130", "155", "142", "142", "149"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["uS/cm", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "176.7", "160.7", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "10", "16", "5", "5", "0.2", "1.9", "0.2", "0.2", "0.2", "0.2", "0.2", null, "0.5", "0.2", "0.1", "0.1", "0.3", "0.3", "0.3", "0.3", "0.3", "0.2", "10", "0.2", "0.1", "0.1", "0.1", "0.1", "0.11", "0.17", "0.17", "0.24", "0.1", "10", "10", null, "10", "2", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "20", "6", "6", "6", "1.3", "2.5", "1", "0.2", "0.2", "0.2", "0.2", null, "0.6", "0.2", "0.2", "0.3", "0.3", "0.4", "0.3", "0.3", null, null, "10", null, null, null, null, null, null, null, null, null, null, "10", "10", null, "10", "2", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "10", "5", "5", "5", "0.69", "2.05", "0.43", "1.06", "1.29", "0.09", "0.58", null, "1.14", "1.56", "1.43", "1.7", "1.71", "1.31", "1.14", "1.41", "1.89", "2.76", "10", "2.5", "0.79", "0.781", "0.946", "0.117", "0.179", "0.229", "0.156", "0.54", "0.2", "10", "10", null, "10", "3", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "110", "20", "6", "15", "6.14", "2.31", "2.4", "1.3", "1.46", "0.21", "0.58", null, "1.46", "2.09", "2.05", "1.93", "4.05", "1.95", "1.08", "1.53", null, null, "100", null, null, null, null, null, null, null, null, null, null, "60", "20", null, "30", "25", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "6.61", "5.5", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["g/cm3", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mV", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.1", null, "0.01", "0.03", "0.01", "0.04", "0.03", "0.02", "0.02", "0.02", "0.01", null, "0.02", null, "0.02", "0.01", "0.02", "0.03", "0.02", "0.01", "0.02", "0.02", null, "0.02", "0.02", "0.023", "0.019", "0.02", "0.018", "0.019", "0.019", "0.02", "0.02", "0.1", "0.1", "0.1", "0.1", "0.1", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.84", "0.058", "0.005", "0.009", "0.029", "0.119", "0.235", "0.005", null, "0.078", "0.005", null, "0.005", "0.023", "0.128", "0.102", "0.074", "0.13", "0.097", "0.116", "0.12", "0.103", "0.05", "0.083", "0.399", "1.2", "2.57", "3.03", "3.4", "2.34", "0.153", "0.801", "0.0383", "0.62", "0.01", null, "0.01", "0.088", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "99.6", "31.8", "31.801", "23.65", "10.6", "0.182", "1.8", "0.172", "0.206", "0.421", "0.572", null, "0.057", "0.557", "0.477", "0.244", "0.609", "0.209", "0.169", "0.473", null, null, "9.95", null, null, null, null, null, null, null, null, null, null, "12.4", "3.11", null, "6.21", "4.42", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, "38", "38", "39", "40", "38", "42", "35", "39", null, "44", "41.8", "47.1", "53.3", "46.1", "46.3", "53.2", "55.9", "42.7", "30.3", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.7", "0.9", "1.1", "0.6", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "0.81", "0.82", "0.84", "0.82", "0.76", "0.81", "0.89", "0.87", "1", "0.89", "0.88", "0.871", "0.814", "0.907", "0.745", "0.843", "0.803", "0.808", "0.72", "1.1", "1.1", "1.3", "0.9", "0.9", "0.9"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "0.9", "1.4", "0.6", "1", "1", "1", "2", "1", "1", "2", null, "1", "1", null, null, "0.81", "0.8", "0.85", "0.82", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "1.3", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, "0.00026", "3e-04", "0.00064", "0.00024", "0.00021", "0.00018", "0.00023", null, "8e-05", "0.00043", "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", null, "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, "0.00026", "0.00045", "0.00069", "0.00026", "0.00014", "0.00041", "0.00024", null, "0.00029", "0.00052", "6e-04", "5e-04", "5e-04", "5e-04", "5e-04", "5e-04", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "36.7", null, "36.3", "45.1", "31.3", "21.8", "28.3", "27.8", "28.3", "0.5", "28.8", "36.9", "30.4", "30.3", "32", "31", "32", "33", "31", "34", "29", "32", "34.9", "36", "34.2", "38.6", "43.7", "37.8", "37.9", "43.6", "45.8", "42.7", "30.3", "32.5", "42.7", "44.9", "45.2", "52.8", "29.3"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "93.9", "126.8", "49.5", "83.06928", "82.98692", "86.3925", "78.09362", "90", "95", "94", null, "100", "94.1", "91.2", "86.5", "87.8", "83.9", "83.5", "83.9", "84.2", "87.6", null, "93.1", "83.6", "86.6", "75.6", "81.2", "74.5", "82.7", "79.6", "72.8", "62.6", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "2.88", "5.4", "7.6", "3.2", "4.71", "4.69", "4.85", "4.29", "4.75", "0.05", "5.13", null, "5.43", "5.12", "5.26", "4.78", "5.08", "4.65", "4.73", "4.65", "4.96", "4.91", "2.05", "5.26", "4.82", "4.72", "4.21", "4.76", "4.09", "4.67", "4.49", "4", "3.48", "2.02", "2.54", null, "2.91", "2.08", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "2.97", "5.4", "7", "3.1", "4.53", "4.44", "4.51", "4.14", "4.64", "0.05", "4.93", null, "5.41", "5.04", null, null, "4.81", "4.77", "4.94", "4.76", null, null, "2.07", null, null, null, null, null, null, null, null, null, null, "2.11", "2.54", null, "3.16", "3.79", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.13", "0.027", "0.037", "0.045", "0.00952", "0.0435", "0.0355", "0.0207", "0.0123", "8e-06", "0.00791", null, "0.0127", "0.01", "0.0127", "0.00645", "0.00432", "0.012", "0.0058", "0.00708", "0.00725", "0.0159", "0.13", "0.0132", "0.052", "0.143", "0.23", "0.201", "0.185", "0.139", "0.178", "0.0721", "0.0196", "0.19", "0.28", null, "0.06", null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "0.47", "0.1", "0.072", "0.172", "0.0171", "0.0449", "0.0443", "0.0208", "0.0129", "0.0148", "0.00776", null, "0.0136", "0.0103", "0.012", "0.00658", "0.00455", "0.0137", "0.0063", "0.00783", null, null, "0.17", null, null, null, null, null, null, null, null, null, null, "0.29", "0.3", null, "0.11", "0.103", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "10", "10", "10", "10", "0.08", "0.13", "0.38", "0.1", "0.08", "0.07", "0.06", null, "0.07", "0.05", "0.07", "0.05", "0.05", "0.05", "0.05", "0.05", "0.12", "0.05", "10", "0.05", "0.05", "0.069", "0.121", "0.128", "0.084", "0.072", "0.053", "0.05", "0.107", "10", "10", null, "10", "4", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "10", "10", "10", "10", "0.05", "0.12", "0.42", "0.1", "0.16", "0.05", "0.07", null, "0.07", "0.05", "0.05", "0.1", "0.05", "0.08", "0.05", "0.05", null, null, "10", null, null, null, null, null, null, null, null, null, null, "10", "10", null, "10", "4", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "2.22", "0.014", "0.009", "3", "0.009", "0.005", "0.074", "0.035", "0.025", "0.072", "0.034", "2.44", "0.01", null, "0.008", "0.005", "0.007", "0.047", "0.005", "0.005", "0.005", "0.023", "2.47", "0.031", "0.086", "0.167", "0.148", "0.079", "0.0594", "0.0313", "0.0635", "0.0305", "0.005", "2.65", "2.93", "4.65", "4.25", "5.24", "3.16"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0", null, null, "0", null, "0", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, "0.005", "0.039", "0.003", "0.005", "0.008", "0.003", "0.004", "0.002", "0.002", "0.006", "0.002", "0.002", "0.002", "0.002", "0.002", "0.004", "0.002", "0.002", "0.002", "0.002", "0.005", "0.005", "0.007", "0.0069", "0.0064", "0.009", "0.004", "0.002", "0.0118", "0.001", "0.001", null, "0.01", "0.011", "0.016", "0.028", "0.05"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "11.9", null, "0.025", "10.297", "9.755", "9.922", "9.647", "10.7", "12.698", "12.398", null, "13.598", "12.998", "12.5", "11.4", "12.1", "11.8", "12.6", "11.9", "12.6", "11.1", null, "12.7", "10.3", "7.75", "5.59", "5.92", "5.83", "5.74", "5.27", "5.67", "4.42", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "4", "4.5", "6", "4.5", "5.11", "5.07", "5.02", "4.85", "4.99", "0.07", "5.52", "4.4", "5.59", "5.2", "5.06", "5.36", "5.06", "4.82", "4.89", "4.78", "4.89", "4.82", "4.8", "5.19", "4.95", "5.13", "4.61", "5.4", "4.66", "5.41", "5.13", "5.04", "4.66", "5.1", "5.1", "7", "5", "4.91", "4.5"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "5.2", "5.9", "4", "4.7", "4.92", "4.79", "4.55", "4.86", "5.34", "5.04", null, "5.58", "5.14", null, null, "4.91", "5.02", "5.27", "4.95", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "6.04", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "50", "20", "20", "20", "2.94", "3.16", "27.5", "99.7", "80", "81.3", "46.5", null, "67.3", "40.4", "47.7", "27.9", "31.9", "43.3", "28.9", "29.2", "37.6", "46.8", "50", "34.2", "6.36", "11.6", "0.942", "2.48", "1.58", "1.91", "1.43", "2.5", "0.5", "50", "50", null, "50", "8", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "50", "20", "40", "20", "3.14", "3.33", "30.4", "104", "68.6", "0.05", "46.1", null, "69.5", "38.8", "48.1", "26.6", "29.4", "42.1", "31.1", "31.6", null, null, "50", null, null, null, null, null, null, null, null, null, null, "50", "50", null, "50", "8", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "100", "50", "50", "50", "0.07", "22.8", "0.01", "0.01", "0.01", "0.01", "0.07", null, "0.03", "0.04", "0.02", "0.088", "0.112", "0.094", "0.141", "0.036", "0.144", "0.067", "100", "0.28", "0.225", "0.025", "0.119", "0.013", "0.01", "0.055", "0.005", "6.9", "0.05", "100", "100", null, "100", "20", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "300", "140", "90", "60", "49.8", "46.9", "5.44", "0.34", "1.42", "0.01", "1.54", null, "1.4", "7.7", "2.73", "4.13", "5.43", "1.12", "0.715", "3.26", null, null, "100", null, null, null, null, null, null, null, null, null, null, "100", "100", null, "100", "30", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", "1", null, "18", "16.9", "14.1", "13.8", "14.3", "16.2", "18.1", "17.4", "16.5", "1", "17.6", "16.5", "17", "16.6", "17", "16", "16", "17", "19", "18", "1", "19", "19.6", "16", "16.9", "15.8", "16", "15", "16.5", "16.7", "13.7", "1", "1.6", "6.2", "4.2", "3.4", "2.7"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, "50", "50", "50", "0.028", "0.028", "0.112", "0.026", "0.024", "0.005", "0.009", null, "0.021", "0.015", "0.02", "0.02", "0.02", "0.03", "0.02", "0.02", "0.02", "0.02", null, "0.02", "0.02", "0.026", "0.02", "0.02", "0.02", "0.02", "0.02", "0.35", "0.1", null, null, null, null, "15", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, "60", "60", "60", "0.068", "0.03", "0.131", "0.034", "0.022", "0.022", "0.007", null, "0.022", "0.015", "0.02", "0.02", "0.02", "0.06", "0.02", "0.02", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "15", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, "50", "50", "50", "0.2", "0.2", "0.3", "0.2", "0.3", "0.2", "0.2", null, "0.2", "0.3", "0.12", "0.11", "0.14", "0.12", "0.12", "0.11", "0.1", "0.11", null, "0.15", "0.11", "0.087", "0.116", "0.083", "0.082", "0.071", "0.09", "0.087", "0.085", null, null, null, null, "30", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, "60", "60", "60", "0.3", "0.2", "0.2", "0.2", "0.3", "0.3", "0.3", null, "0.2", "0.3", "0.11", "0.12", "0.09", "0.12", "0.12", "0.1", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "30", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "10.9", "10.94", "0.47", null, null, null, null, null, null, null, null, null, null, "11.5", "10.6", "10.4", "10.5", "10.4", "11.2", "11.2", "10.6", null, "10.2", "8.52", "9.52", "7.87", "8.34", "8.32", "10.3", "9.51", "9.17", "8.08", null, null, null, null, "0.17", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "12.7", "12.55", "1.6", null, null, null, null, null, null, null, null, null, null, "10.3", "10.1", "10.7", "10.1", "10.6", "10.6", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0.5", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "0.135", "0.191", "0.083", "0.112", "0.0847", "0.0883", "0.0932", "0.106", "0.119", "0.109", null, "0.125", "0.123", "0.138", "0.124", "0.112", "0.126", "0.124", "0.12", "0.121", "0.123", null, "0.133", "0.121", "0.123", "0.114", "0.128", "0.12", "0.113", "0.113", "0.114", "0.0947", null, null, null, null, "0.045", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, "0.14", "0.178", "0.079", "0.11", "0.0875", "0.0989", "0.0944", "0.107", "0.12", "0.11", null, "0.13", "0.122", "0.125", "0.12", "0.124", "0.118", "0.125", "0.12", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0.083", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, "2e-06", "3.3e-05", "4e-06", "5e-06", "5e-06", "2e-06", "4e-06", null, "6e-06", "3e-06", "2e-06", "2e-06", "3e-06", "2e-06", "2e-06", "2e-06", "2e-06", "2e-06", null, "2e-06", "3e-06", "2e-06", "2e-06", "2e-06", "2e-06", "2e-06", "2e-06", "1e-05", "1e-05", null, null, null, null, "0.003", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["mg/L", null, null, null, null, "2e-06", "5e-05", "5e-06", "5e-06", "5e-06", "2e-06", "4e-06", null, "6e-06", "3e-06", "2e-06", "3e-06", "2e-06", "4e-06", "2e-06", "3e-06", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0.003", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["T.U.", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, "0.002", "0.004", "0.002", "0.002", "0.002", "0.002", "0.002", null, "0.002", "0.002", "0.002", "0.003", "0.002", "0.003", "0.005", "0.002", "0.004", "0.007", null, "0.003", "0.002", "0.002", "0.002", "0.002", "0.003", "0.004", "0.004", "0.01", "0.01", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, "0.014", "0.008", "0.002", "0.002", "0.01", "0.002", "0.002", null, "0.002", "0.002", "0.007", "0.005", "0.004", "0.004", "0.002", "0.003", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "10", "10", "10", "10", "0.06", "0.65", "0.41", "0.06", "0.06", "0.09", "0.06", null, "0.06", "0.06", "0.2", "0.2", "0.2", "0.2", "0.2", "0.2", "0.2", "0.3", "10", "0.3", "0.2", "0.2", "0.22", "0.2", "0.2", "0.2", "0.2", "0.5", "0.5", "10", "10", null, "10", "3", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "10", "10", "20", "10", "1.38", "0.6", "0.58", "0.08", "0.06", "0.06", "0.06", null, "0.1", "0.07", "0.2", "0.2", "0.2", "0.2", "0.2", "0.2", null, null, "10", null, null, null, null, null, null, null, null, null, null, "10", "10", null, "10", "3", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "70", "6", "6", "2", "1.7", "3.8", "2", "0.7", "0.1", "0.1", "0.9", null, "1.5", "0.2", "0.1", "0.4", "0.1", "2.9", "0.7", "0.6", "1", "5.8", "30", "0.6", "1.2", "4.37", "11.5", "2.2", "0.74", "0.87", "0.65", "1", "1", "20", "10", null, "10", "10", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["ug/L", "130", "10", "14", "15", "2.8", "3.9", "2.5", "0.7", "0.1", "0.3", "1", null, "1.6", "0.1", "0.9", "1.7", "0.7", "2.6", "0.5", "0.5", null, null, "130", null, null, null, null, null, null, null, null, null, null, "90", "30", null, "30", "11", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["pH", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, "6.22", "6.21", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["pH", "7.4", "6.51", "6.97", "7.9", "7.1", "7.2", "7.3", "7.1", "6.6", "5.8", "6.8", "8.1", "7.2", "7.2", "7.1", "7.3", "7.1", "6.9", "7.2", "7", "6.82", "6.7", "7.6", "7.17", "6.76", "7.51", "7.15", "7.22", "6.99", "7.21", "7.53", "6.57", "6.68", "7.3", "7.9", "8.4", "7.8", "7.8", "7.1"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.00222379864837518", "0.00555949662093795", "0.00555949662093795", "0.00555949662093795", "3.33569797256277e-05", "0.00442535931026661", "3.33569797256277e-05", "3.33569797256277e-05", "3.33569797256277e-05", "3.33569797256277e-05", "3.33569797256277e-05", null, "3.33569797256277e-05", "3.33569797256277e-05", "3.33569797256277e-05", "6.67139594512554e-05", "0.000177903891870015", "0.000122308925660635", "0.000111189932418759", "4.44759729675036e-05", "0.000200141878353766", "7.78329526931314e-05", "0.00333569797256277", "0.000111189932418759", "0.000166784898628139", "0.000113413731067134", "5.89306641819423e-05", "0.000148994509441137", "5.55949662093795e-05", "5.55949662093795e-05", "5.55949662093795e-05", "0.000111189932418759", "0.000111189932418759", null, null, null, "0.0111189932418759", "0.00222379864837518", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", null, "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.016664194811103", "0.033328389622206", "0.033328389622206", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.71859873247168", "1.43220719596786", "1.90628274864015", "0.723589001447178", "1.27251858875193", "1.27251858875193", "1.32741154748241", "1.20764509207046", "1.39727531313938", "1.47212934777184", "1.46214880982085", null, "1.5769249962573", "1.45715854084535", "1.39228504416388", "1.28249912670293", "1.3423823544089", "1.28748939567843", "1.28249912670293", "1.29746993362942", "1.27251858875193", "1.3473726233844", "0.432656320175657", "1.42721692699236", "1.27251858875193", "1.3423823544089", "1.16273267129098", "1.23259643694795", "1.15275213333999", "1.26752831977644", "1.22261589899696", "1.1278007884625", "0.963121912271071", "0.40520984081042", "0.478566794750237", null, "0.444133938819302", "0.436149508458506", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.287704848672891", "0.270781034045074", "0.324373113699828", "0.327193749471131", "0.115646066623417", "0.211547682847714", "0.143852424336445", "0.146673060107748", "0.160776238964263", "0.200265139762502", "0.183341325134685", "0.301808027529405", "0.214368318619017", "0.180520689363383", "0.183341325134685", "0.194623868219897", "0.169238146278171", "0.160776238964263", "0.163596874735565", "0.146673060107748", "0.160776238964263", "0.174879417820777", "0.315911206385919", "0.21718895439032", "0.208727047076411", "0.228471497475531", "0.228471497475531", "0.282063577130285", "0.282063577130285", "0.214368318619017", "0.191803232448594", "0.161622429695653", "0.170648464163823", "0.355400107184159", "0.377965193354582", "0.375144557583279", "0.346938199870251", "0.270781034045074", "0.341296928327645"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.000314732634626884", "0.000157366317313442", "0.000157366317313442", "0.000157366317313442", "2.1716551789255e-05", "6.45201900985113e-05", "1.3533503288956e-05", "3.33616592704498e-05", "4.06005098668681e-05", "2.83259371164196e-06", "1.82544928083593e-05", null, "3.58795203474648e-05", "4.9098291001794e-05", "4.50067667516445e-05", "5.35045478865704e-05", "5.38192805211972e-05", "4.12299751361219e-05", "3.58795203474648e-05", "4.43773014823907e-05", "5.94844679444812e-05", "8.68662071570201e-05", "0.000314732634626884", "7.86831586567211e-05", "2.48638781355239e-05", "2.45806187643597e-05", "2.97737072357033e-05", "3.68237182513455e-06", "5.63371415982123e-06", "7.20737733295565e-06", "4.9098291001794e-06", "1.69955622698518e-05", "6.29465269253769e-06", "0.000314732634626884", "0.000314732634626884", null, "0.000314732634626884", "9.44197903880653e-05", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.00526360114535961", null, "0.000526360114535961", "0.00157908034360788", "0.000526360114535961", "0.00210544045814384", "0.00157908034360788", "0.00105272022907192", "0.00105272022907192", "0.00105272022907192", "0.000526360114535961", null, "0.00105272022907192", null, "0.00105272022907192", "0.000526360114535961", "0.00105272022907192", "0.00157908034360788", "0.00105272022907192", "0.000526360114535961", "0.00105272022907192", "0.00105272022907192", null, "0.00105272022907192", "0.00105272022907192", "0.00121062826343271", "0.00100008421761833", "0.00105272022907192", "0.00094744820616473", "0.00100008421761833", "0.00100008421761833", "0.00105272022907192", "0.00105272022907192", "0.00526360114535961", "0.00526360114535961", "0.00526360114535961", "0.00526360114535961", "0.00526360114535961", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.0300832661831856", "0.00207717790312472", "0.0001790670606142", "0.00032232070910556", "0.00103858895156236", "0.00426179604261796", "0.0084161518488674", "0.0001790670606142", null, "0.00279344614558152", "0.0001790670606142", null, "0.0001790670606142", "0.00082370847882532", "0.00458411675172352", "0.00365296803652968", "0.00265019249709016", "0.0046557435759692", "0.00347390097591548", "0.00415435580624944", "0.0042976094547408", "0.00368878144865252", "0.001790670606142", "0.00297251320619572", "0.0142895514370132", "0.042976094547408", "0.0920404691556988", "0.108514638732205", "0.121765601217656", "0.0838033843674456", "0.00547945205479452", "0.0286865431103948", "0.00137165368430477", "0.0222043155161608", "0.0003581341212284", null, "0.0003581341212284", "0.00315158026680992", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", null, null, null, null, null, null, null, null, null, null, null, null, null, null, "0.622788486279806", "0.622788486279806", "0.63917765697138", "0.655566827662953", "0.622788486279806", "0.688345169046101", "0.573620974205084", "0.63917765697138", null, "0.721123510429249", "0.685067334907786", "0.771929939573128", "0.873542797860885", "0.755540768881554", "0.758818603019868", "0.871903880791728", "0.916154641658977", "0.699817588530203", "0.496591871954687", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.0179035917162639", "0.0230189036351964", "0.028134215554129", "0.0153459357567976", "0.0255765595946627", "0.0255765595946627", "0.0255765595946627", "0.0255765595946627", "0.0255765595946627", "0.0255765595946627", "0.0255765595946627", "0.0255765595946627", "0.0255765595946627", "0.0255765595946627", "0.0207170132716768", "0.0209727788676234", "0.0214843100595167", "0.0209727788676234", "0.0194381852919436", "0.0207170132716768", "0.0227631380392498", "0.0222516068473565", "0.0255765595946627", "0.0227631380392498", "0.0225073724433032", "0.0222771834069512", "0.0208193195100554", "0.0231979395523591", "0.0190545368980237", "0.0215610397383006", "0.0205379773545141", "0.0206658601524874", "0.0184151229081571", "0.028134215554129", "0.028134215554129", "0.0332495274730615", "0.0230189036351964", "0.0230189036351964", "0.0230189036351964"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.733362707806916", null, "0.725369653770873", "0.901216842563812", "0.62545647832034", "0.435621444964326", "0.56550857305002", "0.555517255504966", "0.56550857305002", "0.00999131754505335", "0.575499890595073", "0.737359234824937", "0.607472106739244", "0.605473843230233", "0.639444322883414", "0.619461687793308", "0.639444322883414", "0.659426957973521", "0.619461687793308", "0.679409593063628", "0.579496417613094", "0.639444322883414", "0.697393964644724", "0.719374863243841", "0.683406120081649", "0.771329714478118", "0.873241153437663", "0.755343606406033", "0.757341869915044", "0.871242889928652", "0.915204687126887", "0.853258518347556", "0.605473843230233", "0.649435640428468", "0.853258518347556", "0.897220315545791", "0.903215106072823", "1.05508313275763", "0.585491208140126"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.236988274017692", "0.444353013783172", "0.625385723102242", "0.263320304464102", "0.3875745731331", "0.3859288212302", "0.399094836453405", "0.353013783172187", "0.390866076938901", "0.00411437975725159", "0.422135363094014", null, "0.446821641637523", "0.421312487142563", "0.432832750462868", "0.393334704793252", "0.418020983336762", "0.382637317424398", "0.389220325036001", "0.382637317424398", "0.408146471919358", "0.404032092162107", "0.168689570047315", "0.432832750462868", "0.396626208599054", "0.38839744908455", "0.346430775560584", "0.391688952890352", "0.33655626414318", "0.384283069327299", "0.369471302201193", "0.329150380580128", "0.286360831104711", "0.166220942192964", "0.209010491668381", null, "0.239456901872043", "0.171158197901666", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.00473260422104611", "0.000982925492063423", "0.00134697197060543", "0.00163820915343904", "0.000346572247571992", "0.00158360218165774", "0.00129236499882413", "0.000753576210581957", "0.00044777716860667", "2.91237182833607e-07", "0.000287960764526729", null, "0.000462339027748351", "0.000364046478542008", "0.000462339027748351", "0.000234809978659595", "0.000157268078730148", "0.00043685577425041", "0.000211146957554365", "0.000257744906807742", "0.000263933696942956", "0.000578833900881793", "0.00473260422104611", "0.000480541351675451", "0.00189304168841844", "0.00520586464315072", "0.00837306900646619", "0.00731733421869437", "0.00673485985302716", "0.00506024605173392", "0.00648002731804775", "0.00262477511028788", "0.000713531097942336", "0.00691688309229816", "0.0101933013991762", null, "0.00218427887125205", null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.158495577116666", "0.000999521657492486", "0.000642549636959455", "0.214183212319818", "0.000642549636959455", "0.000356972020533031", "0.00528318590388885", "0.00249880414373121", "0.00178486010266515", "0.00514039709567564", "0.00242740973962461", "0.174202346020119", "0.000713944041066061", null, "0.000571155232852849", "0.000356972020533031", "0.000499760828746243", "0.00335553699301049", "0.000356972020533031", "0.000356972020533031", "0.000356972020533031", "0.00164207129445194", "0.176344178143317", "0.00221322652730479", "0.00613991875316813", "0.0119228654858032", "0.0105663718077777", "0.00564015792442188", "0.0042408276039324", "0.00223464484853677", "0.00453354466076949", "0.00217752932525149", "0.000356972020533031", "0.189195170882506", "0.209185604032356", "0.331983979095718", "0.303426217453076", "0.374106677518616", "0.225606316976875"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", null, null, "0.000356972020533031", "0.00278438176015764", "0.000214183212319818", "0.000356972020533031", "0.000571155232852849", "0.000214183212319818", "0.000285577616426425", "0.000142788808213212", "0.000142788808213212", "0.000428366424639637", "0.000142788808213212", "0.000142788808213212", "0.000142788808213212", "0.000142788808213212", "0.000142788808213212", "0.000285577616426425", "0.000142788808213212", "0.000142788808213212", "0.000142788808213212", "0.000142788808213212", "0.000356972020533031", "0.000356972020533031", "0.000499760828746243", "0.000492621388335582", "0.000456924186282279", "0.000642549636959455", "0.000285577616426425", "0.000142788808213212", "0.000842453968457952", "7.13944041066061e-05", "7.13944041066061e-05", null, "0.000713944041066061", "0.000785338445172667", "0.0011423104657057", "0.00199904331498497", "0.00356972020533031"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", null, "0.849593408868613", null, "0.00178486010266515", "0.735148179085723", "0.696452412059943", "0.708375277545746", "0.688741816416429", "0.763920123940685", "0.906566143345685", "0.885147822113703", null, "0.97082110704163", "0.927984464577666", "0.892430051332577", "0.81389620681531", "0.863872289689934", "0.842453968457952", "0.899569491743237", "0.849593408868613", "0.899569491743237", "0.792477885583328", null, "0.906708932153898", "0.735362362298043", "0.553306631826197", "0.399094718955928", "0.422654872311108", "0.416229375941514", "0.409803879571919", "0.376248509641814", "0.404806271284457", "0.315563266151199", null, null, null, null, null, null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.173990431396225", "0.195739235320754", "0.260985647094338", "0.195739235320754", "0.222272776108678", "0.220532871794716", "0.218357991402263", "0.210963398067923", "0.217053063166791", "0.00304483254943394", "0.240106795326791", "0.191389474535848", "0.243151627876225", "0.226187560815093", "0.220097895716225", "0.233147178070942", "0.220097895716225", "0.209658469832452", "0.212703302381886", "0.207918565518489", "0.212703302381886", "0.209658469832452", "0.20878851767547", "0.225752584736602", "0.215313158852829", "0.223142728265659", "0.20052397218415", "0.234887082384904", "0.202698852576603", "0.235322058463395", "0.223142728265659", "0.219227943559244", "0.202698852576603", "0.221837800030187", "0.221837800030187", "0.304483254943394", "0.217488039245282", "0.213573254538867", "0.195739235320754"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.0208197571167135", null, "0.374755628100843", "0.351853895272458", "0.29355857534566", "0.287312648210646", "0.297722526769003", "0.337280065290758", "0.376837603812514", "0.362263773830814", "0.343525992425772", "0.0208197571167135", "0.366427725254157", "0.343525992425772", "0.353935870984129", "0.345607968137444", "0.353935870984129", "0.333116113867416", "0.333116113867416", "0.353935870984129", "0.395575385217556", "0.374755628100843", "0.0208197571167135", "0.395575385217556", "0.408067239487584", "0.333116113867416", "0.351853895272458", "0.328952162444073", "0.333116113867416", "0.312296356750702", "0.343525992425772", "0.347689943849115", "0.285230672498975", "0.0208197571167135", "0.0333116113867416", "0.129082494123624", "0.0874429798901966", "0.0707871741968258", "0.0562133442151264"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq", "0.00214132762312634", "0.000183542367696543", "0.000183542367696543", "6.11807892321811e-05", "5.20036708473539e-05", "0.000116243499541144", "6.11807892321811e-05", "2.14132762312634e-05", "3.05903946160905e-06", "3.05903946160905e-06", "2.75313551544815e-05", null, "4.58855919241358e-05", "6.11807892321811e-06", "3.05903946160905e-06", "1.22361578464362e-05", "3.05903946160905e-06", "8.87121443866626e-05", "2.14132762312634e-05", "1.83542367696543e-05", "3.05903946160905e-05", "0.000177424288773325", "0.000917711838482717", "1.83542367696543e-05", "3.67084735393087e-05", "0.000133680024472316", "0.000351789538085041", "6.72988681553992e-05", "2.2636892015907e-05", "2.66136433159988e-05", "1.98837565004589e-05", "3.05903946160905e-05", "3.05903946160905e-05", "0.000611807892321811", "0.000305903946160905", null, "0.000305903946160905", "0.000305903946160905", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq/L", "1.05", "1.12", "1.43", "1.59", "1.77", "1.63", "1.72", "1.73", "1.87", "1.48", "1.99", "1.06", "2.16", "2.06", "2.07", "1.97", "2.03", "2", "2.02", "2.03", "2.04", "1.98", "1.03", "2.24", "2.04", "1.89", "1.85", "1.79", "1.79", "1.81", "1.83", "1.77", "1.38", "1.03", "1.27", "1.41", "1.34", "1.4", "0.99"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["meq/L", "1.35", "2.11", "2.83", "1.42", "1.91", "1.92", "1.99", "1.8", "2.03", "1.51", "2.15", "0.39", "2.29", "2.13", "2.07", "1.93", "2.01", "1.91", "1.91", "1.91", "1.92", "1.99", "1.02", "2.11", "1.93", "2.04", "1.84", "2", "1.84", "2", "1.85", "1.73", "1.47", "1.04", "1.16", "0.67", "1.24", "1.22", "0.44"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["%", "12.5", "30.5", "33", "-5.5", "3.8", "7.9", "7.2", "2", "4.2", "1.1", "4", "-46.1", "3", "1.8", "0", "-1", "-0.5", "-2.3", "-2.8", "-3", "-2.9", "0.2", "-0.5", "-2.9", "-2.7", "3.8", "-0.3", "5.6", "1.5", "5", "0.6", "-1.1", "3.3", "0.5", "-4.6", "-35.5", "-4", "-6.9", "-37.9"]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, "Ca-HCO3*-SO4-Cl", "Ca-Mg-HCO3*-SO4", "Ca-Mg-HCO3*-SO4", "Ca-Mg-HCO3*-SO4", "Ca-Mg-HCO3*-SO4", "Ca-Mg-HCO3*-SO4", "Ca-SO4", "Ca-Mg-HCO3*-SO4", null, "Ca-Mg-HCO3*-SO4", "Ca-Mg-HCO3*-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Na-HCO3*-Cl", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Mg-HCO3-SO4", "Ca-Na-HCO3*-Cl", "Ca-Na-HCO3*-Cl", null, "Ca-Mg-HCO3*-Cl", "Ca-HCO3*-Cl", null]
        },
        {
          "type": "character",
          "attributes": {},
          "value": ["", null, null, null, "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", null, "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", "FALSE", null, "FALSE", "FALSE", null]
        }
      ]
    }

