#Inputs: datatable or dataframe



#Create an object list_variables:

#list_variables$class    (class of the input)
#$variable1
#$Class
#$Levels  (NULL if not factor, list of levels if factor)
#$variable2
#$Class
#$Levels  (NULL if not factor, list of levels if factor)



require(data.table)

list_variables_df=function(dataset){
  list_temp=c()
  list_variables=c(list(class(dataset)))
  temp=c()
  lev=c()
    if(!"data.table" %in% class(dataset)){
      dataset=data.table(dataset)
      
    }
    for(column in colnames(dataset)){
      #print(column)
      #v=grep(column, colnames(dataset))
      #print(class(dataset[[column]]))
      #print(v)
      lev=levels(dataset[[column]])
      #print(lev)
      temp=list(Class=class(dataset[[column]]),Levels=lev)
      all=list(variable=temp)
      list_variables=c(list_variables,all)
      
    }
    names(list_variables)<-c("class",colnames(dataset))
  
  setClass("list_variables",slots=c("list"))
  class(list_variables)="list_variables"
  return(list_variables)
}