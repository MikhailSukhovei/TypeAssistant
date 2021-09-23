library(shiny)

source("algorithm.R")
source("utils.R")

shinyServer(function(input, output, session) {
    load(file = "unigrams.Rdata")
    load(file = "bigrams.Rdata")
    load(file = "trigrams.Rdata")
    load(file = "tetragrams.Rdata")
    load(file = "pentagrams.Rdata")
    
    first <- reactiveValues(value = "")
    second <- reactiveValues(value = "")
    third <- reactiveValues(value = "")
    
    observeEvent(input$user_input, {
        tokens <- clean_and_tokenize(input$user_input)
        pred <- KBO_predict(
            tokens[[1]],
            list(unigrams, bigrams, trigrams, tetragrams, pentagrams),
            pred_num = 3
        )
        
        first$value <- pred$pred[1]
        second$value <- pred$pred[2]
        third$value <- pred$pred[3]
        str <- trimws(input$user_input)
        if ((str == "") | (substr(str, nchar(str), nchar(str))) == ".") {
            substr(first$value, 1, 1) <- toupper(substr(first$value, 1, 1))
            substr(second$value, 1, 1) <- toupper(substr(second$value, 1, 1))
            substr(third$value, 1, 1) <- toupper(substr(third$value, 1, 1))
        }
        
        updateActionButton(session, "button1", label = first$value)
        updateActionButton(session, "button2", label = second$value)
        updateActionButton(session, "button3", label = third$value)
    })
    
    observeEvent(input$button1, {
        updateTextInput(
            session,
            "user_input",
            value = paste(input$user_input, first$value)
        )
    })
    
    observeEvent(input$button2, {
        updateTextInput(
            session,
            "user_input",
            value = paste(input$user_input, second$value)
        )
    })
    
    observeEvent(input$button3, {
        updateTextInput(
            session,
            "user_input",
            value = paste(input$user_input, third$value)
        )
    })
})
