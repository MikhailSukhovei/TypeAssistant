library(shiny)

shinyUI(fluidPage(

    theme = "bootstrap.css",
    fluidRow(column(
        8,
        align="center",
        offset = 2,
        textInput("user_input", label = "", value = "", width = "100%"),
        tags$style(
            type = "text/css",
            "#user_input {
                height: 50px;
                width: 100%;
                text-align:center;
                font-size: 30px;
                display: block;
            }"
        )
            
    )),
    fluidRow(column(
        8,
        align="center",
        offset = 2,
        actionButton("button1", label = ""),
        actionButton("button2", label = ""),
        actionButton("button3", label = ""),
        tags$style(
            type = 'text/css',
            "#button1 {
                vertical-align: middle;
                height: 50px;
                width: 30%;
                font-size: 30px;
            }",
            "#button2 {
                vertical-align: middle;
                height: 50px;
                width: 30%;
                font-size: 30px;
            }",
            "#button3 {
                vertical-align: middle;
                height: 50px;
                width: 30%;
                font-size: 30px;
            }"
        )
    ))
))
