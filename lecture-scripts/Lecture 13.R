#set your working directory (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Winter 2024/Econ 106")

#libraries 
library(tidyverse)
library(tidytext) #for tokenization
data(stop_words)
library(SnowballC) # for text stemming

#data for today
taylor_swift_lyrics <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/taylor_swift_lyrics.csv')

#any mention of love
taylor_swift_lyrics_love<-taylor_swift_lyrics%>%
  mutate(contains_love=str_detect(Lyrics, "love"))


#of mentions of love
taylor_swift_lyrics_love_count<-taylor_swift_lyrics%>%
  mutate(love_counts=str_count(Lyrics, "love"))

##Class Exercise##
#count the number of times Taylor Swift uses the phrase "shake it off"


#there are functions to convert every to lower case, remove punctuation

#in which songs does she use this phrase?



#when searching for a single word, use word boundaries (\\b)
taylor_swift_lyrics_love_boundary <- taylor_swift_lyrics %>%
  mutate(counts_love=
           str_count(Lyrics, "\\blove\\b"))


#we can search for more than one word using | (count any instance of love, loving, or lover)
taylor_swift_lyrics_love_many <- taylor_swift_lyrics %>%
  mutate(contains_love_words=
           str_count(Lyrics, "\\blove\\b|\\bloving\\b|\\blover\\b"))



#create a tidy text data frame
tidy_lyrics <- taylor_swift_lyrics %>%
  unnest_tokens(output=word, input=Lyrics)

#count the top words
tidy_lyrics_count <- tidy_lyrics %>%
  count(word)%>%
arrange(desc(n))

#this time remove the stop words
tidy_lyrics_no_stop <- anti_join(x=tidy_lyrics, #left data frame
                                 y=stop_words, #right data frame
                                 by="word")  #linking variable 


#count the top 10 words
tidy_lyrics_top_ten <- tidy_lyrics_no_stop %>%
  count(word)%>%
  arrange(desc(n))%>%
  slice_head(n=10)



#put the top ten it into a bar plot
 ggplot(data=tidy_lyrics_top_ten,
         mapping=aes(x=word, y=n))+
  geom_col()
   
 #a different bar chart using geom_bar
 ggplot(data=taylor_swift_lyrics,
        mapping=aes(x=Album))+ #R counts the frequencies for you
   geom_bar()
   
 

 #put the top ten it into a bar plot (order the bars by frequency and flip it)
 ggplot(data=tidy_lyrics_top_ten,
        mapping=aes(x=reorder(word,n), y=n))+
   geom_col()+
   coord_flip()


###Exercise### 
#create a bar chart of the top ten words used in the folklore album (orderd by frequency)
 
 
 
 #create the frequency table

 
 #create a bar chart
 
 #put the top ten it into a bar plot (order the bars by frequency and flip it)
 
 
#get the stems
tidy_lyrics_stem<-tidy_lyrics_no_stop %>%
    mutate(stem = wordStem(word, "en")) #we create a new column called stem 


#create a top ten frequency table of stems
tidy_lyrics_stem_count <- tidy_lyrics_stem%>%
  count(stem) %>%
  arrange(desc(n))%>%
  slice_head(n=10)


#put the top ten it into a bar plot
   ggplot(data=tidy_lyrics_stem_count,
         mapping=aes(x=stem, y=n))+
  geom_col()+
  coord_flip()
   
   
#top ten stems for folklore
  
  
#tokenize into bigrams
tidy_lyrics_bigram <- taylor_swift_lyrics %>%
  unnest_tokens(output=bigram, input=Lyrics,
                token="ngrams", n=2)

tidy_lyrics_bigram_separated <- tidy_lyrics_bigram %>%  
  separate(bigram, into = c("word1", "word2"), sep = " ")


tidy_lyrics_bigram_no_stop <- tidy_lyrics_bigram_separated %>%
  filter(!word1 %in% stop_words$word,
         !word2 %in% stop_words$word) 

tidy_lyrics_united <-tidy_lyrics_bigram_no_stop%>%
  unite(bigram, c(word1, word2), sep = " ")

tidy_lyrics_bigram_count <- tidy_lyrics_united%>%
  count(bigram) %>%
  arrange(desc( n)) 




