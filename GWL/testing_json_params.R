

rm(list=ls())
geneorama::sourceDir("R/")

url = NULL
hostname = "banannas://data.cityofchicago.org"
resourcePath = "AnyRandomName/r5kz-chrr.json"
query = "?application_type=RENEW&license_description=Limited Business License"
apptoken = "bjp8KrRvAPtuf809u1UXnI0Z8"
pagesize = 50000
keyfield = "id"
useCluster = FALSE

### VIEW DATA
system.time(viewdata <- httr::content(httr::GET("https://data.cityofchicago.org/views/r5kz-chrr.json")))
viewdata
str(viewdata,1)
str(viewdata[["columns"]][[1]])
coldata <- viewdata[["columns"]]
for(i in 1:length(coldata)){coldata[[i]][["cachedContents"]] <- NULL}
coldata
# geneorama::clipper(unlist(sapply(coldata, `[`, "dataTypeName")))

df <- data.frame(id=unlist(sapply(coldata, `[`, "id")),
                 name=unlist(sapply(coldata, `[`, "name")),
                 dataTypeName=unlist(sapply(coldata, `[`, "dataTypeName")),
                 fieldName=unlist(sapply(coldata, `[`, "fieldName")),
                 position=unlist(sapply(coldata, `[`, "position")),
                 renderTypeName=unlist(sapply(coldata, `[`, "renderTypeName")),
                 tableColumnId=unlist(sapply(coldata, `[`, "tableColumnId")),
                 width=unlist(sapply(coldata, `[`, "width")))
geneorama::clipper(df)


## JSON RESULTS FOR 5 ROWS
system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.json?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=5&$order=id"))
res
## HEADER INFO
httr::headers(res)
## COLUMN NAMES ACCORDING TO HEADER
soda2Headers <- jsonlite::fromJSON(httr::headers(res)[["x-soda2-fields"]])
soda2Headers
## COLUMN TYPES ACCORDING TO HEADER
soda2Types <- jsonlite::fromJSON(httr::headers(res)[["x-soda2-types"]])
soda2Types
## CSV RESULTS FOR 1 ROW
system.time(print(colnames(httr::content(httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.csv?%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=1")))))






colnames(
    jsonlite::flatten(
        jsonlite::fromJSON(
            httr::content(res)
        )
    )
)
colnames(
    jsonlite::flatten(recursive = FALSE,
        as.data.frame(
            httr::content(res)
        )
    )
)

## SPEED TEST
system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.csv?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=5000&$order=id"))
system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.json?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=5000&$order=id"))

system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.csv?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=5000&$order=id&$offset=1"))
system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.json?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=5000&$order=id&$offset=1"))

system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.csv?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=5000&$order=id&$offset=9000"))
system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.json?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=5000&$order=id&$offset=9000"))

system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.csv?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=50000&$order=id&$offset=90000"))
system.time(res <- httr::GET("https://data.cityofchicago.org/resource/r5kz-chrr.json?application%5Ftype=RENEW&license%5Fdescription=Limited%20Business%20License&%24%24app%5Ftoken=bjp8KrRvAPtuf809u1UXnI0Z8&$limit=50000&$order=id&$offset=90000"))

str(httr::content(res), 0)



