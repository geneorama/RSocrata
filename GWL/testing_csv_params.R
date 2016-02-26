rm(list=ls())
geneorama::sourceDir("R/")

url = NULL
hostname = "banannas://data.cityofchicago.org"
resourcePath = "AnyRandomName/r5kz-chrr.csv"
query = "?application_type=RENEW&license_description=Limited Business License"
apptoken = "bjp8KrRvAPtuf809u1UXnI0Z8"
pagesize = 50000
keyfield = "id"
useCluster = FALSE

