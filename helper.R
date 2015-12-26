library(tm)
library(wordcloud)
library(memoise)


# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(text) {
        
        myCorpus = Corpus(VectorSource(text))
        myCorpus = tm_map(myCorpus, content_transformer(tolower))
        myCorpus = tm_map(myCorpus, removePunctuation)
        myCorpus = tm_map(myCorpus, removeNumbers)
        myCorpus = tm_map(myCorpus, removeWords,
                          c(stopwords("SMART"), "div", "html", "img", "script", "meta", 
                            "javascript", "function", "var", "document", "undefined", "cookies", "and", "window"))
        
        myDTM = TermDocumentMatrix(myCorpus,
                                   control = list(minWordLength = 1))
        
        m = as.matrix(myDTM)
        
        sort(rowSums(m), decreasing = TRUE)
})

cleanFun <- function(htmlString) {
        return(gsub("<.*?>", "", htmlString))
}