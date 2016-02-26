geneorama::loadinstall_libraries("RSocrata")
devtools::install_github("chicago/RSocrata")

url <- "http://data.cityofchicago.org/resource/4ijn-s7e5.json?$limit=100"
test <- read.socrata(url)
str(test)

url <- "http://soda.demo.socrata.com/resource/4334-bgaj.json?$limit=10"
url <- "http://soda.demo.socrata.com/resource/4334-bgaj.json"
earthquakesDataFrame <- read.socrata(url)
nrow(earthquakesDataFrame) # 1007 (two "pages")
str(earthquakesDataFrame)
class(earthquakesDataFrame$datetime[1]) # POSIXlt

head(read.socrata("http://soda.demo.socrata.com/resource/4334-bgaj.json"))
head(read.socrata("http://soda.demo.socrata.com/resource/4334-bgaj.csv"))

earthquakesDataFrame <- read.socrata("https://soda.demo.socrata.com/dataset/USGS-Earthquakes-for-2012-11-01-API-School-Demo/4334-bgaj")
earthquakesDataFrame <- read.socrata("https://soda.demo.socrata.com/dataset/USGS-Earthquakes-for-2012-11-01-API-School-Demo/4334-bgaj.json")
nrow(earthquakesDataFrame)
class(earthquakesDataFrame$Datetime[1]) # POSIXlt

