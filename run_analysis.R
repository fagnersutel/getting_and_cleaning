setwd("/Users/fagnersuteldemoura/OneDrive/Cursos/Coursera/DataScienceSpecialization/getting and cleaning data/week4/getting_and_cleaning/")
caminho <- getwd()
caminho
library(data.table)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipado <- "Dataset.zip"
if (!file.exists(caminho)) {
    dir.create(caminho)
}
if (!file.exists(zipado)) {
    download.file(url, file.path(caminho, zipado))
}

list.files()
pasta <- 'UCI HAR Dataset'
if(!file.exists(pasta)) {
    unzip(f)
}
list.files()   
#Carrega 7352 casos
dadosTreinoSubj <- data.table(read.table(file.path(caminho, pasta, 'train', 'subject_train.txt')))
#Carrega 2947 casos
dadosTesteSubj <- data.table(read.table(file.path(caminho, pasta, 'test', 'subject_test.txt')))
dadosTreinoSubj
dadosTesteSubj
#faz o bind do data set de treino e o data set de teste
dadosSubj <- rbind(dadosTreinoSubj, dadosTesteSubj)
#totaliza 10299 casos = 2947(dadosTreinoSubj) + 7352(dadosTreinoSubj)
dadosSubj
#Muda o valor de V1 para Subject
names(dadosSubj) <- c('Subject')
#Faz um unset nos data.tables dadosTreinoSubj e dadosTesteSubj
remove(dadosTreinoSubj,dadosTesteSubj)

#Cria o data.table de treino de activity n= 7352
dadosTreinoAct <- data.table(read.table(file.path(caminho, pasta, 'train','Y_train.txt')))
dadosTreinoAct
#Cria o data.table de teste de activity n = 2947
dadosTesteAct <- data.table(read.table(file.path(caminho,pasta,'test','Y_test.txt')))
dadosTesteAct
#faz um bind de linhas de dadosTreinoAct e dadosTesteAct com n= 10299
dadosAtividades <- rbind(dadosTreinoAct,dadosTesteAct)
dadosAtividades
#Muda V1 para Activity
names(dadosAtividades) <- c('Activity')
#Faz unset nos dados de Activity
remove(dadosTreinoAct,dadosTesteAct)

#Faz um bind de colunas de dados dadosSubj e dadosAtividades
dadosSubj <- cbind(dadosSubj,dadosAtividades)
#Esvazia o data.table dadosAtividades
remove(dadosAtividades)

#Cria o data.table de treino de dim = 7352, 561
dadosTreino <- data.table(read.table(file.path(caminho,pasta,'train','X_train.txt')))
dadosTreino
#Cria o data.table de teste de dim = 2947, 561
dadosTeste <- data.table(read.table(file.path(caminho,pasta,'test','X_test.txt')))
dadosTeste
#faz um bind de linhas com n= 10299, 561
tabela <- rbind(dadosTreino,dadosTeste)
head(tabela)
#Esvazia as data.tables utilizadas para o bind
remove(dadosTreino,dadosTeste)
#Tabela recebe as duas colunas de sadosSubj e forma a nova tabela com n=10299, 563
tabela <- cbind(dadosSubj,tabela)
#Cria os indices da tabela, ordenando a mesma pelos atributos Subject e tabela
setkey(tabela,Subject,Activity)
#Esvazia dadosSubj
remove(dadosSubj)


dadosFeatures <- data.table(read.table(file.path(caminho,pasta,'features.txt'))) 
head(dadosFeatures)
#Renomeia as colunas de dadosFeatures
names(dadosFeatures) <- c('ftNum','ftName')
#Faz um filtro reduzindo o numero de linhas de 561 para 66
dadosFeatures <- dadosFeatures[grepl("mean\\(\\)|std\\(\\)",ftName)]
#Adiciona a terceira coluna concatenando V + ftNum
dadosFeatures$ftCode <- paste('V', dadosFeatures$ftNum, sep = "")
#Refina a tabela
head(tabela, 1)
tabela <- tabela[,c(key(tabela), dadosFeatures$ftCode),with=F]
head(tabela, 1)
#Renomeia as colunas
setnames(tabela, old=dadosFeatures$ftCode, new=as.character(dadosFeatures$ftName))
head(tabela)
#Cria o data.table com os nomes das atividades
dadosAtividadesNames <- data.table(read.table(file.path(caminho, pasta, 'activity_labels.txt')))
names(dadosAtividadesNames)
#Renomeia V1 e V2 para Activity e ActivityName
names(dadosAtividadesNames) <- c('Activity','ActivityName')
head(dadosAtividadesNames)
#Adiciona dadosAtividadesNames na tabela
tabela <- merge(tabela,dadosAtividadesNames,by='Activity')
remove(dadosAtividadesNames)
#Tabela passa a ter 69 atributos
head(tabela)

library(magrittr)
library(dplyr)
#Cria dados para a tabela da tidy onde Subject e ActivityName serao a primeira e segunda coluna respectivamente
dadosParaTidy <- tabela %>% group_by(Subject, ActivityName) %>% summarise_all(funs(mean))
#Elimina a coluna  Activity
dadosParaTidy$Activity <- NULL
#Cria a tabela tidy.txt
write.table(dadosParaTidy, file.path(caminho, pasta, 'tidy.txt'), row.names=FALSE)
#Indica o ponteiro de localizacao da tabela
path = paste(pasta, "/tidy.txt", sep = "")
#abre a tabela tidy.txt
dados <- read.table(path, sep=" ", fill=FALSE, strip.white=TRUE, header = TRUE)
#Visualiza os dados de tidy.txt
View(dados)
