library(shiny)
library(ggplot2)
library(shinythemes)
library(dplyr)

ui <- fluidPage(theme=shinytheme("sandstone"),
                titlePanel("Spotifymusic"),
                sidebarLayout(
                  
                  # Inputs
                  sidebarPanel(width = 4,
                               selectInput(inputId = "Choice", 
                                           label = "Choice:",
                                           choices = c("duration_min", "tempo","liveness", "valence", "instrumentalness","acousticness", "speechiness", "loudness","energy","danceability" ),
                                           selected = "duration_min")
                  ),
                  
                  mainPanel(
                    tabsetPanel(type="tabs",
                                tabPanel("Zależności gatunków uśrednione", plotOutput("genres")),
                                tabPanel("Zależności gatunków", plotOutput("genres2")),
                                tabPanel("Zależności popularności", plotOutput("popular")),
                                tabPanel("Zależności inne", plotOutput("inne")),                                
                                tabPanel("Dystrybuanta popularności utworów", plotOutput("Gauss")),
                                tabPanel("Parametry vs lata", plotOutput("years")),
                                tabPanel("Dystrybuanta parametrów", plotOutput("hist")),
                                tabPanel("Opis współczynnikóW", htmlOutput("text"))
                                
                    )
                  )
                )
)
