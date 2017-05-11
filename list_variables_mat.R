#still testing

#IMPORTANT: doesn't work when the first level of a categorical variable is "". Patch will be available by the 13/05/2017

#Inputs: Matrix or sparse matrix

#Return object list_variables:

#list_variables$class    (class of the input)
#$variable1
#$Class
#$Levels  (NULL if not factor, liste of levels if factor)
#$variable2
#$Class
#$Levels  (NULL if not factor, liste of levels if factor)

require(Matrix)

list_variables_matrix=function(base){
  require(Matrix)
  if(class(base)=="dgCMatrix"){
    pattern=attr(base,"assign")
    variables=c()
    class=c()
    racines=c()
    list_variables=c()
    names_col=c()
    list_variables=c(class(base))

    for(i in 1:(length(pattern)-1)){
      if(length(pattern[which(pattern==pattern[i])])==1){#for non factor variables
        variables=c(variables,colnames(base)[i])#find non factor variables
        names_col=c(names_col,colnames(base)[i])
        temp=list(Class="numeric",Levels=NULL)
        all=list(variable=temp)
        list_variables=c(list_variables,all)}
      
      else{#for factor variables
        pos=pattern[which(pattern==pattern[i])]#find the columns corresponding to a variable
        allnames=colnames(base)[pos]
        all_val=c()
        list_char=c()
        
        for(value in allnames){
          list_char=c(list_char,strsplit(value,""))#obtain a list of the letters of the column
        }
        size=c()
        for(value in list_char){
          y=length(unlist(value))
          size=c(size,y)#find length
        }
        stops=c()
        for(i in 1:(length(list_char)-1)){
          for(j in 1:min(size)){
            if(unlist(list_char[i])[j]!=unlist(list_char[i+1])[j]){#find the first different letter
              stops=c(stops,j-1)
              break
            }
          }
        }
        racine=paste(unlist(list_char[1])[1:min(stops)],sep="",collapse="")#create the root (name of the variable)
        if(!racine %in% racines){#check if is already in the list of variables, don't add it
          racines=c(racines,racine)
          names_col=c(names_col,racine)
          Levels=c()
          for(value in list_char){
            niv=paste(unlist(value)[(min(stops)+1):length(value)],sep="",collapse="")#find the level and add it to the levels of the variable
            Levels=c(Levels,niv)
          }
          temp=list(Class="factor",Levels=Levels)
          all=list(variable=temp)
          list_variables=c(list_variables,all)
        }
      }
      if(pattern[length(pattern)-1])==pattern[length(pattern)]){#for the last column, if not a factor
        variables=c(variables,colnames(base)[i])
        names_col=c(names_col,colnames(base)[i])
        temp=list(Class="numeric",Levels=NULL)
        all=list(variable=temp)
        list_variables=c(list_variables,all)}
    }
    names(list_variables)<-c("class",names_col)
  }
  
  if(is.matrix(base)){
    variables=c()
    class=c()
    racines=c()
    list_variables=c()
    names_col=c()
    list_variables=c(class(base))
    for(i in 1:ncol(base)){
      names_col=c(names_col,colnames(base)[i])
      if(length(unique(base[,i]))<20){
        Levels=unique(base[,i])
        temp=list(Class="factor",Levels=Levels)}
      else{
        temp=list(Class="numeric",Levels=NULL)
      }
      all=list(variable=temp)
      list_variables=c(list_variables,all)
    }
    names(list_variables)<-c("class",names_col)
  }
  setClass("list_variables",slots=c("list"))
  return(list_variables)
}
