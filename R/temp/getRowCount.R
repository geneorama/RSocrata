
getRowCount <- function(valid_url, params){
    
    ## Compose count query
    query_count <- paste(valid_url, 
                         query, 
                         "$SELECT=COUNT(*)", 
                         sep="&")
    
    ## Remove doubled && in the event of a NULL query
    query_count <- gsub("&&", "&", query_count)
    
    ## Execute query and extract just the "count"
    total_rows <- read.table(query_count, 
                             header = TRUE)[ , 'count']
    
    ## Return results
    return(total_rows)
}

