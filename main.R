library(dplyr)

#file1 <- read.csv(file.choose(), stringsAsFactors = FALSE)

path = "~/SampleFiles/"
merge_column <- "position" 



files <- list.files(path) 
column_name <- vector()
data_type <- vector()


dataframe_design <- function(files, column_name, data_type){
  for(csv in 1:length(files)){
    file <- read.csv(paste0(path, files[csv]), stringsAsFactors = FALSE)
    names(file) <- toupper(names(file))
    for(column in 1:length(file)){
      if(!(names(file)[column] %in% column_name)){
        column_name <- append(column_name, names(file)[column])
        data_type <- append(data_type, typeof(file[1,column]))    
      }
      else{
        print(paste0(names(file)[column], " is already on the list."))
      }
    }
      
    }
  columns <- data.frame("column_name" <- column_name, "data_type" <- data_type, stringsAsFactors = FALSE)
  return(columns)
}

files_merge <- function(files, columns, merge_column){
  max <- 1
  max_file <- files[1]
  for(csv in 1:length(files)){
    file <- read.csv(paste0(path, files[csv]), stringsAsFactors = FALSE)
    if(length(file[1])>max){
      max <- length(file[1])
      max_file <- file
    }
  }
    for(field in 1:length(max_file)){
      if(names(max_file)[field] %in% names(columns)){
        columns[which(names(columns)==names(max_file)[field])] <- max_file[field]
      }
    }
}


columns <- dataframe_design(files, column_name, data_type)
merge_column <- toupper(merge_column)
final_result <- files_merge(files, columns, merge_column)
