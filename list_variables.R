#Matrix and sparse matrix still testing
#Further devlopment: create S4 objects to be able to use more easily the output.


#####Function list_variables----------------------------------------------------
#Return a list of list:

#list_variables$class    (class of the set)
#list_variables$Name_of_the_variable1
#list_variables$Name_of_the_variable1$Class (class of variable 1)
#list_variables$Name_of_the_variable1$Levels  (NULL not a factor, list of levels of factor)
#list_variables$Name_of_the_variable2
#list_variables$Name_of_the_variable2$Class
#list_variables$Name_of_the_variable2$Levels
#etc...

#class "list_variables" (attr class)
#Inputs: data.frame, data.table, matrix or sparse matrix
#For matrix and sparse matrix: still testing 

#Use functions list_variables_df (for dataframes and datatables), 
#and list_variables_mat (for matrix and sparse matrix)

list_variables=function(dataset){
  if(is.data.frame(dataset)){
    return(list_variables_df(dataset))
  }
  else if(class(dataset) %in% c("dgCMatrix","matrix")){
    return(list_variables_matrix(dataset))
  }
  else{
    print("Please enter a dataframe,datatable,matrix or sparse matrix")
  }
}
