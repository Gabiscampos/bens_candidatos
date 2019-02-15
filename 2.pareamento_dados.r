#leitura e padronização de colunas 
anos<-c("2018","2016", "2014", "2012", "2010", "2008", "2006")
library(tidyverse)
library(stringr)

for (ANO in anos){
  
pasta<-file.path(getwd(),ANO) #Informamos a pasta
arquivos<-list.files(pasta)[!(str_detect(list.files(pasta), "([BRASIL]{6})"))] # Identificamos todos os arquivos
arquivos<-arquivos[(str_detect(arquivos, "([0-9]{4})"))]

# Os loopings a seguir fazem a leitura dos arquivos, agregando-os e 
#retirando linhas duplicadas.

for(j in arquivos){
  print(j)
  x<-data.table::fread(file.path(pasta,j)) %>% data.frame()
  if(j==arquivos[1]){df<-x}else{df<-rbind(df,x)}
  rm(x)
}
df<- df %>% unique()

saveRDS(df, file = paste("BENS",ANO,".rds"))
}

rm(list=ls())
#abrir arquivos pareados
BENS_2018 <- readRDS("~/07. Mestrado FGV/00. CEPESP/Baixar_dados/bens_candidatos/BENS 2018 .rds")
BENS_2016 <- readRDS("~/07. Mestrado FGV/00. CEPESP/Baixar_dados/bens_candidatos/BENS 2016 .rds")
BENS_2014 <- readRDS("~/07. Mestrado FGV/00. CEPESP/Baixar_dados/bens_candidatos/BENS 2014 .rds")
BENS_2012 <- readRDS("~/07. Mestrado FGV/00. CEPESP/Baixar_dados/bens_candidatos/BENS 2012 .rds")
BENS_2010 <- readRDS("~/07. Mestrado FGV/00. CEPESP/Baixar_dados/bens_candidatos/BENS 2010 .rds")
BENS_2008 <- readRDS("~/07. Mestrado FGV/00. CEPESP/Baixar_dados/bens_candidatos/BENS 2008 .rds")
BENS_2006 <- readRDS("~/07. Mestrado FGV/00. CEPESP/Baixar_dados/bens_candidatos/BENS 2006 .rds")


names(BENS_2018)

nomes<-names(BENS_2018)
nomes<-c(nomes[1:3], nomes[7],nomes[9], nomes[12],nomes[14:19])

print(nomes)

colnames(BENS_2006)<-nomes
colnames(BENS_2008)<-nomes
colnames(BENS_2010)<-nomes
colnames(BENS_2012)<-nomes

BENS_2006[,setdiff(names(BENS_2014),names(BENS_2006))]<-NA
BENS_2014[,setdiff(names(BENS_2006),names(BENS_2014))]<-NA
BENS_2006<-BENS_2006[,names(BENS_2014)]

BENS_2008[,setdiff(names(BENS_2014),names(BENS_2008))]<-NA
BENS_2014[,setdiff(names(BENS_2008),names(BENS_2014))]<-NA
BENS_2008<-BENS_2008[,names(BENS_2014)]

BENS_2010[,setdiff(names(BENS_2014),names(BENS_2010))]<-NA
BENS_2014[,setdiff(names(BENS_2010),names(BENS_2014))]<-NA
BENS_2010<-BENS_2010[,names(BENS_2014)]


BENS_2012[,setdiff(names(BENS_2014),names(BENS_2012))]<-NA
BENS_2014[,setdiff(names(BENS_2012),names(BENS_2014))]<-NA
BENS_2012<-BENS_2012[,names(BENS_2014)]


df<-rbind(BENS_2006, BENS_2008, BENS_2010, BENS_2012, 
          BENS_2014, BENS_2016, BENS_2018)

rm(BENS_2006, BENS_2008, BENS_2010, BENS_2012, 
   BENS_2014, BENS_2016, BENS_2018)
