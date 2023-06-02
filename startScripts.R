library(dplyr)
library(stringr)


dkSent=read.csv("2_headword_headword_polarity.csv")

df=readRDS("fogreviews.rds")
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
