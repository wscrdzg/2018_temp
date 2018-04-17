source("https://raw.githubusercontent.com/wscrdzg/r_toolbox/master/createxlsx.R") # include openxlsx

loc = as.character(readline(prompt = "Enter file loc: "))
num_of_row = as.numeric(readline(prompt = "Enter number of rows: "))

  # import files
  basic <- read.csv(paste0(loc,"基本信息qyxg_jqka_ipo_basic_20180320"), nrows = num_of_row, header = F)
  print("basic imported successful")
  gdxx <- read.csv(paste0(loc,"股东信息qyxg_jqka_ipo_gdxx_20180320"), nrows = num_of_row, header = F)
  print("gdxx imported successful")
  income <- read.csv(paste0(loc,"财务指标利润表qyxg_jqka_cwzb_zhsy_20180320"), nrows = num_of_row, header = F)
  print("income imported successful")
  cash <- read.csv(paste0(loc,"财务指标现金流量qyxg_jqka_cwzb_xjll_20180320"), nrows = num_of_row, header = F)
  print("cash imported successful")
  bs <- read.csv(paste0(loc,"财务指标资产负债qyxg_jqka_cwzb_zcfz_20180320"), nrows = num_of_row, header = F)
  print("bs imported successful")
  invest <- read.csv(paste0(loc,"投资信息.csv"), nrows = num_of_row, header = T)
  print("invest imported successful")
  
  # import column names
  colnames(basic) <- colnames(read.xlsx(paste0(loc,"新三板工商数据样例.xlsx"),sheet = 1))
  colnames(gdxx) <- colnames(read.xlsx(paste0(loc,"新三板工商数据样例.xlsx"),sheet = 2))
  colnames(income) <- colnames(read.xlsx(paste0(loc,"新三板工商数据样例.xlsx"),sheet = 3))
  colnames(cash) <- colnames(read.xlsx(paste0(loc,"新三板工商数据样例.xlsx"),sheet = 4))
  colnames(bs) <- colnames(read.xlsx(paste0(loc,"新三板工商数据样例.xlsx"),sheet = 5))