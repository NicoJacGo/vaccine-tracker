# **Texas COVID vaccine tracker** 
---
A web application primarily concerned with the visualization of data detailing pharmacy locations vaccine dosage allotments.

**NOTE**: Data is aggregated from two datasets published by the Texas DHS: [tableau-data](https://tabexternal.dshs.texas.gov/t/THD/views/COVID-19VaccineinTexasDashboard/Summary?%3Aorigin=card_share_link&%3Aembed=y&%3AisGuestRedirectFromVizportal=y) and
[DHS' website with weekly vaccine allocation reports](https://www.dshs.texas.gov/coronavirus/immunize/vaccine.aspx)

## Functionality

    - Analysis portion:
        - Texas map with counties displaying aggregate vaccine doses receoved to-date and per capita figures.
        - Rolling one-week average 
    - Interactive portion
        - Locations of pharmacies/grocery stores with vaccine dose alotments. 
        
    - Technologies:
        - Will use React for the frontend and R language for the API/backend for data visualization and an interactive map. 
    
## Intended Uses

We intend on making this web application available to the general populace, giving them the ability to easily locate the nearest location offering vaccines, with the given weekly vaccine allotment and previous weekly data, along with aggregate weekly allotment data.

If possible, data regarding the number of vaccinated individuals will be subtracted from the weekly allotment data, giving users a more accurate view of the current number of available doses at a given location. 

Additional information will include analysis-related information such as (1) vaccinated individuals per capita, (2) number of *fully* vaccinated individuals (two doses), and (3) aggregate data.

## Acknowledgments

 - Libraries used:
    - tidyverse
    - ggmap
    - ggplot2
    - rvest
    - dplyr
    - taskscheduleR (CRON)
    - ...


