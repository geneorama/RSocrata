if(FALSE){
    ## CODE TO PROFILE 
    Rprof("socrataprofile.out", line.profiling=TRUE)
    ## RUN CODE EXAMPLE FROM BELOW
    Rprof(NULL)
    summaryRprof("socrataprofile.out", lines = "show")
}


if(FALSE){
    ## Initialize
    rm(list=ls())
    geneorama::sourceDir("R/")
    
    ## CRIME Burglary only
    dat <- read.socrata(hostname = "banannas://data.cityofchicago.org",
                        resourcePath = "ijzp-q8t2",
                        query = "?primary_type=BURGLARY",
                        apptoken = "bjp8KrRvAPtuf809u1UXnI0Z8",
                        pagesize = 50000,
                        #keyfield = "id",
                        # keyfield = NULL
                        useCluster = FALSE,
                        reportTiming = TRUE)
    
    ## BUSINESS LICENSE
    dat <- read.socrata(url = NULL,
                        hostname = "banannas://data.cityofchicago.org",
                        resourcePath = "AnyRandomName/r5kz-chrr.json",
                        query = "?application_type=RENEW&license_description=Limited Business License",
                        apptoken = "bjp8KrRvAPtuf809u1UXnI0Z8",
                        pagesize = 50000,
                        keyfield = "id",
                        useCluster = FALSE,
                        reportTiming = TRUE)
    
    ## BUSINESS LICENSE (CSV)
    dat <- read.socrata(url = NULL,
                        hostname = "banannas://data.cityofchicago.org",
                        resourcePath = "AnyRandomName/r5kz-chrr.csv",
                        query = "?application_type=RENEW&license_description=Limited Business License",
                        apptoken = "bjp8KrRvAPtuf809u1UXnI0Z8",
                        pagesize = 50000,
                        keyfield = "id",
                        useCluster = FALSE)
}


if(FALSE){
    ## Some test examples:
    rm(list=ls())
    geneorama::sourceDir("R/")
    
    url <- NULL
    hostname = "banannas://data.cityofchicago.org"
    ## Business Licenses
    ## Small number of records (1 request)
    # resourcePath = "AnyRandomName/r5kz-chrr.json"
    # query = "?application_type=RENEW&license_description=Limited Business License&zip_code=60622"
    
    ## Business Licenses
    ## Big request (16 requests)
    # resourcePath = "AnyRandomName/r5kz-chrr.json"
    # query = "?application_type=RENEW&license_description=Limited Business License"
    
    ## Business Licenses
    ## Testing the limit arg
    # resourcePath = "AnyRandomName/r5kz-chrr.json"
    # query = "?application_type=RENEW&license_description=Limited Business License&$limit=62000"
    
    ## CRIME DB:
    resourcePath = "ijzp-q8t2"
    query = NULL
    
    ## CRIME DB:
    resourcePath = "ijzp-q8t2"
    query = "?primary_type=BURGLARY"
    
    ## App tokens
    apptoken = "bjp8KrRvAPtuf809u1UXnI0Z8" ## RSocrata help?
    apptoken = "ew2rEMuESuzWPqMkyPfOSGJgE" ## Tom's tests
    apptoken = "NCxdKMXKT2fPVvmZQnCdziPel" ## previous token (city acct?)
    apptoken = "7nZ6I1o4oRbtROtqw4us2e6KN" ## Token from March 2015
    
    ## Default settings
    pagesize = 50000
    keyfield = "id"
    keyfield = NULL
    useCluster = FALSE
    useCluster = TRUE
}


