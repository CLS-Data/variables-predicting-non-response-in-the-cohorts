# Deriving datasets of variables that predict missing data the CLS cohort studies: NCDS, BCS70, Next Steps, and MCS

[Centre for Longitudinal Studies](https://cls.ucl.ac.uk/)

---

## Overview [high-level summary, e.g. the below]
- This repository provides **Stata do files** that derive datasets of variables that predict non-response or missing data in each of the CLS cohorts: NCDS, BCS70, Next Steps, and MCS. These variables have been identified in an extensive programme of work that informs users on how best to deal with missing data in longitudinal cohort studies.
- The [**handling missing data in the CLS cohort studies user guide**](https://cls.ucl.ac.uk/wp-content/uploads/2020/04/Handling-Missing-Data-User-Guide-2024.pdf) provides full information on how the variables predicting missing data should be used

---

## Included variable domains [give an illustrative overview – no need to duplicate what already exists e.g., in UKDS documentation]

| Domain         | Examples                               |
| -------------- | -------------------------------------- |
| Demographics   | sex, ethnicity, language               |
| Socio-economic | parental education, household income   |
| Education      | qualifications, institution type       |
| Health         | self-rated health, limiting illness    |
| Relationships  | partnership status, sexual orientation |

*See `xxx.docx` for full details.*

---

## Syntax and data availability [tell the user where the syntax is + how source data should be **set up** to run it]

- *Source data:* Download raw Next Steps files from the **UK Data Service** and place them in `data/raw/`.
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
