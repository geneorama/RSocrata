if(FALSE){
    ## Initialize
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
    reportTiming = TRUE
    
    Rprof("socrataprofile.out", line.profiling=TRUE)
    source("socrataprofile.R")
    Rprof(NULL)
    summaryRprof("socrataprofile.out", lines = "show")
    
}

##--------------------------------------------------------------------------
## Construct urlParsed from user input
##--------------------------------------------------------------------------
## If a URL is provided, then parse the URL
## Otherwise, validate and construct a parsed URL from the components
if(!is.null(url)){
    urlParsed <- httr::parse_url(url)
    ## Standardize the path component
    urlParsed$path <- getResourcePath(urlParsed$path)
} else {
    ## Validate and extract components, and build httr url object
    urlParsed <- getUrl(hostname, resourcePath, query)
}
## Insert token into query part of url
urlParsed$query <- insertToken(urlParsed$query, apptoken, urlParsed)
## Get the mimeType from the input
mimeType <- getResourcePath(urlParsed$path)$mimeType
## Check url for minimum completeness
validateUrl(urlParsed)

##--------------------------------------------------------------------------
## Set up for request pagnation
##--------------------------------------------------------------------------
## Get row count and calculate number of pages
totalRows <- getQueryRowCount(urlParsed, mimeType)
## Calculate total requests    
totalRequests <- trunc(totalRows / pagesize) + 1
## Rely on constructed limit argument, so remove any previous limit
## specification from query (it's interger(0) if no limit arg present)
limitArg <- grep("\\$limit", names(urlParsed$query), ignore.case = TRUE)
if(length(limitArg) > 0){
    urlParsed$query[[limitArg]] <- NULL
}
## Get column names from the views resource path
colNames <- getColumnNames(urlParsed, mimeType)
## Compose the base url to be used for requests, before adding pageing info
urlBase <- httr::build_url(urlParsed)
if(totalRequests > 1){
    ## Get "urlFinal" which is actually several URLs that have the 
    ## $offset, $limit, and $order arguments embedded
    urlFinal <- getPagedQueries(urlBase, totalRows, pagesize, colNames, 
                                keyfield, totalRequests)
} else {
    urlFinal <- urlBase
}
## Download data, in parallel if requested
if(useCluster){
    require(parallel)
    cl <- makeCluster(detectCores())
    resultRaw <- parLapply(cl, urlFinal, httr::GET)
    stopCluster(cl)
} else {
    # resultRaw <- lapply(urlFinal, httr::GET)
    resultRaw <- list()
    for(u in urlFinal){
        resultRaw[[u]] <- httr::GET(u)
    }
}
## Temp code for loading intermediate results
# saveRDS(resultRaw, "resultRaw.Rds")
# resultRaw <- loadRDS("resultRaw.Rds")

## Extract content
resultContent <- lapply(resultRaw, httr::content)
## Merge extracted content
resultContent <- do.call(c, resultContent)

# resultContent[[1]]
# MasterNames <- unique(names(unlist(dat, recursive = T)))
# MasterNames
# 
# 
# ## Put results into matrix table form
# if(mimeType == "json"){
#     resultContent <- unlistByName(resultContent)
# } else {
#     resultContent <- do.call(rbind, resultContent)
# }
# result <- data.frame(resultContent, stringsAsFactors = FALSE)
# ## Reorder according to column names (put extra columns at end)
# colNamesMatched <- colnames(result)[colnames(result) %in% colNames]
# colNamesNotMatched <- colnames(result)[!colnames(result) %in% colNames]
# colNamesOrdered <- colNamesMatched[match(colNames, colNamesMatched)]
# colNamesOrdered <- colNamesOrdered[!is.na(colNamesOrdered)]
# colNamesResult <- c(colNamesOrdered, colNamesNotMatched)
# result <- result[, colNamesResult]
# 
# ## Convert data types for result
# columnDataTypes <- getColumnDataTypes(urlParsed)
# numberColumns <- colNames[which(columnDataTypes == "number")]
# dateColumns <- colNames[which(columnDataTypes == "calendar_date")]
# for(j in numberColumns[numberColumns %in% colnames(result)]){
#     result[,j] <- as.numeric(result[,j])
# }
# for(j in dateColumns[dateColumns %in% colnames(result)]){
#     result[,j] <- as.POSIXct(result[,j])
# }
