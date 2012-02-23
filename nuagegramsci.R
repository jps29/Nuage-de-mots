library("tm")
library("wordcloud")
library("RColorBrewer")
gramsci <- Corpus(DirSource(" /Documents/TravauxJPS/AnalyseTextuelle/textes/"))
 
gramsci
 
ozMatBaum <- TermDocumentMatrix(gramsci[1])
baum <- findFreqTerms(ozMatBaum, 70)
baum
 
inspect(gramsci[1])
 
gramsci <- tm_map(gramsci, stripWhitespace)
gramsci <- tm_map(gramsci, tolower)
gramsci <- tm_map(gramsci, removeWords, stopwords("french"))
 
gramsci <- tm_map(gramsci, removePunctuation)
gramsci <- tm_map(gramsci, function(x) removeWords(x, stopwords("french")))
motsAsupprimer <-c("nest","dune","quil","plus","bien","entre","cette","chez","sest","cest","lon","nont","cestàdire","dun","quils")
gramsci <- tm_map(gramsci, removeWords, motsAsupprimer)
 
 
 
ap.tdm <- TermDocumentMatrix(gramsci)
ap.m <- as.matrix(ap.tdm)
ap.v <- sort(rowSums(ap.m),decreasing=TRUE)
ap.d <- data.frame(word = names(ap.v),freq=ap.v)
table(ap.d$freq)
pal2 <- brewer.pal(8,"Dark2")
png("NuageGramsci.png", width=1280,height=800)
wordcloud(ap.d$word,ap.d$freq, scale=c(6,.2),min.freq=3,
max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()

# Fin