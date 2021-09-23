library(data.table)

KBO_step <- function(pBO, npre, Cn_plus_1, disc = 0.5) {
    left_parts <- gsub("_[a-z]+$", "", Cn_plus_1$ngram, perl = TRUE)
    
    C_A <- Cn_plus_1[left_parts == npre, ]
    P_obs <- data.table(ngram = C_A$ngram, prob = (C_A$freq - disc) / sum(C_A$freq))
    
    alpha <- 1 - sum(P_obs$prob)
    P_unobs <- data.table(
        ngram = pBO$ngram,
        prob = alpha * pBO$prob
    )
    
    pBO_new <- rbind(P_obs, P_unobs)
    
    return(pBO_new[order(-pBO_new$prob), ])
}

KBO_predict <- function(toks, ngrams, pred_num = 5) {
    pBO <- data.table(
        ngram = ngrams[[1]]$ngram,
        prob = ngrams[[1]]$freq / sum(ngrams[[1]]$freq)
    )
    pBO <- pBO[order(-pBO$prob), ]
    
    if (length(toks) == 0) {
        pred <- head(pBO, pred_num)
        pred$pred <- gsub(".+_", "", pred$ngram)
        return(pred)
    } else {
        steps_num <- min(c(length(toks) + 1, length(ngrams)))
        for (i in 1:(steps_num - 1)) {
            ngrampre <- paste(
                toks[(length(toks) - i + 1):length(toks)],
                collapse = "_"
            )
            pBO <- KBO_step(pBO, ngrampre, ngrams[[i + 1]])
        }
        
        pBO$pred <- gsub(".+_", "", pBO$ngram)
        pBO <- pBO[, sum(prob), by = pred]
        names(pBO) <- c("pred", "prob")
        pBO <- pBO[order(-pBO$prob), ]
        return(head(pBO, pred_num))
    }
}