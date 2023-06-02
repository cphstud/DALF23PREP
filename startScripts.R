library(dplyr)
library(stringr)


dkSent=read.csv("2_headword_headword_polarity.csv")

df=readRDS("fogreviews.rds")
df=readRDS("elgiganten.rds")
#
saveRDS(dkSent, "dkSenti.rds")

# Lav et subset af alle navne der begynder med stort K

dfStortK <- df %>% filter(str_detect(name,"^K"))


# indsæt række hvor navn starter med stort Å
# gammeldags måde
df[nrow(df)+1,] = c("Åse","2","15","2023-02-01","Åse sur","Var i Silvan og det var dyrt")


#Find Åse
dfÅse=df %>% filter(name=="Åse")

dfStoreBogstaver <- df %>% filter(str_detect(name,"^[A-ZÆØÅ]"))

#Test om der er en sammenhæng mellem brugere der angiver fuldt navn 
#og gennemsnitslængde på ord i reviews
pattern="[:alpha:]+ [:alpha:]+"

getLix <- function(indhold) {
  splitList = str_split(indhold," ")
  res=lapply(splitList,function(x) str_length(x))
  return(mean(res[[1]]))
}

allClever=df %>% filter(str_detect(name,pattern))
allDum=df %>% filter(!str_detect(name,pattern))
# tilføj kolonne med gnsm ordlænge
allClever <- allClever %>% rowwise()  %>% mutate(dumfactor=getLix(content))
allDum <- allDum %>% rowwise()  %>% mutate(dumfactor=getLix(content))
dfv=as.data.frame(c(mean(allClever$dumfactor),mean(allDum$dumfactor)))
dfv$iq=c("klog","dum")
colnames(dfv)=c("values","iq")

# visualisér gennemsnit klog og dum
library(ggplot2)
ggplot(dfv,aes(x=iq, y=values))+geom_bar(stat="identity")

