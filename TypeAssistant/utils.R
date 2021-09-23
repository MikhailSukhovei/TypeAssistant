library(qdap)
library(quanteda)

clean_and_tokenize <- function(texts) {
    texts <- gsub("’", "'", texts)
    texts <- replace_contraction(
        texts,
        contraction = qdapDictionaries::contractions,
        replace = NULL,
        ignore.case = TRUE,
        sent.cap = TRUE
    )
    texts <- replace_symbol(
        texts,
        dollar = TRUE,
        percent = TRUE,
        pound = TRUE,
        at = TRUE,
        and = TRUE,
        with = TRUE
    )
    #texts <- replace_number(texts)
    texts <- gsub("'", "", texts)
    
    toks <- tokens(
        texts,
        what = "word",
        remove_punct = TRUE,
        remove_symbols = TRUE,
        remove_numbers = TRUE,
        remove_url = TRUE,
        remove_separators = TRUE,
        split_hyphens = TRUE,
        padding = FALSE
    )
    toks <- tokens_tolower(toks)
    toks <- tokens_select(
        toks,
        c("[^A-Za-z]+"),
        selection = "remove",
        valuetype = "regex"
    )
    
    return(toks)
}