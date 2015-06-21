if(!require("dplyr")){ install.packages("dplyr")}
if(!require("reshape2")){install.packages("reshape2")}
                         
                         #Load the dplyr & reshape2 packages within R
                         library(dplyr)
                         library(reshape2)
                         
                         subject_test<-read.table("./test/subject_test.txt", sep=" ")
                         X_test<-read.table("./test/X_test.txt",sep="")  
                         y_test<-read.table("./test/y_test.txt",sep=" ")  
                         
                         #Label these columns for later parts of the code
                         names(subject_test)<- "Subject"
                         names(y_test)<- "ActIndex"	
                         
                         #Combine the test data by column such that each row represents a subject's activity & its measurements
                         testdata<-cbind(subject_test,y_test,X_test)
                         
                         #Read in the train data from the working directory and respective folder
                         subject_train<-read.table("./train/subject_train.txt", sep=" ")
                         X_train<-read.table("./train/X_train.txt",sep="")
                         y_train<-read.table("./train/y_train.txt",sep=" ")
                         
                         #Label these columns for later parts of the code
                         names(subject_train)<- "Subject"
                         names(y_train)<- "ActIndex"
                         
                         #Combine the train data by column such that each row represents a subject's activity & its measurements
                         traindata<-cbind(subject_train, y_train ,X_train)
                         
                         #Combine the test and train data sets, stacks them on top of each other as their dimensions match in this respect to get an aggregate view of data
                         alldata<-rbind(testdata,traindata)
                         
                         
                         #Read in the features that correspond to the different measurements in the X_train & X_test data sets
                         features<-read.table("./features.txt")
                         names(features)<-c("FeatIndex","Feature")
                         features$Feature<-as.character(features$Feature)
                         
                         #Read in the Activity labels that correspond to the different activities on which measurements are recorded by subject
                         activity_labels<-read.table("./activity_labels.txt",sep=" ")
                         names(activity_labels)<-c("ActIndex", "Activity")
                         
                         
                         #Join the two sets along the common "ActIndex" column
                         alldata<-left_join(activity_labels,alldata,by="ActIndex")
                         
                         #Label the values of the combined tables
                         names(alldata)<-c(names(activity_labels),"Subject",features$Feature)
                         
                         #Selects only columns pertaining to activity, subject, and those which deal with a mean or standard deviation
                         alldata1<-alldata[,grepl("Activity|Subject|Mean|mean|std",names(alldata))]
                         
                         #Remove all the extraneous names and typographical errors
                         names(alldata1)<- gsub("\\(|\\)|-|,", "", names(alldata1))
                         names(alldata1)<- gsub("mean", "Mean", names(alldata1))
                         names(alldata1)<- gsub("std", "Std", names(alldata1))
                         names(alldata1)<- gsub("BodyBody", "Body", names(alldata1))
                         
                         #Makes the Subject column a factor variable to summarize information later
                         alldata1$Subject<-as.factor(alldata1$Subject)
                         
                         #Puts all of the data in alphabetical order by Subject & Activity
                         alldata1<-arrange(alldata1, Subject, Activity)
                         
                         #Creates a narrow form of the data by subject & each activity, along with their measurements by rows
                         meltedall<-melt(alldata1,id=c("Subject","Activity"),variable.name="Measurement",value.name="Value")
                         
                         #Summarizes the new narrow form of the data by the mean for each subject & activity
                         meltalldata_summ<-dcast(meltedall,Subject + Activity~ Measurement,mean,value.var="Value")
                         
                         #Writes the created table as a file
                         meltdata_summ<-write.table(meltalldata_summ,file="meltdata_summ.txt",row.names=FALSE)
                         
