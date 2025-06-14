#set your working directory (mine is below, yours will be different)

setwd("~/Dropbox/Teaching/Data analytics/Econ 106 Fall 2024/Econ 106")

#libraries 
library(tidyverse)
library(tidytext) #for tokenization
library(SnowballC) # for text stemming
library(wordcloud) #for word clouds
library(RColorBrewer) #for different color schemes
library(textdata) #for the nrc lexicon

#data for today
taylor_swift_lyrics <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-09-29/taylor_swift_lyrics.csv')

rmp<-read_csv("RateMyProfessor_Sample data.csv")

data(stop_words)

#how to convert to lowercase, remove punctuation
taylor_swift_cleaned<-taylor_swift_lyrics%>%
  mutate(lyrics_lower=str_to_lower(Lyrics), #lowercase
         lyrics_remove_punctuation=str_replace_all(lyrics_lower,"[:punct:]", "")) #remove punctuation


#create a tidy text data frame
tidy_lyrics <- taylor_swift_lyrics %>%
  unnest_tokens(output=word, input=Lyrics)



#remove the stop words
tidy_lyrics_no_stop <- anti_join(x=tidy_lyrics, y=stop_words) 

#count the top 10 words
tidy_lyrics_top_ten <- tidy_lyrics_no_stop %>%
  count(word)%>%
  arrange(desc(n))%>%
  slice_head(n=10)


#put the top ten it into a bar plot (order the bars by frequency and flip it)
ggplot(data=tidy_lyrics_top_ten,
       mapping=aes(x=reorder(word,n), y=n))+
  geom_col()+
  coord_flip()


##word clouds
  
#we're going to make a frequency table of the top 75 most frequent words, then pipe it to a word cloud
tidy_lyrics_no_stop %>%
  count(word)%>%
  arrange(desc(n))%>%
  slice_head(n=75)%>% 
  with(wordcloud(word, n))


tidy_lyrics_no_stop %>%
  count(word)%>%
  arrange(desc(n))%>%
  slice_head(n=75)%>%
  with(wordcloud(word, n, random.order = FALSE)) # we turn off the random selection of words with the random.order argument


#You can adjust the scale of the words to fit all the words
tidy_lyrics_no_stop %>%
  count(word)%>%
  arrange(desc(n))%>%
  slice_head(n=75)%>%
  with(wordcloud(word, n, random.order = FALSE, scale = c(3, 0.25)))

#we can choose colors to convey relative frequency
tidy_lyrics_no_stop %>%
  count(word)%>%
  arrange(desc(n))%>%
  slice_head(n=75)%>%
  with(wordcloud(word, n, random.order = FALSE, scale = c(3, 0.25), colors=c('green', 'purple', 'blue', 'yellow')))

#Class Exercise
#make a word cloud of the top 75 words use in Rate my Professors comments
#use the following color scale: purple, green, yellow, red
#make adjustments to the word scale so everything fits

#create a tidy text data frame


#remove the stop words


#create a word cloud


# we can also select a color palette and the number of colors we want displayed
tidy_lyrics_no_stop %>%
  count(word)%>%
  arrange(desc(n))%>%
  slice_head(n=75)%>%
  with(wordcloud(word, n, random.order = FALSE, scale = c(3, 0.25), colors = brewer.pal(4,"Dark2")))




#get sentiment lexicons
bing_lexicon<-get_sentiments(lexicon="bing")

#match our tidy lyrics to the bing sentiment lexicon (only keep words that have a sentiment)
tidy_lyrics_bing<- inner_join(x=tidy_lyrics, y=bing_lexicon)


#top positive words
bing_positive_count<-tidy_lyrics_bing%>%
  filter(sentiment=="positive")%>%
  count(word)%>%
  arrange(desc(n))%>%
  slice_head(n=10)


#Class Exercise
#Make a list of the top ten negative sentiment words the rmp comments (do not remove stop words)

#top words with their associated sentiment
bing_word_count <- tidy_lyrics_bing%>%	
  count(word, sentiment) %>%
  arrange(desc( n)) %>%
  slice_head(n=10) 



bing_word_count_each_sentiment<-tidy_lyrics_bing%>%	
  group_by(sentiment) %>%
  count(word, sentiment) %>%
  arrange(desc( n)) %>%
 slice_head( n = 10) 
  
  mutate(word = reorder(word, n)) %>%
  ggplot(data=bing_word_count_each_sentiment,
         mapping=aes(x=n, y=reorder(word,n))) +
  geom_col(aes(fill=sentiment)) +
  facet_wrap(~sentiment, scales = "free_y")



#Class Exercise
#Make a top 10 list of the most frequent words with sentiment for the rmp comments. How many are positive?
  


#we can also  count the number of words with positive sentiments and negative sentiments
bing_sentiment_count <- tidy_lyrics_bing%>%
  count(sentiment) %>%
  arrange(desc( n))



#counting positive and negative sentiments by album
bing_album_sentiment <- tidy_lyrics_bing%>%	
  group_by(Album)%>%
  count(sentiment) %>%
  arrange(Album, sentiment)


##Class Exercise
#count the number of positive and negative sentiment words by student star. 



#we can create a bar chart of sentiments by album
ggplot(data=tidy_lyrics_bing,
       mapping=aes(x=Album))+
  geom_bar(aes(fill=sentiment), position='fill')


#let's add a reference line to show the even split of sentiments (.50)
ggplot(data=tidy_lyrics_bing,
       mapping=aes(x=Album))+
  geom_bar(aes(fill=sentiment), position='fill')+
	 geom_hline(yintercept=.5)


#pivot_wider
bing_album_sentiment_wider<-bing_album_sentiment%>%
  pivot_wider(names_from=sentiment, values_from=n) #make separate columns for the positive and negative sentiment counts

#calculate net sentiment
bing_album_net_sentiment<-bing_album_sentiment_wider%>%
  mutate(net_sentiment=positive-negative)%>%
  arrange(desc(net_sentiment))


  
#get the nrc sentiment lexicons
nrc_lexicon<-get_sentiments(lexicon="nrc")

#match to nrc (many to many match because words can be more than one sentiment)
tidy_lyrics_nrc<- inner_join(x=tidy_lyrics, y=nrc_lexicon)

#top anger words
nrc_anger_count <- tidy_lyrics_nrc%>%	
  filter(sentiment=="anger")%>%
  count(word) %>%
  arrange(desc( n)) %>%
  slice_head(n=10)

  #plot the top ten anger words in a bar chart
  ggplot(data=nrc_anger_count,
         mapping=aes(x=reorder(word, n), y=n))+
  geom_col()+
  coord_flip()

