setwd("/home/vjimenez/Documentos/sars-cov-2/omicron")
dir()

install.packages("lubridate")
library(lubridate)

#read data#
data <- read.csv("metadata.csv", header=TRUE)
dim(data)
names(data)

#check data#
data[1:5,]
data2 <- data.frame(data, n=rep(1,dim(data)[1]),week=epiweek(ymd(data$date)),year=year(ymd(data$date)),month=month(ymd(data$date)),month_name=month(ymd(data$date),label=TRUE))
data2[1:5,]
names(data2)
dim(data2)
unique(data2$week)

#check numbers#
sm <- aggregate(data2$n, by=list(data2$week, data2$region, data2$country), FUN=sum)
names(sm) <- c("week","continent","country","freq")
sm
sm[order(sm$week,sm$country,sm$freq),]

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

#extract to metadata#
tab <- data2[data$gisaid_epi_isl %in% dau2, ]
dim(tab)
names(tab)

#generate the list#
#write.csv(tab$gisaid_epi_isl, file="selected_list.csv", row.names=FALSE)#
#write.csv(tab, file="short_tab.csv", row.names=FALSE)#

new <- aggregate(tab$n, by=list(tab$week, tab$region, tab$country), FUN=sum)
names(new) <- c("week","continent","country","freq")
new
new[order(new$week,new$country,new$freq),]




