library(shiny)
source("global.R")
server <- function(input, output, session) {
  
  # example_data in global 
  
  # Simple reactable - see: styles.css for formatting
  output$myreactable <- renderReactable({
    reactable(test[test$WALLET_TYPE %in% input$Wallet_Types,c('WALLET_TYPE', 'ADDRESS', 
                                                         'PROJECT_NAME', 'ADDRESS_NAME', 
                                                         'SYMBOL', 'TOKEN_NAME', 'TOKEN_BALANCE', 
                                                         'USD_VALUE')],
              groupBy = c("ADDRESS"),
              columns = list(
                USD_VALUE = colDef(name='USD Value', aggregate = "sum", 
                                   format = colFormat(prefix = "$", separators = TRUE, digits = 0),
                                   defaultSortOrder = "desc"),
                ADDRESS = colDef(name = 'Address', 
                  #                cell = function(value, index) {
                  # # Render as a link
                  # url <- sprintf("https://etherscan.io/address/%s", test[index, "ADDRESS"], value)
                  # htmltools::tags$a(href = url, target = "_blank", as.character(value))
                  # }
                  html = TRUE,
                  cell = JS('
                  function(cellInfo) {
                    // Render as a link
                    const url = `https://etherscan.io/address/${cellInfo.row["ADDRESS"]}`
                    return `<a href="${url}" target="_blank">${cellInfo.value}</a>`
                  }
                  ')
                ),
                PROJECT_NAME = colDef(name = 'Project Name', aggregate = "unique"),
                WALLET_TYPE = colDef(name = 'Wallet Type', aggregate = "unique"),
                ADDRESS_NAME = colDef(name = 'Address Name', aggregate = "unique"),
                TOKEN_BALANCE = colDef(name='Token Balance', format = colFormat(separators = TRUE, digits = 0))
                
                ),
              borderless = FALSE,
              outlined = FALSE,
              highlight = TRUE, 
              defaultSorted = c("USD_VALUE")
                )
  })
  
  output$mytable = DT::renderDataTable({
    test
  })
  

  
}