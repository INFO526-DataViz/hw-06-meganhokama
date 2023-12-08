# Load packages ----------------------------------------------------------------

library(shiny)
library(tidyverse)
library(thematic)
library(ggplot2)
library(fastmap)
library(shinythemes)
library(ragg)

options(shiny.useragg = TRUE)
thematic_shiny(font = "auto")

# Load data -----------------------------------------------------------------
life_meaning_app <- read_csv("data/life_meaning.csv", show_col_types = FALSE)

# Pivot longer
life_meaning_long_app <- tidyr::gather(life_meaning_app, key = "Choice_Order", value = "Choice", -country)

# Shift Order
order <- c("First_Choice", "Second_Choice", "Third_Choice", "Fourth_Choice", "Fifth_Choice")
life_meaning_long_app$Choice_Order <- factor(life_meaning_long_app$Choice_Order, levels = order)

# Define UI -----------------------------------------------------------------
ui <- fluidPage(
  titlePanel("Meaning of Life Trends by Country"),
  HTML("<i>'What makes life meaningful?' trends across 17 countries</i>"),
  theme = bslib::bs_theme(
    bg = "#EEE8D5", fg = "black", primary = "#2AA198",
    # bslib also makes it easy to import CSS fonts
    base_font = bslib::font_google("Hedvig Letters Serif")
  ),
  hr(),
  br(),
  sidebarLayout(
    sidebarPanel(
      # Country Input panel
      selectInput("countryInput", "Select Country", choices = unique(life_meaning_long_app$country)),
      width = 3
    ),
    
    # Output plot
    mainPanel(
      plotOutput("plot"),
      HTML("<div style='text-align: center; font-size: 12px; color: #999999;'>Pew Research Center: 2021 Global Attitudes Survey</div>")
    )
  )
)


# Define server function -----------------------------------------------------
server <- function(input, output) {
  
  # Create a reactive subset of the data for the selected country
  filtered_data <- reactive({
    life_meaning_long_app %>%
      filter(country == input$countryInput)
  })
  
  # Reactive plot based on the selected country
  output$plot <- renderPlot({
    ggplot(filtered_data(), aes(x = country, y = Choice_Order, fill = as.factor(Choice))) +
      geom_bar(stat = "identity", position = "dodge") +
      scale_fill_manual(values = c("#D55E00", "#56B4E9", "#009E73", "#E69F00", "#F0E442")) + #Okabe-Ito color blind friendly palette
      labs(title = paste("Meaning of Life Ranked Topics for", input$countryInput),
           x = "",
           y = "Rank",
           fill = "Topics") +
      theme_minimal() +
      theme(axis.text.y = element_text(size = 10, color = "black")) +
      theme(axis.text.x = element_text(angle = 0, vjust = .6, size = 10, color = "black")) +
      theme(legend.position = "bottom",
            plot.title = element_text(hjust = .5, face = "bold", size = 20))
  })
}

# Create the Shiny app object ------------------------------------------------
shinyApp(ui = ui, server = server)