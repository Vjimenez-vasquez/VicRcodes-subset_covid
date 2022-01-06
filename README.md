# VicRCodes 

This code was designed by Victor Jimenez Vasquez - vr.jimenez.vs@gmail.com 
"subset_covid" allows you to generate a subset of an original  metadata dowloaded from GISAID (https://www.gisaid.org/) based on epidemiological week and country. "subset_covid" extract a percentage of genomes above a minimum frequency threshold for every country included in your data. 

## Usage 

```r
#prepare the function to select#
dat <- data.frame()
dav <- 0
dau <- c()
for(i in 1:length(cont)) {
    for(j in 1:52) {
dat <- data2[data2$country == cont[i] & data2$week == j,]
dav <- dim(dat)[1]
samp <- ifelse(dav < 5, dav,0.10*dav)
dau <- append(dau,sample(dat$gisaid_epi_isl,round(samp), replace=FALSE))
    }
}
length(dau)
dau2 <- na.omit(dau)
length(dau2)
```
