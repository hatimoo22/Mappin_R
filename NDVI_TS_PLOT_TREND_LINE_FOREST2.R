# Install and load necessary packages if you haven't already
# install.packages("readxl")
# install.packages("ggplot2")
# install.packages("lubridate") # For easy date handling

library(readxl)
library(ggplot2)
library(lubridate)# This package is very useful for working with dates   readxl

# --- User Input ---
# 1. Specify the path to your Excel file
excel_file_path <- "E:/PERSONAL/Sumaya_abdoon/NDVI_TS.xlsx" # e.g., "C:/Users/YourUser/Documents/NDVI_data.xlsx"

# 2. Specify the name of the sheet containing your data
sheet_name <- "Hizam_Rhd" # e.g., "NDVI_Values"

# 3. Specify the names of the columns for Date and NDVI in your Excel file
date_column_name <- "date" # e.g., "Observation_Date"
ndvi_column_name <- "NDVI" # e.g., "NDVI_Value"

# --- Read Data from Excel ---
# Read the data from the specified Excel file and sheet
# detectDates = TRUE helps readxl to automatically recognize date columns
df <- read_excel(excel_file_path, sheet = sheet_name)#, detectDates = TRUE)

# --- Data Preparation ---
# Ensure the Date column is in a proper Date format
# If read_excel didn't detect it correctly, you might need to use a specific format
# For example, if your dates are like "YYYY-MM-DD", use:
# df[[date_column_name]] <- ymd(df[[date_column_name]])
# Or if it's "DD-MM-YYYY", use:
# df[[date_column_name]] <- dmy(df[[date_column_name]])
# The detectDates = TRUE usually handles common formats well.

# Ensure the NDVI column is numeric
df[[ndvi_column_name]] <- as.numeric(df[[ndvi_column_name]])

# Remove any rows with missing values in Date or NDVI, if necessary
df <- na.omit(df[, c(date_column_name, ndvi_column_name)])

# --- Plotting Time Series with Trend Line ---
ggplot(df, aes(x = .data[[date_column_name]], y = .data[[ndvi_column_name]])) +
  geom_line(color = "darkgreen") + # Plot the NDVI time series as a line
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed") + # Add a linear trend line
  labs(title = "NDVI Time Series with Trend Line Hizam Rhd Forest",
       x = "Date",
       y = "NDVI") +
  theme_minimal() + # Use a clean theme
  theme(plot.title = element_text(hjust = 0.5)) # Center the plot title

# --- Explanation of the Script ---
# 1.  **Install and Load Packages**: The script starts by checking for and loading
#     `readxl` (to read Excel files), `ggplot2` (for powerful and flexible plotting),
#     and `lubridate` (for easy date manipulation). If you don't have these
#     packages, uncomment and run the `install.packages()` lines.
# 2.  **User Input**: You need to modify the `excel_file_path`, `sheet_name`,
#     `date_column_name`, and `ndvi_column_name` variables to match your specific
#     Excel file and data structure.
# 3.  **Read Data**: `read_excel()` reads your data into a data frame named `df`.
#     `detectDates = TRUE` is used to automatically identify date columns.
# 4.  **Data Preparation**:
#     * It explicitly converts the NDVI column to numeric to ensure it's
#         treated as numbers for plotting and trend line calculation.
#     * `na.omit()` removes any rows where either the date or NDVI value is missing.
# 5.  **Plotting**:
#     * `ggplot(df, aes(x = .data[[date_column_name]], y = .data[[ndvi_column_name]]))`
#         initializes the plot, mapping your date column to the x-axis and NDVI to the y-axis.
#         `.data[[]]` is a safe way to refer to columns using variables.
#     * `geom_line(color = "darkgreen")` adds the time series lines.
#     * `geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed")`
#         adds a linear trend line (`method = "lm"`). `se = TRUE` adds shaded
#         confidence intervals around the trend line (you can set it to `FALSE` to remove them).
#     * `labs()` sets the title and axis labels.
#     * `theme_minimal()` provides a clean plot theme.
#     * `theme(plot.title = element_text(hjust = 0.5))` centers the plot title.

# --- How to use this script ---
# 1.  Save your Excel file with NDVI data. Make sure it has a column for dates
#     and a column for NDVI values.
# 2.  Copy this R script into your RStudio or R environment.
# 3.  Edit the `excel_file_path`, `sheet_name`, `date_column_name`, and `ndvi_column_name`
#     variables in the script to match your file and column names.
# 4.  Run the script. It will generate the plot in the RStudio Plots pane or
#     open in a new window, depending on your R environment settings.
