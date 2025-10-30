# Deriving variables that predict missing data in the CLS cohort studies: NCDS, BCS70, Next Steps, and MCS

[Centre for Longitudinal Studies](https://cls.ucl.ac.uk/)

---

## Overview
- This repository provides **Stata do files** that derive variables that predict non-response or missing data in each of the CLS cohort studies: NCDS, BCS70, Next Steps, and MCS. These variables have been identified in an extensive programme of work that informs users on how best to deal with missing data in longitudinal cohort studies.
- The [**handling missing data in the CLS cohort studies user guide**](https://cls.ucl.ac.uk/wp-content/uploads/2020/04/Handling-Missing-Data-User-Guide-2024.pdf) provides full information on how the variables predicting missing data have been identified and how they should be used.

---

## Syntax and data availability

- *Source data:* Download raw data from each of the cohort studies from the [**UK Data Service**](https://ukdataservice.ac.uk/). For each cohort study, most raw data files for all study sweeps are needed for deriving the final dataset of variables that predict missing data.   
- *Syntax:* `01_build_dataset.R` reads those files and produces `data/derived/next_steps.parquet` *(note: keep the code well-commented and use **relative** file paths—e.g., `here::here("data", "raw", ...)` in R, or `$raw` / `$derived` globals in Stata).*
- *Derived dataset:* Available to download from the [**UK Data Service**](https://beta.ukdataservice.ac.uk).

---

## User feedback and future plans

We welcome user feedback. Please open an issue on GitHub or email **clsdata@ucl.ac.uk**.

## Authors
- X author
 
## Contributors [optional e.g., for code checkers]

- X contributor

## Licence  
Code: MIT Licence (see `LICENSE`).

---

© 2025 UCL Centre for Longitudinal Studies
