#install.packages("lubridate")#
library(lubridate)

subset_covid <- function(data,minfreq,proportion,year,label) {
data = data
minfreq = minfreq
year = year
label = label
proportion = proportion

#add newcolumns (epidemiomogical week,year,month number and month name)#
data2 <- data.frame(data, n=rep(1,dim(data)[1]),week=epiweek(ymd(data$date)),year=year(ymd(data$date)),
month=month(ymd(data$date)),month_name=month(ymd(data$date),label=TRUE)) 

#estimate a list of countries#
cont <- unique(data2$country)

#construct tables#
sm <- aggregate(data2$n, by=list(data2$year,data2$week, data2$region, data2$country), FUN=sum)
names(sm) <- c("year","week","continent","country","freq")
sm2 <- sm[order(sm$year,sm$week,sm$continent,sm$country,sm$freq),]
write.csv(sm2, file=paste0("original_frequencies_",label,".csv"),row.names=FALSE)

#selection function#
dat <- data.frame()
dav <- 0
dau <- c()
for(i in 1:length(cont)) {
    for(j in 1:52) {
dat <- data2[data2$country == cont[i] & data2$week == j & data2$year == year,]
dav <- dim(dat)[1]
samp <- ifelse(dav < minfreq, dav,proportion*dav)
dau <- append(dau,sample(dat$gisaid_epi_isl,round(samp), replace=FALSE))
    }
}
length(dau)
dau2 <- na.omit(dau)
length(dau2)

#extract to metadata#
tab <- data2[data2$gisaid_epi_isl %in% dau2, ]
dim(tab)

#generate the list#
write.csv(tab$gisaid_epi_isl, file = paste0("gisaid_epi_isl_",label,".csv"), row.names=FALSE)
write.csv(tab, file = paste0("filtered_table_",label,".csv"), row.names=FALSE)

new <- aggregate(tab$n, by=list(tab$year,tab$week, tab$region, tab$country), FUN=sum)
names(new) <- c("year","week","continent","country","freq")
new2 <- new[order(new$year,new$week,new$continent,new$country,new$freq),]
write.csv(new2, file=paste0("filtered_frequencies_",label,".csv"),row.names=FALSE)

print(dim(data2))
print(dim(tab))

}

#examples#

#res <- subset_covid(data=data,minfreq=4,proportion=0.05,year=2021,label="omicron3")#
#res#
