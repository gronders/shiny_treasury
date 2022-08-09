library(shiny)
source("global.R")


# Define UI ------

shinyUI(fluidPage(
  title = 'TITLE',
  useShinyjs(),
  
  tags$head(
    tags$link(rel = 'stylesheet', type = 'text/css', href = 'styles.css'),
    tags$link(rel = 'icon', href = 'fliptrans.png'),
    tags$link(rel = 'stylesheet', href = 'https://fonts.googleapis.com/css?family=Roboto+Mono'),
    tags$link(rel = 'stylesheet', href = 'https://fonts.googleapis.com/css?family=Inter')
  ),
  tags$head(tags$script(src = 'rudderstack.js')),
  tags$style(type='text/css',
             '.shiny-output-error { visibility: hidden; }',
             '.shiny-output-error:before { visibility: hidden; }'
  ),
  
  withTags({
    header(class='top-banner',
           section(
             a(class='fs-logo', href='https://www.flipsidecrypto.com', 
               'Powered by Flipside Crypto', onclick = 'rudderstack.track("ntr-click-flipside-icon")'),
             section(class='socials',
                     a(class='twitter', href='https://twitter.com/flipsidecrypto',
                       'Twitter', onclick = 'rudderstack.track("ntr-click-twitter-icon")'),
                     a(class='linkedin', href='https://www.linkedin.com/company/flipside-crypto',
                       'LinkedIn', onclick = 'rudderstack.track("ntr-click-linkedin-icon")'),
                     a(class='discord', href='https://flipsidecrypto.com/discord',
                       'Discord', onclick = 'rudderstack.track("ntr-click-discord-icon")'),
                     a(href='https://app.flipsidecrypto.com/auth/signup/', # redirects to xyz signup
                       'Sign Up', onclick = 'rudderstack.track("ntr-click-signup-icon")')
             )
           )
    )
  }),
  
  # APP LABEL HERE -----------------------------------  
  
  withTags({
    section(class='hero',
            p("HERO IMAGE HERE"),
            h1(
              class='header', 
              'TAGLINE TITLE', 
            ),
            p('TAGLINE'),
    )
  }),
  
  # APP START HERE -----------------------------------  
  
  ## EXAMPLE INPUTS DIV ----
  div( # re-using chart classes to make smoother outlining
    class = 'chart-container',
    div(
      class = 'chart-block',
      fluidRow(
        column(3, 
               selectInput(inputId = 'selectinput',
                           label = "Select Input",
                           choices = c("a","b","c"),
                           selected = NULL, multiple = TRUE)
               ),
        column(3, 
               radioButtons(inputId = 'selectinput',
                            label = "Select Input",
                            choices = c("a","b","c"),
                            selected = NULL)
               ),
        column(3, 
               textAreaInput(inputId = "textarea",label = "Text Area", value = "area input")
               ),
        column(3, 
               textInput(inputId = "text",label = "Text", value = "text input")
               )
      ),
      fluidRow(
        column(3, 
               dateInput(inputId = 'selectdate',
                         label = "Select Date",
                         value = Sys.Date(),
                         min = Sys.Date()- 100,
                         max = Sys.Date() + 100)
        ),
        column(3, 
               dateRangeInput(inputId = "daterange",
                              label = "Date Range",
                              start = Sys.Date()-1,
                              end = Sys.Date()+1,
                              min = Sys.Date()- 100,
                              max = Sys.Date() + 100)
        ),
        column(3, 
               numericInput(inputId = "numericinput",
                            label = "Number",
                            value = 1,
                            min = -10,
                            max = 10,
                            step = 1)
        ),
        column(3, 
               checkboxGroupInput(inputId = 'checkboxgroup',
                                  label = "Checkbox Group",
                                  choices = c(1,2,3),
                                  selected = 1,
                                  choiceNames = c("One","Two","Three"))
        )
      )
      
    )),
  
  
  ## EXAMPLE PLOTLY Scatterplot CHART ---- 
  
  div(
    class = 'chart-container',
    div(
      class = 'chart-block',
      div(class = 'chart-title', span('SCATTERPLOT EXAMPLE')),
      div(
        class = 'chart',
        plotlyOutput('exscatter')
      )
    )
  ),
  
  # EXAMPLE PLOTLY Barplot CHART ----
  
  div(
    class = 'chart-container',
    div(
      class = 'chart-block',
      div(class = 'chart-title', span('BARPLOT EXAMPLE')),
      div(
        class = 'chart',
        plotlyOutput('exbar')
      )
    )
  ),
  
  # EXAMPLE FORM DIV

  
  # EXAMPLE REACTABLE TABLE DIV ----
   # re-using chart classes to make smoother 
  div(
    class = 'chart-container',
    div(
      class = 'chart-block',
      div(class = 'chart-title', span('Reactable Table EXAMPLE')),
              reactableOutput("myreactable")
      )
    )
  
  # EXAMPLE WALLET CONNECT DIV ----
 
  
  
) # end FluidPage
) # end shinyUI