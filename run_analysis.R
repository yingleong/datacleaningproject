
run_analysis<-function(){

  #combining both test and train data
  X_data<-do.call("rbind", lapply(c("UCI HAR Dataset/test/X_test.txt", "UCI HAR Dataset/train/X_train.txt"),function(fn) data.frame(read.table(fn))))
  Y_data<-do.call("rbind", lapply(c("UCI HAR Dataset/test/Y_test.txt", "UCI HAR Dataset/train/Y_train.txt"),function(fn) data.frame(read.table(fn))))
  subject_data<-do.call("rbind", lapply(c("UCI HAR Dataset/test/Subject_test.txt", "UCI HAR Dataset/train/Subject_train.txt"),function(fn) data.frame(read.table(fn))))  
  final_data<-cbind(X_data,subject=subject_data, label=Y_data)  

  #update column name based on features.txt
  X_colname<-read.table("UCI HAR Dataset/features.txt")
  X_colname$derivedColName<-paste('V',X_colname$V1, sep="")
  names(final_data)<-X_colname$V2[X_colname$derivedColName%in%names(final_data)]

  colnames(final_data)[562]<-"subject"
  colnames(final_data)[563]<-"activity"
  
  
  selectedColPatterns<-c("mean\\(", "std\\(","activity", "subject")
  final_data<-final_data[colnames(final_data)[grep(paste(selectedColPatterns,collapse="|"), colnames(final_data))]]
  
  activity_map<-read.table("UCI HAR Dataset/activity_labels.txt")
  final_data<-merge(x=final_data, y=activity_map, by.x='activity', by.y='V1')
  
  #overwriting the column name V2 as activity and remove the original activity column
  final_data<-final_data[,-which(names(final_data)%in%c('activity'))]
  colnames(final_data)[which(names(final_data) == "V2")] <- "activity"
  
  
  #summarize by Activity
  activity_final_data<- final_data[,-which(names(final_data)%in%c('subject'))]
  summarize_activity<-activity_final_data%>% group_by(activity) %>% summarise_each(funs(mean))
  

  #summarize by Subject
  subject_final_data<- final_data[,-which(names(final_data)%in%c('activity'))]
  summarize_subject<-subject_final_data%>% group_by(subject) %>% summarise_each(funs(mean))
  
  
  #summarized final_dataset
  summarize_dataset<-final_data%>% group_by(subject, activity) %>% summarise_each(funs(mean))
  write.table(summarize_dataset, file="summarize_dataset.txt", row.names=FALSE)
}