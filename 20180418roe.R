cat("set nrows = -1 to import all")
# import data
source("https://raw.githubusercontent.com/wscrdzg/2018_temp/master/import_data.R")

require(openxlsx)
co_gov <- read.xlsx("https://raw.githubusercontent.com/wscrdzg/invest_net_2018/master/20180417co_gov_results.xlsx?token=ATmelxHX_CgO0_WJ3EqkBKsXQGFxCJq-ks5a3vsVwA%3D%3D")

require(lubridate)
#match(c("company_name","stock_code","report_date","total_multi_income","total_revenue"), names(income))
income01 <- income[,c(16,31,10,5,7)]
income01$report_date <- ymd(income01$report_date)

#match(c("company_name","stock_code", "shareholder_name", "report_date","invest_ratio"), names(gdxx))
gd01 <- gdxx[,c(11,4,5,9,10)]
gd01$report_date <- ymd(gd01$report_date)

# match(c("company_name","stock_code","report_date","total_shareholders_equity"), names(bs))
bs01 <- bs[,c(35, 56, 12, 19)]
bs01$report_date <- ymd(bs01$report_date)

the_year <- 2016


for (i in 1:length(co_gov[,1])) {
  co1 <- subset(income01, stock_code == co_gov[i,2])
  co2 <- subset(bs01, stock_code == co_gov[i,2])
  
  time <- co1[which(year(co1[,3]) == the_year),3] # filter time to 2016
  l <- time[order(time, decreasing = T)][1] # order the time, choose the later one
  co_gov[i,14] <- co1[which(co1[,3] == l),4]
  
  time <- co2[which(year(co2[,3]) == the_year),3] # filter time to 2016
  l <- time[order(time, decreasing = T)][1]
  co_gov[i,15] <- co2[which(co2[,3] == l),4]
}