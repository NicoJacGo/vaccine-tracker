### **Texas COVID vaccine tracker** 
---
A web application primarily concerned with the visualization of data detailing pharmacy locations vaccine dosage allotments.

**NOTE**: Data is aggregated from two datasets published by the Texas DHS: [tableau-data](https://tabexternal.dshs.texas.gov/t/THD/views/COVID-19VaccineinTexasDashboard/Summary?%3Aorigin=card_share_link&%3Aembed=y&%3AisGuestRedirectFromVizportal=y) and
[DHS' website with weekly vaccine allocation reports](https://www.dshs.texas.gov/coronavirus/immunize/vaccine.aspx)




Preliminary vaccine tracker with an emphasis on Texas' DHS data (published on a weekly basis)

Implementation:

    - Anlysis portion:
        - Texas map with counties displaying aggregate vaccine doses receoved to-date and per capita figures.
        - Rolling one-week average 
    - Interactive portion
        - Locations of pharmacies/grocery stores with vaccine doses. 
        
Technologies:
    - Will use React for the frontend and R language for the API/backend for data visualization and an interactive map. 
    
