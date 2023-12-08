# Load packages ----------------------------------------------------------------
library(shiny)
library(tidyverse)
library(ggplot2)
library(fastmap)

# Load data --------------------------------------------------------------------

life_meaning_app <- read_csv("data/life_meaning.csv", show_col_types = FALSE)

# Pivot longer 
life_meaning_long_app <- tidyr::gather(life_meaning_app, key = "Choice_Order", value = "Choice", -country)

#Shift Order
order <- c("First_Choice", "Second_Choice", "Third_Choice", "Fourth_Choice", "Fifth_Choice")

# Pivot longer 
life_meaning_long_app$Choice_Order <- factor(life_meaning_long_app$Choice_Order, levels = order)


# Define UI --------------------------------------------------------------------

ui <- fluidPage(
  titlePanel("Sources of meaning trends by country"),
  HTML("<i>Choose a country</i>"),
  sidebarLayout(
    sidebarPanel(
      # Country Input panel
      selectInput("countryInput", "Select Country", choices = unique(life_meaning_long_app$country)),
    ),
    
    # Output plot
    mainPanel(
      plotOutput("plot")
    )
  ) 
)

# Define server function --------------------------------------------
server <- function(input, output) {
  
  # Create a reactive subset of the data for the selected country
  filtered_data <- reactive({
    life_meaning_long_app %>%
      filter(country == input$countryInput)
  })
  
  # Reactive plot based on the selected country
  output$plot <- renderPlot({
    ggplot(filtered_data(), aes(x = Choice, y = Choice_Order, fill = country)) +
      geom_bar(stat = "identity", position = "dodge") +
      scale_fill_viridis_d () + 
      labs(title = paste("Total Frequency of Life Meaning Topics for", input$countryInput),
           x = "Choice Category",
           y = "Rank",
           fill = "Country") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, vjust = .6)) +
      theme(legend.position = "right",
            plot.title = element_text(hjust = .5, face = "bold"))
  })
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui = ui, server = server)

