library(shiny)
source("global.R")

csvDownloadButton <- function(id, filename = "data.csv", label = "Download as CSV") {
  tags$button(
    tagList(icon("download"), label),
    onclick = sprintf("Reactable.downloadDataCSV('%s', '%s')", id, filename)
  )
}

server <- function(input, output, session) {
  
  # example_data in global 
  
  # Simple reactable - see: styles.css for formatting
  output$myreactable <- renderReactable({
    data = test[test$WALLET_TYPE %in% input$Wallet_Types,c('ADDRESS_FIX', 'WALLET_TYPE', 
                                                           'PROJECT_NAME', 'ADDRESS_NAME', 
                                                           'USD_VALUE','ADDRESS')]
    data = aggregate(USD_VALUE ~ ., data, sum)
    
    reactable(data,
              columns = list(
                USD_VALUE = colDef(name='USD Value',
                                   format = colFormat(prefix = "$", separators = TRUE, digits = 0),
                                   defaultSortOrder = "desc"),
                ADDRESS_FIX = colDef(name = 'Address',
                  html = TRUE,
                  cell = JS('
                  function(cellInfo) {
                    // Render as a link
                    const url = `https://etherscan.io/address/${cellInfo.row["ADDRESS"]}`
                    return `<a href="${url}" target="_blank" ><u>${cellInfo.value}</u></a>`
                  }
                  '),
                ),
                PROJECT_NAME = colDef(name = 'Project Name'),
                WALLET_TYPE = colDef(name = 'Wallet Type'),
                ADDRESS_NAME = colDef(name = 'Address Name'),
                ADDRESS = colDef(show = F)
                ),
              borderless = TRUE,
              outlined = FALSE,
              highlight = TRUE,
              resizable = TRUE,
              searchable = TRUE, 
              defaultPageSize = 25,
              showPageSizeOptions = TRUE,
              pageSizeOptions = c(25, 50, 100),
              defaultSorted = c("USD_VALUE"),
              details = function(index) {
                token_data <- test[test$ADDRESS == data$ADDRESS[index], c('ADDRESS_NAME', 'SYMBOL', 'TOKEN_NAME', 'TOKEN_BALANCE', 'USD_VALUE')]
                htmltools::div(
                               reactable(token_data, 
                                         columns = list(
                                           USD_VALUE = colDef(name='USD Value', 
                                                             format = colFormat(prefix = "$", separators = TRUE, digits = 0),
                                                             defaultSortOrder = "desc"),
                                           TOKEN_BALANCE = colDef(name='Token Balance', format = colFormat(separators = TRUE, digits = 0)),
                                           SYMBOL = colDef(name='Symbol'),
                                           ADDRESS_NAME = colDef(name='Address Name'),
                                           TOKEN_NAME = colDef(name='Token Name')
                                         ),
                                         outlined = TRUE,
                                         borderless = FALSE,
                                         highlight = TRUE,
                                         resizable = TRUE,
                                         defaultSorted = c("USD_VALUE"),)
                )
              }
                )
  })
  
  output$mytable = DT::renderDataTable({
    test
  })
  

  
}