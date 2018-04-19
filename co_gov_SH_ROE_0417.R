cat("set nrows = -1 to import all")
source("https://raw.githubusercontent.com/wscrdzg/2018_temp/master/import_data.R") # import data

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

co_gov <- income01[which(duplicated(income01[,1]) == 0),1:2]
#daterange <- 2013:2017#c("2013S","2013X","2014S","2014X","2015S","2015X","2016S","2016X","2017S","2017X")

the_year <- 2016

# ========================== part 0 ==================================
# add 2016 shareholders data (ranking 1-5 in terms of percentage)

for (i in 1:length(co_gov[,1])) {
  co <- subset(gd01, stock_code == co_gov[i,2])
  year_range <- as.numeric(levels(factor(year(co$report_date)))) # range of years for company_i
  if (the_year %in% year_range) {
      sub1 <- subset(co, year(report_date) == the_year)
      largest <- order(sub1$report_date, decreasing = T)[1] # largest date
      sub2 <- subset(sub1, report_date == sub1$report_date[largest])
      sh_rank <- order(sub2$invest_ratio, decreasing = T) # ranking of shareholders
      
      # write year and sh into co_gov
      co_gov[i, 3] <- the_year # year
      if (length(sub2[,1]) >= 5) {
        co_gov[i,4] <- sub2[sh_rank[1],3] # sh 01
        co_gov[i,5] <- sub2[sh_rank[1],5] # sh 01 ratio
        co_gov[i,6] <- sub2[sh_rank[2],3] # sh 02
        co_gov[i,7] <- sub2[sh_rank[2],5] # sh 02 ratio
        co_gov[i,8] <- sub2[sh_rank[3],3] # sh 03
        co_gov[i,9] <- sub2[sh_rank[3],5] # sh 03 ratio
        co_gov[i,10] <- sub2[sh_rank[4],3] # sh 04
        co_gov[i,11] <- sub2[sh_rank[4],5] # sh 04 ratio
        co_gov[i,12] <- sub2[sh_rank[5],3] # sh 05
        co_gov[i,13] <- sub2[sh_rank[5],5] # sh 05 ratio
      } else {
        co_gov[i,4] <- sub2[sh_rank[1],3] # sh 01
        co_gov[i,5] <- sub2[sh_rank[1],5] # sh 01 ratio
      }
    }
  if (i %% 50 == 0) {
    cat(i)
    cat("done\n")
  }
}

# ========================== part 1 ==================================
# add 2016 financial data

for (i in 1:length(co_gov[,1])) {
  co1 <- subset(income01, stock_code == co_gov[i,2])
  co2 <- subset(bs01, stock_code == co_gov[i,2])
  
  
  time1 <- co1[which(year(co1[,3]) == the_year),3] # filter time to 2016
  l1 <- time1[order(time1, decreasing = T)][1] # order the time, choose the later one
  
  time2 <- co2[which(year(co2[,3]) == the_year),3] # filter time to 2016
  l2 <- time2[order(time2, decreasing = T)][1]
  
  if(length(time1) == 0 | length(time2) == 0) {next(paste0(i," skiped"))}
  co_gov[i,14] <- co1[which(co1[,3] == l1),4]
  co_gov[i,15] <- co2[which(co2[,3] == l2),4]
  
  cat(i)
  cat(" done\n")
}

write.xlsx(co_gov, "co_gov_results.xlsx")
