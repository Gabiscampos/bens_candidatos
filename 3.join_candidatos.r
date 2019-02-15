#Juntar com banco de candidatos 

library(tidyverse)
library(cepespR)

#vamos usar o banco df construido em "2.pareamento_dados.r"

#Vamos utilizar os bancos do CepespData
library(cepespR)
library(dplyr)


#First we need to set the years we want to download
years_general_election<-seq(1998, 2018, 4)
years_municipal_election<-seq(2004, 2016, 4)

#Downloading candidates dataset for general election -------------------------------------------

for(j in years_general_election){
  print(j)
  x<-get_candidates(j, "President") %>% select(ANO_ELEICAO,
                                               CODIGO_CARGO,
                                               DESCRICAO_CARGO,
                                               NOME_CANDIDATO,
                                               NUMERO_CANDIDATO,
                                               NUMERO_PARTIDO,
                                               SIGLA_PARTIDO,
                                               CPF_CANDIDATO,
                                               NUM_TITULO_ELEITORAL_CANDIDATO,  
                                               COD_SIT_TOT_TURNO,
                                               DESC_SIT_TOT_TURNO)
  
  if(j==1998){candidates_president<-x}else{candidates_president<-rbind(candidates_president,x)}
  rm(x)
}

for(j in years_general_election){
  print(j)
  x<-get_candidates(j, "Governor") %>% select(ANO_ELEICAO,
                                              CODIGO_CARGO,
                                              DESCRICAO_CARGO,
                                              NOME_CANDIDATO,
                                              NUMERO_CANDIDATO,
                                              NUMERO_PARTIDO,
                                              SIGLA_PARTIDO,
                                              CPF_CANDIDATO,
                                              NUM_TITULO_ELEITORAL_CANDIDATO,  
                                              COD_SIT_TOT_TURNO,
                                              DESC_SIT_TOT_TURNO)
  if(j==1998){candidates_governor<-x}else{candidates_governor<-rbind(candidates_governor,x)}
  rm(x)
}

for(j in years_general_election){
  print(j)
  x<-get_candidates(j, "Senator") %>% select(ANO_ELEICAO,
                                             CODIGO_CARGO,
                                             DESCRICAO_CARGO,
                                             NOME_CANDIDATO,
                                             NUMERO_CANDIDATO,
                                             NUMERO_PARTIDO,
                                             SIGLA_PARTIDO,
                                             CPF_CANDIDATO,
                                             NUM_TITULO_ELEITORAL_CANDIDATO,  
                                             COD_SIT_TOT_TURNO,
                                             DESC_SIT_TOT_TURNO)
  if(j==1998){candidates_senator<-x}else{candidates_senator<-rbind(candidates_senator,x)}
  rm(x)
}

for(j in years_general_election){
  print(j)
  x<-get_candidates(j, "Federal Deputy") %>% select(ANO_ELEICAO,
                                                    CODIGO_CARGO,
                                                    DESCRICAO_CARGO,
                                                    NOME_CANDIDATO,
                                                    NUMERO_CANDIDATO,
                                                    NUMERO_PARTIDO,
                                                    SIGLA_PARTIDO,
                                                    CPF_CANDIDATO,
                                                    NUM_TITULO_ELEITORAL_CANDIDATO,  
                                                    COD_SIT_TOT_TURNO,
                                                    DESC_SIT_TOT_TURNO)
  if(j==1998){candidates_FD<-x}else{candidates_FD<-rbind(candidates_FD,x)}
  rm(x)
}

for(j in years_general_election){
  print(j)
  x<-get_candidates(j, "State Deputy") %>% select(ANO_ELEICAO,
                                                  CODIGO_CARGO,
                                                  DESCRICAO_CARGO,
                                                  NOME_CANDIDATO,
                                                  NUMERO_CANDIDATO,
                                                  NUMERO_PARTIDO,
                                                  SIGLA_PARTIDO,
                                                  CPF_CANDIDATO,
                                                  NUM_TITULO_ELEITORAL_CANDIDATO,  
                                                  COD_SIT_TOT_TURNO,
                                                  DESC_SIT_TOT_TURNO)
  if(j==1998){candidates_SD<-x}else{candidates_SD<-rbind(candidates_SD,x)}
  rm(x)
}

#Downloading candidates dataset for municipal election -------------------------------------------

for(j in years_municipal_election){
  print(j)
  x<-get_candidates(j, "Mayor") %>% select(ANO_ELEICAO,
                                           CODIGO_CARGO,
                                           DESCRICAO_CARGO,
                                           NOME_CANDIDATO,
                                           NUMERO_CANDIDATO,
                                           NUMERO_PARTIDO,
                                           SIGLA_PARTIDO,
                                           CPF_CANDIDATO,
                                           NUM_TITULO_ELEITORAL_CANDIDATO,  
                                           COD_SIT_TOT_TURNO,
                                           DESC_SIT_TOT_TURNO)
  if(j==2004){candidates_mayor<-x}else{candidates_mayor<-rbind(candidates_mayor,x)}
  rm(x)
}

for(j in years_municipal_election){
  print(j)
  x<-get_candidates(j, "Vereador") %>% select(ANO_ELEICAO,
                                              CODIGO_CARGO,
                                              DESCRICAO_CARGO,
                                              NOME_CANDIDATO,
                                              NUMERO_CANDIDATO,
                                              NUMERO_PARTIDO,
                                              SIGLA_PARTIDO,
                                              CPF_CANDIDATO,
                                              NUM_TITULO_ELEITORAL_CANDIDATO,  
                                              COD_SIT_TOT_TURNO,
                                              DESC_SIT_TOT_TURNO)
  if(j==2004){candidates_council<-x}else{candidates_council<-rbind(candidates_council,x)}
  rm(x)
}

candidates<-rbind(candidates_senator, candidates_SD, candidates_president, 
                  candidates_governor, candidates_FD, candidates_council, candidates_mayor)

rm(candidates_senator, candidates_SD, candidates_president, 
   candidates_governor, candidates_FD, candidates_council, candidates_mayor)

candidates_RAIS<-candidates %>% select(CPF_CANDIDATO) %>% 
  mutate(CPF_CANDIDATO = str_pad(CPF_CANDIDATO, 11, pad = "0")) %>% 
  distinct()

write_rds(candidates_RAIS, "candidatos.rds")
