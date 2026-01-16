# Assignment 2

## Data cleaning -> Assignment_2/data_cleaning.R

The dataset was cleaned and restructured to ensure biological validity. First, the variable type was checked to ensure all values were numeric. Once this was confirmed, the mice excluded from the original study were removed. This was done by creating a function that takes the box number and the mouse as inputs and removes their entries. To verify that the mice were removed, the number of rows in the original dataset was compared with that in the cleaned version. The resistant and sensitive gametic strains were also removed since the downstream analysis will involve infection. 

Moreover, since all values were numerical, both the Box and Mouse columns were changed to factors. This ensures that ggplot2 or any other packages would treat these as numbers and perform calculations on them. Additionally, a Mouse_ID was created to give a unique identifier for each mouse. This is because the original dataset reused identical mouse numbers (1–5) across all thirteen treatment boxes. Therefore, if the data were grouped by mouse, it might calculate the average for mouse 1, which would include different treatments. Assigning a unique ID ensures that per-mouse metrics can be calculated. Furthermore, the original dataset had different columns for the resistant asexual strain (R.asex) and the sensitive asexual strain (S.asex). The `pivot_longer()` function was applied to create a column listing the strain (R.asex or S.asex) and a Density column listing each strain's density. The presence of NA values was verified, and none were found. Next, the densitywas transformed using $\log_{10}(x + 1)$ to linerize expoennetial growth. Since there were zero values in the early days of the experiment, a constant (+1) was added. 

To verify if there were zeros in the RBC and weight columns, a simple scatter plot was created for both variables. Since the presence of zeros in RBC or weight in early days would indicate an entering inconsistency. After plotting, RBC values of 0 were only observed later in the experiment, indicating mortality. Furthermore, the parasite _Plasmodium chabaudi_, can release up to 8 progeny per day, meaning that any increase above an 8-fold change per day would indicate a sampling error. A `log_growth` column was then added to the dataset and plotted against the maximum fold change to visualize 










