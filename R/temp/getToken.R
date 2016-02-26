

insertToken <- function(query, 
                        apptoken, 
                        url) {
    
    if(!is.null(apptoken)){
        ##----------------------------------------------------------------------
        ## Handle the insertion of the API token into the query, if it exists
        ##----------------------------------------------------------------------
        ## Convert to character, just in case
        apptoken <- as.character(apptoken)
        
        if(is.null(query[['app_token']] && !is.null(apptoken))) { 
            ## The user supplied an apptoken only through apptoken, so add
            ## apptoken to the query
            query[['app_token']] <- as.character(paste0("%24%24app_token=", 
                                                        app_token))
        } else {
            ## The user supplied apptoken, there was already one in the query 
            ## and they don't match.
            if(query[['app_token']] != app_token){
                msg <- paste0("url = ", url, "\n",
                              "The supplied url has an API token embedded in ",
                              "the url, and one was also supplied, and they ", 
                              "don't match..\n",
                              "Ignoring apptoken.")
                warning(msg)
            }
        }
    }
    return(query)
}