##### Download dos bancos de bens do TSE --------------------------

# O looping a seguir baixa os bancos no formato oferecido pelo TSE, 
#dispondo-os em pastas dentro da pasta do projeto. Os bancos ser?o 
#divididos em pastas segundo o ano eleitoral.
anos<-c("2018","2016", "2014", "2012", "2010", "2008", "2006")

for(i in anos){
  print(paste("Baixando dados de", i))
  banco <- tempfile() #Cria uma pasta tempor?ria
  url<-"http://agencia.tse.jus.br/estatistica/sead/odsele/bem_candidato/bem_candidato_ANO.zip"
  url<-gsub("ANO", i, url)
  download.file(url, banco) #Baixa o arquivo na pasta tempor?ria:
  unzip(banco, exdir = file.path(getwd(), i)) #Baixa o arquivo no diret?rio:
  unlink(banco)
}

###
