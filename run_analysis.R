features <- read.table('UCI HAR Dataset/features.txt',header=FALSE)
activities <- read.table('UCI HAR Dataset/activity_labels.txt', sep=" ",header=FALSE,stringsAsFactors = FALSE)

a_map <- function (x) {
    return(activities[x,2])
    }

test <- read.table('./UCI HAR Dataset/test/X_test.txt', col.names=features[,2])
y_test <- read.table('./UCI HAR Dataset/test/y_test.txt', col.names='activity')
y_test_mapped <- lapply(y_test, a_map)

test_subject <- read.table('./UCI HAR Dataset/test/subject_test.txt', col.names='subject')

test_a <- cbind(test, y_test_mapped, test_subject)

train <- read.table('./UCI HAR Dataset/train/X_train.txt', col.names=features[,2])
y_train <- read.table('./UCI HAR Dataset/train/y_train.txt', col.names='activity')
y_train_mapped <- lapply(y_train, a_map)

train_subject <- read.table('./UCI HAR Dataset/train/subject_train.txt', col.names='subject')

train_a <- cbind(train, y_train_mapped, train_subject)

full <-rbind(test_a, train_a)

subset <- grep('std()|mean()', names(full))

tidy <- full[,c(subset, 562, 563)]


rows <- length(unique(test_subject)[,1]) * length(unique(activities)[,2])
res <- tidy[1:rows,]
i <- 1


for (s in unique(test_subject)[,1]){
    for (a in unique(activities)[,2]) {
        uniq_s_a = (tidy$subject == s) & (tidy$activity == a)

        #mean of columns
        t_res <- sapply(tidy[uniq_s_a, 1:79], mean)

        res[i,1:79] <- t_res
        res[i,80] <- a
        res[i,81] <- s
        i <- i + 1
   }
}

print(res)

warnings()
write.table(res, 'tidydata.txt', row.name=FALSE)
