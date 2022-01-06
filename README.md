# VicRCodes 

This code was designed by Victor Jimenez Vasquez - vr.jimenez.vs@gmail.com 
"subset_covid" allows you to generate a subset of an original  metadata dowloaded from GISAID (https://www.gisaid.org/) based on epidemiological week and country. "subset_covid" extract a percentage of genomes above a minimum frequency threshold for every country included in your data. 

## Usage 
```r

# "subset_covid" requires lubridate R library #
install.packages("lubridate")
library(lubridate)

# read metadata, in this example we have two metadata files dowloaded from GISAID #
a <- read.csv("metadata_1.tsv", header=TRUE, sep="\t")
b <- read.csv("metadata_2.tsv", header=TRUE, sep="\t")
data <- rbind(a,b)

# run "subset_covid" #
res <- subset_covid(data=data,minfreq=5,proportion=0.1,year=2021,label="omicron_22")
res

# "subset_covid" arguments #
- data = metadata prepared from GISAID
- minfreq = minimum genome frequency threshold. Indicates the maximum number of genomes sampled in a given country by epidemiological week that will not be afected by a proportional extraction. For example, if we set this value to 5, imagine Peru has only 5 genomes in the epidemogical week number 40, thus the 100% of genomes (5) will be considered in the subset, but in the alternative case that Peru has more than 5 genomes thus only a specified percentage (proportion argument) of this genomes will be randomly sampled. 
- proportion = proportion of samples to extract if the number of genomes by a given country in a given epidemiological week exceds the minimum genome frequency threshold (minfreq). For example, if Peru contains 100 genomes in the epidemiological week number 40 and if we set this value to 0.1, thus 10 genomes will be randomly sampled.  
- year = the year of interest 
- label = a name to inclued in the output files. For example "delta", "omicron_2022". 

## Output 
"subset_covid" will generate a list of files in csv format indicating dataframes 
original_frequencies_omicron_22.csv
filtered_frequencies_omicron_22.csv
filtered_table_omicron_22.csv
gisaid_epi_isl_omicron_22.csv


```

