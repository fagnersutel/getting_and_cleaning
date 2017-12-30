caminho <- getwd()
caminho
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
dadosTreinoSubj <- data.table(read.table(file.path(caminho, pasta, 'train', 'subject_train.txt')))
dadosTesteSubj <- data.table(read.table(file.path(caminho, pasta, 'test', 'subject_test.txt')))
dadosTreinoSubj
dadosTesteSubj
dadosSubj <- rbind(dadosTreinoSubj, dadosTesteSubj)
names(dadosSubj) <- c('Subject')
remove(dadosTreinoSubj,dadosTesteSubj)

dadosTreinoAct <- data.table(read.table(file.path(caminho, pasta, 'train','Y_train.txt')))
dadosTesteAct <- data.table(read.table(file.path(caminho,pasta,'test','Y_test.txt')))
dadosAtividades <- rbind(dadosTreinoAct,dadosTesteAct)
names(dadosAtividades) <- c('Activity')
remove(dadosTreinoAct,dadosTesteAct)


dadosSubj <- cbind(dadosSubj,dadosAtividades)
remove(dadosAtividades)

dadosTreino <- data.table(read.table(file.path(caminho,pasta,'train','X_train.txt')))
dadosTeste <- data.table(read.table(file.path(caminho,pasta,'test','X_test.txt')))
tabela <- rbind(dadosTreino,dadosTeste)
remove(dadosTreino,dadosTeste)


tabela <- cbind(dadosSubj,tabela)

setkey(tabela,Subject,Activity)
remove(dadosSubj)


dadosFeatures <- data.table(read.table(file.path(caminho,pasta,'features.txt'))) 
names(dadosFeatures) <- c('ftNum','ftName')
dadosFeatures <- dadosFeatures[grepl("mean\\(\\)|std\\(\\)",ftName)]
dadosFeatures$ftCode <- paste('V', dadosFeatures$ftNum, sep = "")

tabela <- tabela[,c(key(tabela), dadosFeatures$ftCode),with=F]


setnames(tabela, old=dadosFeatures$ftCode, new=as.character(dadosFeatures$ftName))

dadosAtividadesNames <- data.table(read.table(file.path(caminho, pasta, 'activity_labels.txt')))
names(dadosAtividadesNames) <- c('Activity','ActivityName')
tabela <- merge(tabela,dadosAtividadesNames,by='Activity')
remove(dadosAtividadesNames)

dadosParaTidy <- tabela %>% group_by(Subject, ActivityName) %>% summarise_all(funs(mean))

dadosParaTidy$Activity <- NULL

write.table(dadosParaTidy, file.path(caminho, pasta, 'tidy.txt'), row.names=FALSE)
path = paste(pasta, "/tidy.txt", sep = "")
dados <- read.table(path, sep=" ", fill=FALSE, strip.white=TRUE, header = TRUE)
View(dados)
