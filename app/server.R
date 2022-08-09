library(shiny)
source("global.R")
server <- function(input, output, session) {
  
  # example_data in global 
  
  # Example SCATTERPLOT
  output$exscatter <- renderPlotly({
    plot_ly(data = example_data,
            x = ~x,
            y = ~y,
            color = ~a,
            size = ~z,
            text = ~paste("Y: ", y,
                          '<br>Size:', z,
                          '<br>Color:', a)
            ) %>% 
            layout(title = "",
                   yaxis = list(title = "Y Label", 
                                showgrid = FALSE,
                                color = "#FFF"), 
                   xaxis = list(title = "X Label",
                                showgrid = TRUE,
                                color = "#FFF",
                                gridcolor = "#202933"),
                   plot_bgcolor = "transparent", 
                   paper_bgcolor = "transparent",
                   legend = list(font = list(color = '#FFFFFF'))) %>%
      # variety of useful config options to be aware of
      # https://plotly.com/r/configuration-options/
              config(scrollZoom = FALSE,
                     # displayModeBar = TRUE, # default is hover
                     toImageButtonOptions = list(format= 'svg', # one of png, svg, jpeg, webp
                                                 filename= 'template_image',
                                                 height= 500,
                                                 width= 700,
                                                 scale= 1),
                     displaylogo = FALSE
              )
                     
    
  })
  
  # Example BARPLOT 
  # more details - https://plotly.com/r/bar-charts/
  output$exbar <- renderPlotly({
    
    ed <- example_data %>% 
      group_by(a, z, .add = TRUE) %>% 
      summarize(n = n())
    
    plot_ly(data = ed,
            x = ~as.character(a),
            y = ~n,
            color = ~as.factor(z),
            text = ~paste("Letter: ", a,
                          '<br>Category:', z,
                          '<br>Number:', n)
    ) %>% 
      layout(title = "",
             yaxis = list(title = "Y Label", 
                          showgrid = FALSE,
                          color = "#FFF"), 
             xaxis = list(title = "X Label",
                          showticklabels = TRUE,
                          color = "#FFF",
                          gridcolor = "#202933"),
             plot_bgcolor = "transparent", 
             paper_bgcolor = "transparent",
             legend = list(font = list(color = '#FFFFFF'))) %>%
      # variety of useful config options to be aware of
      # https://plotly.com/r/configuration-options/
      config(scrollZoom = FALSE,
             # displayModeBar = TRUE, # default is hover
             toImageButtonOptions = list(format= 'svg', # one of png, svg, jpeg, webp
                                         filename= 'template_image',
                                         height= 500,
                                         width= 700,
                                         scale= 1),
             displaylogo = FALSE
      )
    
    
  })
  
  # Simple reactable - see: styles.css for formatting
  output$myreactable <- renderReactable({
    reactable(example_data,
              borderless = TRUE,
              outlined = FALSE
                )
  })
  

  
}