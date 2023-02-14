library(shiny)
library(ggplot2)
library(shinythemes)
library(dplyr)

server <- function(input, output) {
  
  output$Gauss <- renderPlot({
    
    ggplot(spotify_tracks, aes(x = popularity))+
      theme_bw() +
      geom_density( alpha= 0.8,  fill = "#FF6666") +
      labs( x ="Popularity of tracks",
            title = "Distribution of the popularity of tracks")
    
  })
  output$popular<- renderPlot({
    ggplot(spotify_tracks_10000, aes_string(x = input$Choice, y = 'popularity', color ='popularity'))+ geom_point() + geom_smooth(color = 'black')
    
  })
  
  output$genres <- renderPlot({
    ggplot(meangen, aes_string(x = 'genre', y = input$Choice))+ geom_bar(stat="identity", fill="steelblue")
  })
  
  output$genres2 <- renderPlot({
    ggplot(genres, aes_string(x = 'genre', y = input$Choice, color = 'genre')) +
      geom_boxplot(alpha = 0.5, notch = TRUE) +
      theme_bw() +
      labs(title = 'Genres and their danceablity', x= 'Genres', y = 'Danceability' )
    
    
  })
  
  output$text <- renderUI({
    HTML(paste("<b>DANCEABILITY</b> Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable."
               , "<b>ENERGY</b> Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy."
               , "<b>INSTRUMENTALNESS</b> Predicts whether a track contains no vocals. Ooh and 'aah' sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly 'vocal'. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0."
               , "<b>SPEECHINESS</b> Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks."
               , "<b>VALENCE</b> A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry)."
               , "<b>KEY</b> The key the track is in. Integers map to pitches using standard Pitch Class notation. E.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on."
               , "<b>LIVENESS</b> Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live."
               , "<b>LOUDNESS</b> The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate of physical strength (amplitude). Values typical range between -60 and 0 db."
               , "<b>MODE</b> Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived. Major is represented by 1 and minor is 0."
               , "<b>TEMPO</b> Overall estimated tempo of a track in beats per minute (BPM)"
               , sep="<br/>"))
  })
  output$hist <- renderPlot({
    plot_num(spotify_histograms)    
  })  
  output$inne <- renderPlot({
    plot_grid(p1, p2,p3 ,p4 ,p5 ,p6)  
  })  
  output$years <- renderPlot({
    boxplot(get(input$Choice)~year, data = spotify_dataset,
            main = "Variation:- Energy and  Genre",
            xlab = "Energy",
            ylab = "Genre",
            col = "green",
            border = "blue",
            horizontal = TRUE,
            notch = TRUE
    )
  }, height = 800) 
  
}
