library(funModeling)
library(readr)
library(tidyverse)
library(tidyr)
library(cowplot)

spotify_tracks <- read_csv("spotify_tracks.csv", 
                           col_types = cols(
                             ...1 = col_double(), 
                             acousticness = col_double(), 
                             album_id = col_character(), 
                             analysis_url = col_skip(),
                             artists_id = col_character(),
                             available_markets = col_character(),
                             country = col_character(),
                             danceability = col_double(),
                             disc_number = col_skip(),
                             duration_ms = col_double(),
                             energy = col_double(),
                             href = col_skip(),
                             id = col_skip(),
                             instrumentalness = col_double(),
                             key = col_double(),
                             liveness = col_double(),
                             loudness = col_double(),
                             lyrics = col_character(),
                             mode = col_double(),
                             name = col_character(),
                             playlist = col_character(),
                             popularity = col_double(),
                             preview_url = col_skip(),
                             speechiness = col_double(),
                             tempo = col_double(),
                             time_signature = col_double(),
                             track_href = col_skip(),
                             track_name_prev = col_skip(),
                             track_number = col_double(),
                             uri = col_skip(),
                             valence = col_double(),
                             type = col_skip()))
spotify_artists <- read_csv("spotify_artists.csv", 
                            col_types = cols(
                              ...1 = col_double(), 
                              artist_popularity = col_double(), 
                              followers = col_double(), 
                              genres = col_character(),
                              id = col_character(),
                              name = col_character(),
                              track_id = col_skip(),
                              track_name_prev = col_skip(),
                              type = col_skip()))
genres <- read_csv("genres.csv", 
                   col_types = cols(danceability = col_double(), 
                                    energy = col_double(), key = col_double(), 
                                    loudness = col_double(), mode = col_double(), 
                                    speechiness = col_double(), acousticness = col_double(), 
                                    instrumentalness = col_double(), 
                                    liveness = col_double(), valence = col_double(), 
                                    tempo = col_double(), type = col_skip(), 
                                    id = col_skip(), uri = col_skip(), 
                                    track_href = col_skip(), analysis_url = col_skip(), 
                                    duration_ms = col_double(), time_signature = col_double(), 
                                    genre = col_character(), song_name = col_character(), 
                                    `Unnamed: 0` = col_skip(), title = col_skip()))
spotify_dataset <- read_csv("spotify_dataset.csv", 
                            col_types = cols(valence = col_double(), 
                                             acousticness = col_double(), artists = col_skip(), 
                                             danceability = col_double(), duration_ms = col_double(), 
                                             energy = col_double(), explicit = col_skip(), 
                                             id = col_skip(), instrumentalness = col_double(), 
                                             key = col_skip(), liveness = col_double(), 
                                             loudness = col_double(), mode = col_skip(), 
                                             name = col_skip(), popularity = col_skip(), 
                                             release_date = col_skip(), speechiness = col_double(), 
                                             tempo = col_double()))
spotify_tracks_10000 <- spotify_tracks[1:10000,]
spotify_tracks$artists_id <- gsub("\\['|\\']", "", spotify_tracks$artists_id)
total <- merge(spotify_tracks,spotify_artists,by.x ="artists_id", by.y = "id")

genres<- genres %>% mutate(key = ordered(key), mode = factor(mode), time_signature=factor(time_signature),  genre = factor(genre))

genres<- genres %>% mutate(duration_sec= duration_ms/1000, duration_min= duration_ms/60000)

spotify_tracks_10000<- spotify_tracks_10000%>%mutate(duration_sec= duration_ms/1000, duration_min= duration_ms/60000)

spotify_dataset <- spotify_dataset%>%mutate(duration_sec= duration_ms/1000, duration_min= duration_ms/60000)

meangen<-genres%>%
  group_by(genre)%>%
  dplyr::summarise(duration_min = mean(duration_min),
                   tempo= mean(tempo),  
                   liveness=mean(liveness),
                   valence=mean(valence),
                   instrumentalness=mean(instrumentalness), 
                   acousticness= mean(acousticness), 
                   speechiness= mean(speechiness), 
                   loudness=mean(loudness),
                   energy= mean(energy),
                   danceability= mean(danceability))

spotify_histograms <- spotify_tracks[,c(7,8,9,10,12,13,18,19,20,23)]
plot_histogram <- plot_num(spotify_histograms)

p1<- ggplot(spotify_tracks_10000, aes(tempo,danceability)) + geom_point(color = 'red', alpha = .5, shape = 17) + geom_smooth(color = 'black')
p2<- ggplot(spotify_tracks_10000, aes(valence,loudness)) + geom_point(color = 'red', alpha = .5, shape = 17) + geom_smooth(color = 'black')
p3<- ggplot(spotify_tracks_10000, aes(valence,energy)) + geom_point(color = 'red', alpha = .5, shape = 17) + geom_smooth(color = 'black')
p4<- ggplot(spotify_tracks_10000, aes(valence,danceability)) + geom_point(color = 'red', alpha = .5, shape = 17) + geom_smooth(color = 'black')
p5<- ggplot(spotify_tracks_10000, aes(acousticness,loudness)) + geom_point(color = 'red', alpha = .5, shape = 17) + geom_smooth(color = 'black')
p6<- ggplot(spotify_tracks_10000, aes(loudness,energy)) + geom_point(color = 'red', alpha = .5, shape = 17) + geom_smooth(color = 'black')

plot_grid(p1, p2,p3 ,p4 ,p5 ,p6)
