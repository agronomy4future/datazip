<!-- README.md is generated from README.Rmd. Please edit that file -->

# datazip

<!-- badges: start -->
<!-- badges: end -->

The goal of the datazip package is to simply convert data into code with a single line, making it easy to save as a script.

□ Code summary: https://github.com/agronomy4future/r_code/blob/main/Convert_Data_into_Code_Instantly_Save_as_a_Script_with_One_Line.ipynb

□ Code explained: https://agronomy4future.com/archives/23854

## Installation

You can install the development version of interpolate like so:

Before installing, please download Rtools (https://cran.r-project.org/bin/windows/Rtools)

``` r
if(!require(remotes)) install.packages("remotes")
if (!requireNamespace("datazip", quietly = TRUE)) {
   remotes::install_github("agronomy4future/datazip", force= TRUE)
}
library(remotes)
library(datazip)
```

## Example

This is a basic code to convert data to code

``` r
# to convert data to code and output in R script
datazip(df)

# to save the code as .r file in my PC
datazip(df, output=output="df1_output.r")

# to save the code as .rds df2 in my PC
datazip(df, output=output="dataB_output.rds")

# to import the code to R
df_loaded_r= dataunzip("df1.r")
df_loaded_rds= dataunzip("df2.rds")

print(df_loaded_r)
print(df_loaded_rds)
```

## Let’s practice with actual dataset

``` r
# to uplaod data
if(!require(readr)) install.packages("readr")
library(readr)

github= "https://raw.githubusercontent.com/agronomy4future/raw_data_practice/main/fertilizer_treatment.csv"
dataA= data.frame(read_csv(url(github),show_col_types = FALSE))

print(head(dataA,5))
    Genotype Block variable value
1 Genotype_A     I  Control  42.9
2 Genotype_A    II  Control  41.6
3 Genotype_A   III  Control  28.9
4 Genotype_A    IV  Control  30.8
5 Genotype_B     I  Control  53.3
.
.
.

# to convert data to code and output in R script
datazip(df)
structure(list(Genotype=c("Genotype_A","Genotype_A","Genotype_A","Genotype_A","Genotype_B","Genotype_B","Genotype_B......

# to convert BigData to code and output in R script
if(!require(readr)) install.packages("readr")
library(readr)

github="https://raw.githubusercontent.com/agronomy4future/raw_data_practice/main/wheat_grains_data_training.csv"
dataA=data.frame(read_csv(url(github),show_col_types= FALSE))

print(tail(dataA,5))
      Field Genotype Block fungicide planting_date fertilizer   Shoot Length.mm. Width.mm.
96315 South    Peele   III        No         early        N/A Tillers      5.951     2.987
96316 South    Peele   III        No         early        N/A Tillers      5.614     2.687
96317 South    Peele   III        No         early        N/A Tillers      5.674     2.210
96318 South    Peele    II        No          late        N/A Tillers      6.041     2.138
96319 South    Peele    II        No          late        N/A Tillers      6.041     2.138
      Area.mm2.
96315    13.687
96316    11.058
96317     9.154
96318    18.092
96319    18.092

# using datazip(dataA) is no practical benefit to saving such a large code block in your R script. In this case, a better approach is to export the code to R file instead.

setwd("C:/Users/Desktop") # set up the pathway to save the file

datazip(dataA, output="dataA_output.r") # to save the code as .r file

df_loaded_r= dataunzip("dataA_output.r") # to import .r file to R as data frame

print(tail(df_loaded_r, 5))
```
