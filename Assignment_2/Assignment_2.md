# Assignment 2

## Data cleaning -> `Assignment_2/data_cleaning.R`

The dataset was cleaned and restructured to ensure biological validity. First, the variable type was checked to ensure all values were numeric. Once this was confirmed, mice that were excluded in the original study were removed. This was don by creating a function that takes the box number and mouse as inputs and removes their entries. To check the mice were removed, the number of rows in the original dataset was compared to the cleaned version. Moreover, since all values were numerical, both the Box and Mouse columns were changehd to factors. This ensures that ggplot2 or any other packages would treat these as numbers and perform calculations on them. Additionally, a Mouse_ID was created to give a unique identifier for each mouse. This is because the original dataset reused identical mouse numbers (1–5) across all thirteen treatment boxes. Therefore, if the data were to be grouped by mouse, it may calculate the avergae for mouse 1, which would include different treatments. By assigning a uniqe ID, it ensures that per-mouse metrics can be calculatedd. Furtehr more, the original datset had different columns for the reisstant asexual straion (R.asex) and the sensitive asexual strain (S.asex)


