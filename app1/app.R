# Load packages ----------------------------------------------------------------
install.packages("fastmap")
install.packages("Rtools")
library(shiny)
library(tidyverse)
library(ggplot2)
library(fastmap)

# Load data --------------------------------------------------------------------

life_meaning_app <- read_csv("app1/data/life_meaning.csv", show_col_types = FALSE)

#Pivot longer 
life_meaning_long_app <- tidyr::gather(life_meaning_app, key = "Choice_Order", value = "Choice", -country)

# Define UI --------------------------------------------------------------------

ui <- fluidPage(
  titlePanel("Sources of meaning trends by country"),
  HTML("<i>Ranked choice among 17 topics coded as part of what gives people meaning in life</i>"),
  sidebarLayout(
    sidebarPanel(
      
      #Select variable type of trend to plot
      selectInput("countryInput", "Select a country to highlight:", choices = unique(life_meaning$country), selected = "Japan")
    ),
    mainPanel(
      plotOutput("countryPlot")
    )
  )
)

# Define server function --------------------------------------------
server <- function(input, output) {
  # Create a reactive subset of the data for the selected country
  filtered_data <- reactive({
    life_meaning_app %>%
      filter(country == input$countryInput)
  })
  
  # Reactive plot based on the selected country
  g <- ggplot(life_meaning_long_app, aes(x = Choice, fill = country))
  g+geom_bar(aes(fill=country), width = .5) +
    scale_fill_viridis_d() +
    labs(title = "Total Frequency of Life Meaning Topics by Country",
         x = "Choice Category",
         y = "Total Frequency",
         fill = "Country") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = .6))+
    theme(legend.position = "right",
          plot.title = element_text(hjust = .5, face = "bold"))
 
  })
}
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui = ui, server = server)

#Installing shinyapps.io
install.packages('rsconnect')
library(rsconnect)

rsconnect::setAccountInfo(name='t1p1qw-megan0marguerite-hokama', token='94867C5188A9800086A3B56A581EF376', secret='+9hwU5NFO91IGDaTXxs1Vs/gURVSoDB3C9cK8I7/')
