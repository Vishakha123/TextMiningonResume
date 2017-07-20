rm(list = ls())
setwd("C:/Users/vishakha1/Documents/R/dataset/")
df<-read.table("vishakha_old_resume1.txt",fill = TRUE,encoding = "ANSI",stringsAsFactors = FALSE)
library("SnowballC")
library("tm")
library("gdata")
library("readxl")
res_stop<-read_excel("res_stopwords.xls")

res_srce <- VCorpus(VectorSource(res_stop))
txt_source <- VCorpus(VectorSource(df))

clean_source <- tm_map(txt_source,content_transformer(tolower))

clean_source<- tm_map(clean_source,removeNumbers)
clean_source <- tm_map(clean_source,removeWords,stopwords("english"))
clean_source<- tm_map(clean_source,removePunctuation)
replacePunctuation <- function(x) {gsub("[[:punct:]]+"," ",x)}
clean_source<- tm_map(clean_source,replacePunctuation)


clean_source<- tm_map(clean_source,stripWhitespace)
clean_source<- tm_map(clean_source, removeWords,res_stop$stopwords)
clean_source<-tm_map(clean_source,stemDocument)

#clean_dtm <- DocumentTermMatrix(clean_source,control = list(tolower= TRUE, removePunctuation=TRUE, stripWhitespace=TRUE, removeNumbers = TRUE, stopwords = TRUE,stemming = TRUE ))
library("wordcloud")

wordcloud(clean_source, min.freq = 3, random.order = FALSE, colors = brewer.pal(5,"Dark2"))


